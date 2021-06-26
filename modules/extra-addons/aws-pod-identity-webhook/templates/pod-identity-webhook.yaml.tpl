apiVersion: v1
kind: ServiceAccount
metadata:
  name: ${service_name}
  namespace: ${namespace}
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: ${service_name}
rules:
- apiGroups:
  - ""
  resources:
  - serviceaccounts
  verbs:
  - get
  - watch
  - list
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: ${service_name}
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: ${service_name}
subjects:
- kind: ServiceAccount
  name: ${service_name}
  namespace: ${namespace}
---
apiVersion: v1
kind: Secret
metadata:
  name: ${service_name}
  namespace: ${namespace}
type: Opaque
data:
  tls.crt: ${tls_crt}
  tls.key: ${tls_key}
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: ${service_name}
  namespace: ${namespace}
spec:
  replicas: 1
  selector:
    matchLabels:
      app: ${service_name}
  template:
    metadata:
      labels:
        app: ${service_name}
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
      serviceAccountName: ${service_name}
      containers:
      - name: ${service_name}
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
          - name: cert
            mountPath: "/etc/webhook/certs"
            readOnly: true
      volumes:
        - name: cert
          secret:
            secretName: ${service_name}
---
apiVersion: v1
kind: Service
metadata:
  name: ${service_name}
  namespace: ${namespace}
  annotations:
    prometheus.io/port: "443"
    prometheus.io/scheme: "https"
    prometheus.io/scrape: "true"
spec:
  ports:
  - port: 443
    targetPort: 443
  selector:
    app: ${service_name}
---
apiVersion: admissionregistration.k8s.io/v1beta1
kind: MutatingWebhookConfiguration
metadata:
  name: ${service_name}
  namespace: ${namespace}
webhooks:
- name: ${service_name}.amazonaws.com
  failurePolicy: Ignore
  clientConfig:
    service:
      name: ${service_name}
      namespace: ${namespace}
      path: "/mutate"
    caBundle: ${ca_bundle}
  rules:
  - operations: [ "CREATE" ]
    apiGroups: [""]
    apiVersions: ["v1"]
    resources: ["pods"]