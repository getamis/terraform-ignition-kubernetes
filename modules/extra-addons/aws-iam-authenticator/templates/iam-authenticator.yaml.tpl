apiVersion: v1
kind: ServiceAccount
metadata:
  name: aws-iam-authenticator
  namespace: kube-system
---
kind: ClusterRole
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: aws-iam-authenticator
rules:
- apiGroups:
  - iamauthenticator.k8s.aws
  resources:
  - iamidentitymappings
  verbs:
  - get
  - list
  - watch
- apiGroups:
  - iamauthenticator.k8s.aws
  resources:
  - iamidentitymappings/status
  verbs:
  - patch
  - update
- apiGroups:
  - ""
  resources:
  - events
  verbs:
  - create
  - update
  - patch
- apiGroups:
  - ""
  resources:
  - configmaps
  verbs:
  - list
  - watch
- apiGroups:
  - ""
  resources:
  - configmaps
  resourceNames:
  - aws-auth
  verbs:
  - get
---
kind: ClusterRoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: aws-iam-authenticator
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: aws-iam-authenticator
subjects:
- kind: ServiceAccount
  name: aws-iam-authenticator
  namespace: kube-system
---
apiVersion: apps/v1
kind: DaemonSet
metadata:
  namespace: kube-system
  name: aws-iam-authenticator
  labels:
    k8s-app: aws-iam-authenticator
spec:
  selector:
    matchLabels:
      k8s-app: aws-iam-authenticator
  updateStrategy:
    type: RollingUpdate
  template:
    metadata:
      annotations:
        scheduler.alpha.kubernetes.io/critical-pod: ""
      labels:
        k8s-app: aws-iam-authenticator
    spec:
      serviceAccountName: aws-iam-authenticator
      hostNetwork: true
      nodeSelector:
        node-role.kubernetes.io/master: ""
      tolerations:
      - effect: NoSchedule
        key: node-role.kubernetes.io/master
      - key: CriticalAddonsOnly
        operator: Exists
      containers:
      - name: aws-iam-authenticator
        image: ${image}
        args:
        - server
        - --cluster-id=${cluster_name} 
        - --state-dir=/var/aws-iam-authenticator
        - --generate-kubeconfig=/etc/kubernetes/aws-iam-authenticator/kubeconfig
%{ for flag, value in flags ~}
%{ if value != "" ~}
        - --${flag}=${value}
%{ endif ~}
%{ endfor ~}
        resources:
          requests:
            memory: 64Mi
            cpu: 10m
          limits:
            memory: 64Mi
            cpu: 100m
        volumeMounts:
        - name: state
          mountPath: /var/aws-iam-authenticator/
        - name: output
          mountPath: /etc/kubernetes/aws-iam-authenticator/
        - name: tmp
          mountPath: /tmp
      volumes:
      - name: state
        hostPath:
          path: ${cert_path}
      - name: output
        hostPath:
          path: ${kubeconfig_dir_path}
      - name: tmp
        emptyDir: {}
---
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  name: iamidentitymappings.iamauthenticator.k8s.aws
spec:
  group: iamauthenticator.k8s.aws
  scope: Cluster
  names:
    plural: iamidentitymappings
    singular: iamidentitymapping
    kind: IAMIdentityMapping
    categories:
    - all
  versions:
    - name: v1alpha1
      served: true
      storage: true
      schema:
        openAPIV3Schema:
          type: object
          properties:
            spec:
              type: object
              required:
              - arn
              - username
              properties:
                arn:
                  type: string
                username:
                  type: string
                groups:
                  type: array
                  items:
                    type: string
            status:
              type: object
              properties:
                canonicalARN:
                  type: string
                userID:
                  type: string
      subresources:
        status: {}