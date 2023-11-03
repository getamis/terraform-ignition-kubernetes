apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    component: kube-scheduler
    tier: control-plane
  name: kube-scheduler
  namespace: kube-system
spec:
  containers:
  - name: kube-scheduler
    image: ${image}
    command:
    - kube-scheduler
    - --bind-address=0.0.0.0
    - --authentication-kubeconfig=${kubeconfig}
    - --authorization-kubeconfig=${kubeconfig}
    - --kubeconfig=${kubeconfig}
%{ for flag, value in extra_flags ~}
%{ if value != "" ~}
    - --${flag}=${value}
%{ endif ~}
%{ endfor ~}
    - --v=${log_level}
    imagePullPolicy: IfNotPresent
    livenessProbe:
      failureThreshold: 8
      httpGet:
        host: 127.0.0.1
        path: /healthz
        port: 10259
        scheme: HTTPS
      initialDelaySeconds: 15
      timeoutSeconds: 15
    resources:
%{ if resources["cpu_request"] != "" || resources["memory_request"] != "" ~}
      requests:
%{ if resources["cpu_request"] != "" ~}
        cpu: ${resources["cpu_request"]}
%{ endif ~}
%{ if resources["memory_request"] != "" ~}
        memory: ${resources["memory_request"]}
%{ endif ~}
%{ endif ~}
%{ if resources["cpu_limit"] != "" || resources["memory_limit"] != "" ~}
      limits:
%{ if resources["cpu_limit"] != "" ~}
        cpu: ${resources["cpu_limit"]}
%{ endif ~}
%{ if resources["memory_limit"] != "" ~}
        memory: ${resources["memory_limit"]}
%{ endif ~}
%{ endif ~}
    volumeMounts:
    - mountPath: ${kubeconfig}
      name: kubeconfig
      readOnly: true
  hostNetwork: true
  priorityClassName: system-cluster-critical
  volumes:
  - hostPath:
      path: ${kubeconfig}
      type: FileOrCreate
    name: kubeconfig
status: {}