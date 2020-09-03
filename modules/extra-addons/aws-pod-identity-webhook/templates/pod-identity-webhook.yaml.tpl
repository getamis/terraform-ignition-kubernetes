apiVersion: v1
kind: ServiceAccount
metadata:
  name: pod-identity-webhook
  namespace: kube-system
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: pod-identity-webhook
rules:
- apiGroups:
  - ""
  resources:
  - secrets
  verbs:
  - create
- apiGroups:
  - ""
  resources:
  - secrets
  verbs:
  - get
  - update
  - patch
  resourceNames:
  - "pod-identity-webhook"
- apiGroups:
  - ""
  resources:
  - serviceaccounts
  verbs:
  - get
  - watch
  - list
- apiGroups:
  - certificates.k8s.io
  resources:
  - certificatesigningrequests
  verbs:
  - create
  - get
  - list
  - watch
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: pod-identity-webhook
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: pod-identity-webhook
subjects:
- kind: ServiceAccount
  name: pod-identity-webhook
  namespace: kube-system
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: pod-identity-webhook
  namespace: kube-system
spec:
  replicas: 1
  selector:
    matchLabels:
      app: pod-identity-webhook
  template:
    metadata:
      labels:
        app: pod-identity-webhook
    spec:
%{ if located_control_plane ~}
      nodeSelector:
        node-role.kubernetes.io/master: ""
      tolerations:
      - effect: NoSchedule
        key: node-role.kubernetes.io/master
      - key: CriticalAddonsOnly
        operator: Exists
%{ endif ~}
      serviceAccountName: pod-identity-webhook
      containers:
      - name: pod-identity-webhook
        image: ${image}
        imagePullPolicy: Always
        command:
        - /webhook
%{ for flag, value in flags ~}
%{ if value != "" ~}
        - --${flag}=${value}
%{ endif ~}
%{ endfor ~}
        volumeMounts:
        - name: webhook-certs
          mountPath: /var/run/app/certs
          readOnly: false
%{ if tls_cert != "" && tls_key != "" ~}
        - name: external-webhook-certs
          mountPath: /etc/webhook/certs
          readOnly: true
%{ endif ~}
      volumes:
      - name: webhook-certs
        emptyDir: {}
%{ if tls_cert != "" && tls_key != "" ~}
      - name: external-webhook-certs
        hostPath:
          path: ${pki_path}
          type: DirectoryOrCreate
%{ endif ~}
---
apiVersion: v1
kind: Service
metadata:
  name: pod-identity-webhook
  namespace: kube-system
  annotations:
    prometheus.io/port: "443"
    prometheus.io/scheme: "https"
    prometheus.io/scrape: "true"
spec:
  ports:
  - port: 443
    targetPort: 443
  selector:
    app: pod-identity-webhook 
---
apiVersion: admissionregistration.k8s.io/v1beta1
kind: MutatingWebhookConfiguration
metadata:
  name: pod-identity-webhook
  namespace: kube-system
webhooks:
- name: pod-identity-webhook.amazonaws.com
  failurePolicy: Ignore
  clientConfig:
    service:
      name: pod-identity-webhook
      namespace: kube-system
      path: "/mutate"
    caBundle: ${ca_bundle}
  rules:
  - operations: [ "CREATE" ]
    apiGroups: [""]
    apiVersions: ["v1"]
    resources: ["pods"]