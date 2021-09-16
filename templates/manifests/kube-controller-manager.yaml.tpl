apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    component: kube-controller-manager
    tier: control-plane
  name: kube-controller-manager
  namespace: kube-system
spec:
  containers:
  - name: kube-controller-manager
    image: ${image}
    command:
    - kube-controller-manager
    - --bind-address=127.0.0.1
    - --authentication-kubeconfig=${kubeconfig}
    - --authorization-kubeconfig=${kubeconfig}
    - --kubeconfig=${kubeconfig}
    - --root-ca-file=${pki_path}/ca.crt
    - --client-ca-file=${pki_path}/ca.crt
    - --cluster-signing-cert-file=${pki_path}/ca.crt
    - --cluster-signing-key-file=${pki_path}/ca.key
    - --requestheader-client-ca-file=${pki_path}/front-proxy-ca.crt
    - --service-account-private-key-file=${pki_path}/sa.key
%{ if cluster_cidr != "" ~}
    - --cluster-cidr=${cluster_cidr}
%{ endif ~}
%{ if service_cidr != "" ~}
    - --service-cluster-ip-range=${service_cidr}
%{ endif ~}
%{ if cloud_provider != "" ~}
    - --cloud-provider=${cloud_provider}
    ${cloud_config_flag}
%{ endif ~}
%{ for flag, value in extra_flags ~}
%{ if value != "" ~}
    - --${flag}=${value}
%{ endif ~}
%{ endfor ~}
    imagePullPolicy: IfNotPresent
    livenessProbe:
      failureThreshold: 8
      httpGet:
        host: 127.0.0.1
        path: /healthz
        port: 10257
        scheme: HTTPS
      initialDelaySeconds: 15
      timeoutSeconds: 15
    resources:
      requests:
        cpu: 200m
    securityContext:
      privileged: true
    volumeMounts:
    - mountPath: /usr/libexec/kubernetes/kubelet-plugins/volume/exec
      name: flexvolume-dir
    - mountPath: ${pki_path}
      name: k8s-certs
      readOnly: true
    - mountPath: ${kubeconfig}
      name: kubeconfig
      readOnly: true
  hostNetwork: true
  priorityClassName: system-cluster-critical
  volumes:
  - hostPath:
      path: /opt/libexec/kubernetes/kubelet-plugins/volume/exec
      type: DirectoryOrCreate
    name: flexvolume-dir
  - hostPath:
      path: ${pki_path}
      type: DirectoryOrCreate
    name: k8s-certs
  - hostPath:
      path: ${kubeconfig}
      type: FileOrCreate
    name: kubeconfig
status: {}