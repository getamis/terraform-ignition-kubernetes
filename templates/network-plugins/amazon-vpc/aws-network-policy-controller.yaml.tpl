---
apiVersion: v1
kind: ServiceAccount
metadata:
  labels:
    app.kubernetes.io/component: rbac
    app.kubernetes.io/instance: controller
    app.kubernetes.io/name: amazon-network-policy-controller-k8s
    app.kubernetes.io/part-of: amazon-network-policy-controller-k8s
  name: amazon-network-policy-controller-k8s
  namespace: kube-system
---
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  labels:
    app.kubernetes.io/name: amazon-network-policy-controller-k8s
  name: amazon-network-policy-controller-k8s
  namespace: kube-system
rules:
- apiGroups:
  - ""
  resourceNames:
  - amazon-vpc-cni
  resources:
  - configmaps
  verbs:
  - get
  - list
  - watch
---
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  labels:
    app.kubernetes.io/component: rbac
    app.kubernetes.io/created-by: amazon-network-policy-controller-k8s
    app.kubernetes.io/instance: leader-election-role
    app.kubernetes.io/managed-by: kustomize
    app.kubernetes.io/name: amazon-network-policy-controller-k8s
    app.kubernetes.io/part-of: amazon-network-policy-controller-k8s
  name: amazon-network-policy-controller-k8s-leader-election-role
  namespace: kube-system
rules:
- apiGroups:
  - coordination.k8s.io
  resources:
  - leases
  verbs:
  - create
- apiGroups:
  - coordination.k8s.io
  resourceNames:
  - amazon-network-policy-controller-k8s
  resources:
  - leases
  verbs:
  - get
  - update
  - patch
- apiGroups:
  - ""
  resources:
  - events
  verbs:
  - create
  - patch
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  labels:
    app.kubernetes.io/name: amazon-network-policy-controller-k8s
  name: amazon-network-policy-controller-k8s
rules:
- apiGroups:
  - ""
  resources:
  - namespaces
  verbs:
  - get
  - list
  - watch
- apiGroups:
  - ""
  resources:
  - pods
  verbs:
  - get
  - list
  - watch
- apiGroups:
  - ""
  resources:
  - services
  verbs:
  - get
  - list
  - watch
- apiGroups:
  - networking.k8s.aws
  resources:
  - policyendpoints
  verbs:
  - create
  - delete
  - get
  - list
  - patch
  - update
  - watch
- apiGroups:
  - networking.k8s.aws
  resources:
  - policyendpoints/finalizers
  verbs:
  - update
- apiGroups:
  - networking.k8s.aws
  resources:
  - policyendpoints/status
  verbs:
  - get
  - patch
  - update
- apiGroups:
  - networking.k8s.io
  resources:
  - networkpolicies
  verbs:
  - get
  - list
  - patch
  - update
  - watch
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  labels:
    app.kubernetes.io/component: rbac
    app.kubernetes.io/created-by: amazon-network-policy-controller-k8s
    app.kubernetes.io/instance: configmap-rolebinding
    app.kubernetes.io/managed-by: kustomize
    app.kubernetes.io/name: amazon-network-policy-controller-k8s
    app.kubernetes.io/part-of: amazon-network-policy-controller-k8s
  name: amazon-network-policy-controller-k8s-rolebinding
  namespace: kube-system
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: amazon-network-policy-controller-k8s
subjects:
- kind: ServiceAccount
  name: amazon-network-policy-controller-k8s
  namespace: kube-system
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  labels:
    app.kubernetes.io/component: rbac
    app.kubernetes.io/created-by: amazon-network-policy-controller-k8s
    app.kubernetes.io/instance: leader-election-rolebinding
    app.kubernetes.io/managed-by: kustomize
    app.kubernetes.io/name: amazon-network-policy-controller-k8s
    app.kubernetes.io/part-of: amazon-network-policy-controller-k8s
  name: amazon-network-policy-leader-election-rolebinding
  namespace: kube-system
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: amazon-network-policy-controller-k8s-leader-election-role
subjects:
- kind: ServiceAccount
  name: amazon-network-policy-controller-k8s
  namespace: kube-system
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  labels:
    app.kubernetes.io/component: rbac
    app.kubernetes.io/created-by: amazon-network-policy-controller-k8s
    app.kubernetes.io/instance: controller-rolebinding
    app.kubernetes.io/managed-by: kustomize
    app.kubernetes.io/name: amazon-network-policy-controller-k8s
    app.kubernetes.io/part-of: amazon-network-policy-controller-k8s
  name: amazon-network-policy-controller-k8s-rolebinding
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: amazon-network-policy-controller-k8s
subjects:
- kind: ServiceAccount
  name: amazon-network-policy-controller-k8s
  namespace: kube-system
---
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app.kubernetes.io/component: controller
    app.kubernetes.io/name: amazon-network-policy-controller-k8s
  name: amazon-network-policy-controller-k8s
  namespace: kube-system
spec:
  replicas: 1
  selector:
    matchLabels:
      app.kubernetes.io/component: controller
      app.kubernetes.io/name: amazon-network-policy-controller-k8s
  template:
    metadata:
      annotations:
        kubectl.kubernetes.io/default-container: controller
      labels:
        app.kubernetes.io/component: controller
        app.kubernetes.io/name: amazon-network-policy-controller-k8s
    spec:
      containers:
      - args:
        - --enable-configmap-check=false
        image: "${image}"
        livenessProbe:
          httpGet:
            path: /healthz
            port: 8081
          initialDelaySeconds: 15
          periodSeconds: 20
        name: controller
        readinessProbe:
          httpGet:
            path: /readyz
            port: 8081
          initialDelaySeconds: 5
          periodSeconds: 10
        securityContext:
          allowPrivilegeEscalation: false
          capabilities:
            drop:
            - ALL
      serviceAccountName: amazon-network-policy-controller-k8s
      terminationGracePeriodSeconds: 10
