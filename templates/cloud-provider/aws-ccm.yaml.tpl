apiVersion: v1
kind: ServiceAccount
metadata:
  name: cloud-controller-manager
  namespace: kube-system
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: system:cloud-controller-manager
rules:
- apiGroups:
  - ""
  resources:
  - events
  verbs:
  - create
  - patch
  - update
- apiGroups:
  - ""
  resources:
  - nodes
  verbs:
  - '*'
- apiGroups:
  - ""
  resources:
  - nodes/status
  verbs:
  - patch
- apiGroups:
  - ""
  resources:
  - services
  verbs:
  - list
  - patch
  - update
  - watch
- apiGroups:
  - ""
  resources:
  - services/status
  verbs:
  - list
  - patch
  - update
  - watch
- apiGroups:
  - ""
  resources:
  - serviceaccounts
  verbs:
  - create
- apiGroups:
  - ""
  resources:
  - persistentvolumes
  verbs:
  - get
  - list
  - update
  - watch
- apiGroups:
  - ""
  resources:
  - endpoints
  verbs:
  - create
  - get
  - list
  - watch
  - update
- apiGroups:
  - coordination.k8s.io
  resources:
  - leases
  verbs:
  - create
  - get
  - list
  - watch
  - update
- apiGroups:
  - ""
  resources:
  - serviceaccounts/token
  verbs:
  - create
- apiGroups:
  - authentication.k8s.io
  resources:
  - tokenreviews
  verbs:
  - create
- apiGroups:
  - authorization.k8s.io
  resources:
  - subjectaccessreviews
  verbs:
  - create
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: cloud-controller-manager:apiserver-authentication-reader
  namespace: kube-system
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: extension-apiserver-authentication-reader
subjects:
- apiGroup: ""
  kind: ServiceAccount
  name: cloud-controller-manager
  namespace: kube-system
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: system:cloud-controller-manager
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: system:cloud-controller-manager
subjects:
- apiGroup: ""
  kind: ServiceAccount
  name: cloud-controller-manager
  namespace: kube-system
---
apiVersion: apps/v1
kind: DaemonSet
metadata:
  labels:
    k8s-app: aws-cloud-controller-manager
  name: aws-cloud-controller-manager
  namespace: kube-system
spec:
  selector:
    matchLabels:
      k8s-app: aws-cloud-controller-manager
  template:
    metadata:
      labels:
        k8s-app: aws-cloud-controller-manager
    spec:
      containers:
      - args:
        - --v=${log_level}
        - --cloud-provider=aws
        - --use-service-account-credentials=${use_service_account_credentials}
        - --configure-cloud-routes=${configure_cloud_routes}
        imagePullPolicy: Always
        image: ${image}
        name: aws-cloud-controller-manager
        resources:
          requests:
            cpu: 200m
      # We speculatively set hostNetwork to true for the AWS CCM to connect to the AWS API
      # https://shazi.info/amazon-eks-pod-%E5%AD%98%E5%8F%96-imdsv2-%E7%95%B0%E5%B8%B8%E7%B7%A9%E6%85%A2%E8%99%95%E7%90%86/
      hostNetwork: true
      nodeSelector:
        node-role.kubernetes.io/master: ""
      serviceAccountName: cloud-controller-manager
      tolerations:
      - effect: NoSchedule
        key: node.cloudprovider.kubernetes.io/uninitialized
        value: "true"
      - effect: NoSchedule
        key: node-role.kubernetes.io/master
  updateStrategy:
    type: RollingUpdate