---
# Source: cilium/templates/cilium-agent/serviceaccount.yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: "cilium"
  namespace: kube-system
---
# Source: cilium/templates/cilium-operator/serviceaccount.yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: "cilium-operator"
  namespace: kube-system
---
# Source: cilium/templates/hubble-relay/serviceaccount.yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: "hubble-relay"
  namespace: kube-system
---
# Source: cilium/templates/hubble/tls-cronjob/serviceaccount.yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: "hubble-generate-certs"
  namespace: kube-system
---
# Source: cilium/templates/cilium-configmap.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: cilium-config
  namespace: kube-system
data:

  # Identity allocation mode selects how identities are shared between cilium
  # nodes by setting how they are stored. The options are "crd" or "kvstore".
  # - "crd" stores identities in kubernetes as CRDs (custom resource definition).
  #   These can be queried with:
  #     kubectl get ciliumid
  # - "kvstore" stores identities in an etcd kvstore, that is
  #   configured below. Cilium versions before 1.6 supported only the kvstore
  #   backend. Upgrades from these older cilium versions should continue using
  #   the kvstore by commenting out the identity-allocation-mode below, or
  #   setting it to "kvstore".
  identity-allocation-mode: crd
  identity-heartbeat-timeout: "30m0s"
  identity-gc-interval: "15m0s"
  cilium-endpoint-gc-interval: "5m0s"
  nodes-gc-interval: "5m0s"
  skip-cnp-status-startup-clean: "false"

  # If you want to run cilium in debug mode change this value to true
  debug: "true"
  # The agent can be put into the following three policy enforcement modes
  # default, always and never.
  # https://docs.cilium.io/en/latest/security/policy/intro/#policy-enforcement-modes
  enable-policy: "default"
  # If you want metrics enabled in all of your Cilium agents, set the port for
  # which the Cilium agents will have their metrics exposed.
  # This option deprecates the "prometheus-serve-addr" in the
  # "cilium-metrics-config" ConfigMap
  # NOTE that this will open the port on ALL nodes where Cilium pods are
  # scheduled.
  prometheus-serve-addr: ":9962"
  # Port to expose Envoy metrics (e.g. "9964"). Envoy metrics listener will be disabled if this
  # field is not set.
  proxy-prometheus-port: "9964"

  # Enable IPv4 addressing. If enabled, all endpoints are allocated an IPv4
  # address.
  enable-ipv4: "true"

  # Enable IPv6 addressing. If enabled, all endpoints are allocated an IPv6
  # address.
  enable-ipv6: "false"
  # Users who wish to specify their own custom CNI configuration file must set
  # custom-cni-conf to "true", otherwise Cilium may overwrite the configuration.
  custom-cni-conf: "false"
  enable-bpf-clock-probe: "true"
  # If you want cilium monitor to aggregate tracing for packets, set this level
  # to "low", "medium", or "maximum". The higher the level, the less packets
  # that will be seen in monitor output.
  monitor-aggregation: medium

  # The monitor aggregation interval governs the typical time between monitor
  # notification events for each allowed connection.
  #
  # Only effective when monitor aggregation is set to "medium" or higher.
  monitor-aggregation-interval: "5s"

  # The monitor aggregation flags determine which TCP flags which, upon the
  # first observation, cause monitor notifications to be generated.
  #
  # Only effective when monitor aggregation is set to "medium" or higher.
  monitor-aggregation-flags: all
  # Specifies the ratio (0.0-1.0] of total system memory to use for dynamic
  # sizing of the TCP CT, non-TCP CT, NAT and policy BPF maps.
  bpf-map-dynamic-size-ratio: "0.0025"
  # bpf-policy-map-max specifies the maximum number of entries in endpoint
  # policy map (per endpoint)
  bpf-policy-map-max: "16384"
  # bpf-lb-map-max specifies the maximum number of entries in bpf lb service,
  # backend and affinity maps.
  bpf-lb-map-max: "65536"
  bpf-lb-external-clusterip: "false"

  # Pre-allocation of map entries allows per-packet latency to be reduced, at
  # the expense of up-front memory allocation for the entries in the maps. The
  # default value below will minimize memory usage in the default installation;
  # users who are sensitive to latency may consider setting this to "true".
  #
  # This option was introduced in Cilium 1.4. Cilium 1.3 and earlier ignore
  # this option and behave as though it is set to "true".
  #
  # If this value is modified, then during the next Cilium startup the restore
  # of existing endpoints and tracking of ongoing connections may be disrupted.
  # As a result, reply packets may be dropped and the load-balancing decisions
  # for established connections may change.
  #
  # If this option is set to "false" during an upgrade from 1.3 or earlier to
  # 1.4 or later, then it may cause one-time disruptions during the upgrade.
  preallocate-bpf-maps: "false"

  # Regular expression matching compatible Istio sidecar istio-proxy
  # container image names
  sidecar-istio-proxy-image: "cilium/istio_proxy"

  # Name of the cluster. Only relevant when building a mesh of clusters.
  cluster-name: default
  # Unique ID of the cluster. Must be unique across all conneted clusters and
  # in the range of 1 and 255. Only relevant when building a mesh of clusters.
  cluster-id: "0"

  # Encapsulation mode for communication between nodes
  # Possible values:
  #   - disabled
  #   - vxlan (default)
  #   - geneve
  routing-mode: "tunnel"
  tunnel-protocol: "vxlan"


  # Enables L7 proxy for L7 policy enforcement and visibility
  enable-l7-proxy: "true"

  enable-ipv4-masquerade: "true"
  enable-ipv4-big-tcp: "false"
  enable-ipv6-big-tcp: "false"
  enable-ipv6-masquerade: "false"

  enable-xt-socket-fallback: "true"
  install-no-conntrack-iptables-rules: "false"

  auto-direct-node-routes: "false"
  enable-local-redirect-policy: "false"

  kube-proxy-replacement: "strict"
  kube-proxy-replacement-healthz-bind-address: ""
  bpf-lb-sock: "false"
  enable-health-check-nodeport: "true"
  node-port-bind-protection: "true"
  enable-auto-protect-node-port-range: "true"
  enable-svc-source-range-check: "true"
  enable-l2-neigh-discovery: "true"
  arping-refresh-period: "30s"
  enable-k8s-networkpolicy: "true"
  # Tell the agent to generate and write a CNI configuration file
  write-cni-conf-when-ready: /host/etc/cni/net.d/05-cilium.conflist
  cni-exclusive: "true"
  cni-log-file: "/var/run/cilium/cilium-cni.log"
  cni-uninstall: "true"
  enable-endpoint-health-checking: "true"
  enable-health-checking: "true"
  enable-well-known-identities: "false"
  enable-remote-node-identity: "true"
  synchronize-k8s-nodes: "true"
  operator-api-serve-addr: "127.0.0.1:9234"
  # Enable Hubble gRPC service.
  enable-hubble: "true"
  # UNIX domain socket for Hubble server to listen to.
  hubble-socket-path: "/var/run/cilium/hubble.sock"
  # An additional address for Hubble server to listen to (e.g. ":4244").
  hubble-listen-address: ":4244"
  hubble-disable-tls: "false"
  hubble-tls-cert-file: /var/lib/cilium/tls/hubble/server.crt
  hubble-tls-key-file: /var/lib/cilium/tls/hubble/server.key
  hubble-tls-client-ca-files: /var/lib/cilium/tls/hubble/client-ca.crt
  ipam: "cluster-pool"
  ipam-cilium-node-update-rate: "15s"
  cluster-pool-ipv4-cidr: "${cluster_cidr}"
  cluster-pool-ipv4-mask-size: "${cluster_mask_size}"
  disable-cnp-status-updates: "true"
  cnp-node-status-gc-interval: "0s"
  egress-gateway-reconciliation-trigger-interval: "1s"
  enable-vtep: "false"
  vtep-endpoint: ""
  vtep-cidr: ""
  vtep-mask: ""
  vtep-mac: ""
  enable-bgp-control-plane: "false"
  bpf-root: "/sys/fs/bpf"
  cgroup-root: "/run/cilium/cgroupv2"
  enable-k8s-terminating-endpoint: "true"
  enable-sctp: "false"
  annotate-k8s-node: "true"
  k8s-client-qps: "5"
  k8s-client-burst: "10"
  remove-cilium-node-taints: "true"
  set-cilium-node-taints: "true"
  set-cilium-is-up-condition: "true"
  unmanaged-pod-watcher-interval: "15"
  tofqdns-dns-reject-response-code: "refused"
  tofqdns-enable-dns-compression: "true"
  tofqdns-endpoint-max-ip-per-hostname: "50"
  tofqdns-idle-connection-grace-period: "0s"
  tofqdns-max-deferred-connection-deletes: "10000"
  tofqdns-min-ttl: "3600"
  tofqdns-proxy-response-max-delay: "100ms"
  agent-not-ready-taint-key: "node.cilium.io/agent-not-ready"

  mesh-auth-enabled: "true"
  mesh-auth-queue-size: "1024"
  mesh-auth-rotated-identities-queue-size: "1024"
  mesh-auth-gc-interval: "5m0s"

  proxy-connect-timeout: "2"
  proxy-max-requests-per-connection: "0"
  proxy-max-connection-duration-seconds: "0"

  external-envoy-proxy: "false"
---
# Source: cilium/templates/hubble-relay/configmap.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: hubble-relay-config
  namespace: kube-system
data:
  config.yaml: |
    cluster-name: default
    peer-service: "hubble-peer.kube-system.svc.cluster.local:443"
    listen-address: :4245
    gops: true
    gops-port: "9893"
    dial-timeout: 
    retry-timeout: 
    sort-buffer-len-max: 
    sort-buffer-drain-timeout: 
    tls-hubble-client-cert-file: /var/lib/hubble-relay/tls/client.crt
    tls-hubble-client-key-file: /var/lib/hubble-relay/tls/client.key
    tls-hubble-server-ca-files: /var/lib/hubble-relay/tls/hubble-server-ca.crt
    disable-server-tls: true
---
# Source: cilium/templates/cilium-agent/clusterrole.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: cilium
  labels:
    app.kubernetes.io/part-of: cilium
rules:
- apiGroups:
  - networking.k8s.io
  resources:
  - networkpolicies
  verbs:
  - get
  - list
  - watch
- apiGroups:
  - discovery.k8s.io
  resources:
  - endpointslices
  verbs:
  - get
  - list
  - watch
- apiGroups:
  - ""
  resources:
  - namespaces
  - services
  - pods
  - endpoints
  - nodes
  verbs:
  - get
  - list
  - watch
- apiGroups:
  - ""
  resources:
  - nodes/status
  verbs:
  # To annotate the k8s node with Cilium's metadata
  - patch
- apiGroups:
  - apiextensions.k8s.io
  resources:
  - customresourcedefinitions
  verbs:
  - list
  - watch
  # This is used when validating policies in preflight. This will need to stay
  # until we figure out how to avoid "get" inside the preflight, and then
  # should be removed ideally.
  - get
- apiGroups:
  - cilium.io
  resources:
  - ciliumloadbalancerippools
  - ciliumbgppeeringpolicies
  - ciliumclusterwideenvoyconfigs
  - ciliumclusterwidenetworkpolicies
  - ciliumegressgatewaypolicies
  - ciliumendpoints
  - ciliumendpointslices
  - ciliumenvoyconfigs
  - ciliumidentities
  - ciliumlocalredirectpolicies
  - ciliumnetworkpolicies
  - ciliumnodes
  - ciliumnodeconfigs
  - ciliumcidrgroups
  - ciliuml2announcementpolicies
  - ciliumpodippools
  verbs:
  - list
  - watch
- apiGroups:
  - cilium.io
  resources:
  - ciliumidentities
  - ciliumendpoints
  - ciliumnodes
  verbs:
  - create
- apiGroups:
  - cilium.io
  # To synchronize garbage collection of such resources
  resources:
  - ciliumidentities
  verbs:
  - update
- apiGroups:
  - cilium.io
  resources:
  - ciliumendpoints
  verbs:
  - delete
  - get
- apiGroups:
  - cilium.io
  resources:
  - ciliumnodes
  - ciliumnodes/status
  verbs:
  - get
  - update
- apiGroups:
  - cilium.io
  resources:
  - ciliumnetworkpolicies/status
  - ciliumclusterwidenetworkpolicies/status
  - ciliumendpoints/status
  - ciliumendpoints
  - ciliuml2announcementpolicies/status
  verbs:
  - patch
---
# Source: cilium/templates/cilium-operator/clusterrole.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: cilium-operator
  labels:
    app.kubernetes.io/part-of: cilium
rules:
- apiGroups:
  - ""
  resources:
  - pods
  verbs:
  - get
  - list
  - watch
  # to automatically delete [core|kube]dns pods so that are starting to being
  # managed by Cilium
  - delete
- apiGroups:
  - ""
  resources:
  - nodes
  verbs:
  - list
  - watch
- apiGroups:
  - ""
  resources:
  # To remove node taints
  - nodes
  # To set NetworkUnavailable false on startup
  - nodes/status
  verbs:
  - patch
- apiGroups:
  - discovery.k8s.io
  resources:
  - endpointslices
  verbs:
  - get
  - list
  - watch
- apiGroups:
  - ""
  resources:
  # to perform LB IP allocation for BGP
  - services/status
  verbs:
  - update
  - patch
- apiGroups:
  - ""
  resources:
  # to check apiserver connectivity
  - namespaces
  verbs:
  - get
  - list
  - watch
- apiGroups:
  - ""
  resources:
  # to perform the translation of a CNP that contains `ToGroup` to its endpoints
  - services
  - endpoints
  verbs:
  - get
  - list
  - watch
- apiGroups:
  - cilium.io
  resources:
  - ciliumnetworkpolicies
  - ciliumclusterwidenetworkpolicies
  verbs:
  # Create auto-generated CNPs and CCNPs from Policies that have 'toGroups'
  - create
  - update
  - deletecollection
  # To update the status of the CNPs and CCNPs
  - patch
  - get
  - list
  - watch
- apiGroups:
  - cilium.io
  resources:
  - ciliumnetworkpolicies/status
  - ciliumclusterwidenetworkpolicies/status
  verbs:
  # Update the auto-generated CNPs and CCNPs status.
  - patch
  - update
- apiGroups:
  - cilium.io
  resources:
  - ciliumendpoints
  - ciliumidentities
  verbs:
  # To perform garbage collection of such resources
  - delete
  - list
  - watch
- apiGroups:
  - cilium.io
  resources:
  - ciliumidentities
  verbs:
  # To synchronize garbage collection of such resources
  - update
- apiGroups:
  - cilium.io
  resources:
  - ciliumnodes
  verbs:
  - create
  - update
  - get
  - list
  - watch
    # To perform CiliumNode garbage collector
  - delete
- apiGroups:
  - cilium.io
  resources:
  - ciliumnodes/status
  verbs:
  - update
- apiGroups:
  - cilium.io
  resources:
  - ciliumendpointslices
  - ciliumenvoyconfigs
  verbs:
  - create
  - update
  - get
  - list
  - watch
  - delete
  - patch
- apiGroups:
  - apiextensions.k8s.io
  resources:
  - customresourcedefinitions
  verbs:
  - create
  - get
  - list
  - watch
- apiGroups:
  - apiextensions.k8s.io
  resources:
  - customresourcedefinitions
  verbs:
  - update
  resourceNames:
  - ciliumloadbalancerippools.cilium.io
  - ciliumbgppeeringpolicies.cilium.io
  - ciliumclusterwideenvoyconfigs.cilium.io
  - ciliumclusterwidenetworkpolicies.cilium.io
  - ciliumegressgatewaypolicies.cilium.io
  - ciliumendpoints.cilium.io
  - ciliumendpointslices.cilium.io
  - ciliumenvoyconfigs.cilium.io
  - ciliumexternalworkloads.cilium.io
  - ciliumidentities.cilium.io
  - ciliumlocalredirectpolicies.cilium.io
  - ciliumnetworkpolicies.cilium.io
  - ciliumnodes.cilium.io
  - ciliumnodeconfigs.cilium.io
  - ciliumcidrgroups.cilium.io
  - ciliuml2announcementpolicies.cilium.io
  - ciliumpodippools.cilium.io
- apiGroups:
  - cilium.io
  resources:
  - ciliumloadbalancerippools
  - ciliumpodippools
  verbs:
  - get
  - list
  - watch
- apiGroups:
    - cilium.io
  resources:
    - ciliumpodippools
  verbs:
    - create
- apiGroups:
  - cilium.io
  resources:
  - ciliumloadbalancerippools/status
  verbs:
  - patch
# For cilium-operator running in HA mode.
#
# Cilium operator running in HA mode requires the use of ResourceLock for Leader Election
# between multiple running instances.
# The preferred way of doing this is to use LeasesResourceLock as edits to Leases are less
# common and fewer objects in the cluster watch "all Leases".
- apiGroups:
  - coordination.k8s.io
  resources:
  - leases
  verbs:
  - create
  - get
  - update
---
# Source: cilium/templates/hubble/tls-cronjob/clusterrole.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: hubble-generate-certs
  labels:
    app.kubernetes.io/part-of: cilium
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
    resourceNames:
      - hubble-server-certs
      - hubble-relay-client-certs
      - hubble-relay-server-certs
    verbs:
      - update
  - apiGroups:
      - ""
    resources:
      - secrets
    resourceNames:
      - cilium-ca
    verbs:
      - get
      - update
---
# Source: cilium/templates/cilium-agent/clusterrolebinding.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: cilium
  labels:
    app.kubernetes.io/part-of: cilium
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cilium
subjects:
- kind: ServiceAccount
  name: "cilium"
  namespace: kube-system
---
# Source: cilium/templates/cilium-operator/clusterrolebinding.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: cilium-operator
  labels:
    app.kubernetes.io/part-of: cilium
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cilium-operator
subjects:
- kind: ServiceAccount
  name: "cilium-operator"
  namespace: kube-system
---
# Source: cilium/templates/hubble/tls-cronjob/clusterrolebinding.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: hubble-generate-certs
  labels:
    app.kubernetes.io/part-of: cilium
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: hubble-generate-certs
subjects:
- kind: ServiceAccount
  name: "hubble-generate-certs"
  namespace: kube-system
---
# Source: cilium/templates/cilium-agent/role.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: cilium-config-agent
  namespace: kube-system
  labels:
    app.kubernetes.io/part-of: cilium
rules:
- apiGroups:
  - ""
  resources:
  - configmaps
  verbs:
  - get
  - list
  - watch
---
# Source: cilium/templates/cilium-agent/rolebinding.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: cilium-config-agent
  namespace: kube-system
  labels:
    app.kubernetes.io/part-of: cilium
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: cilium-config-agent
subjects:
  - kind: ServiceAccount
    name: "cilium"
    namespace: kube-system
---
# Source: cilium/templates/cilium-agent/service.yaml
apiVersion: v1
kind: Service
metadata:
  name: cilium-agent
  namespace: kube-system
  annotations:
    prometheus.io/scrape: "true"
    prometheus.io/port: "9964"
  labels:
    k8s-app: cilium
    app.kubernetes.io/name: cilium-agent
    app.kubernetes.io/part-of: cilium
spec:
  clusterIP: None
  type: ClusterIP
  selector:
    k8s-app: cilium
  ports:
  - name: envoy-metrics
    port: 9964
    protocol: TCP
    targetPort: envoy-metrics
---
# Source: cilium/templates/hubble-relay/service.yaml
kind: Service
apiVersion: v1
metadata:
  name: hubble-relay
  namespace: kube-system
  labels:
    k8s-app: hubble-relay
    app.kubernetes.io/name: hubble-relay
    app.kubernetes.io/part-of: cilium
spec:
  type: "ClusterIP"
  selector:
    k8s-app: hubble-relay
  ports:
  - protocol: TCP
    port: 80
    targetPort: 4245
---
# Source: cilium/templates/hubble/peer-service.yaml
apiVersion: v1
kind: Service
metadata:
  name: hubble-peer
  namespace: kube-system
  labels:
    k8s-app: cilium
    app.kubernetes.io/part-of: cilium
    app.kubernetes.io/name: hubble-peer
spec:
  selector:
    k8s-app: cilium
  ports:
  - name: peer-service
    port: 443
    protocol: TCP
    targetPort: 4244
  internalTrafficPolicy: Local
---
# Source: cilium/templates/cilium-agent/daemonset.yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: cilium
  namespace: kube-system
  labels:
    k8s-app: cilium
    app.kubernetes.io/part-of: cilium
    app.kubernetes.io/name: cilium-agent
spec:
  selector:
    matchLabels:
      k8s-app: cilium
  updateStrategy:
    rollingUpdate:
      maxUnavailable: 2
    type: RollingUpdate
  template:
    metadata:
      annotations:
        prometheus.io/port: "9962"
        prometheus.io/scrape: "true"
      labels:
        k8s-app: cilium
        app.kubernetes.io/name: cilium-agent
        app.kubernetes.io/part-of: cilium
    spec:
      containers:
      - name: cilium-agent
        image: "${agent_repo}:${agent_tag}"
        imagePullPolicy: IfNotPresent
        command:
        - cilium-agent
        args:
        - --config-dir=/tmp/cilium/config-map
        startupProbe:
          httpGet:
            host: "127.0.0.1"
            path: /healthz
            port: 9879
            scheme: HTTP
            httpHeaders:
            - name: "brief"
              value: "true"
          failureThreshold: 105
          periodSeconds: 2
          successThreshold: 1
        livenessProbe:
          httpGet:
            host: "127.0.0.1"
            path: /healthz
            port: 9879
            scheme: HTTP
            httpHeaders:
            - name: "brief"
              value: "true"
          periodSeconds: 30
          successThreshold: 1
          failureThreshold: 10
          timeoutSeconds: 5
        readinessProbe:
          httpGet:
            host: "127.0.0.1"
            path: /healthz
            port: 9879
            scheme: HTTP
            httpHeaders:
            - name: "brief"
              value: "true"
          periodSeconds: 30
          successThreshold: 1
          failureThreshold: 3
          timeoutSeconds: 5
        env:
        - name: K8S_NODE_NAME
          valueFrom:
            fieldRef:
              apiVersion: v1
              fieldPath: spec.nodeName
        - name: CILIUM_K8S_NAMESPACE
          valueFrom:
            fieldRef:
              apiVersion: v1
              fieldPath: metadata.namespace
        - name: CILIUM_CLUSTERMESH_CONFIG
          value: /var/lib/cilium/clustermesh/
        - name: KUBERNETES_SERVICE_HOST
          value: "${apiserver_host}"
        - name: KUBERNETES_SERVICE_PORT
          value: "${apiserver_port}"
        lifecycle:
          preStop:
            exec:
              command:
              - /cni-uninstall.sh
        resources:
          requests:
            cpu: 100m
            memory: 512Mi
        ports:
        - name: peer-service
          containerPort: 4244
          hostPort: 4244
          protocol: TCP
        - name: prometheus
          containerPort: 9962
          hostPort: 9962
          protocol: TCP
        - name: envoy-metrics
          containerPort: 9964
          hostPort: 9964
          protocol: TCP
        securityContext:
          privileged: true
        terminationMessagePolicy: FallbackToLogsOnError
        volumeMounts:
        - name: bpf-maps
          mountPath: /sys/fs/bpf
          mountPropagation: Bidirectional
        - name: cilium-run
          mountPath: /var/run/cilium
        - name: etc-cni-netd
          mountPath: /host/etc/cni/net.d
        - name: clustermesh-secrets
          mountPath: /var/lib/cilium/clustermesh
          readOnly: true
          # Needed to be able to load kernel modules
        - name: lib-modules
          mountPath: /lib/modules
          readOnly: true
        - name: xtables-lock
          mountPath: /run/xtables.lock
        - name: hubble-tls
          mountPath: /var/lib/cilium/tls/hubble
          readOnly: true
        - name: tmp
          mountPath: /tmp
      initContainers:
      - name: config
        image: "${agent_repo}:${agent_tag}"
        imagePullPolicy: IfNotPresent
        command:
        - cilium
        - build-config
        env:
        - name: K8S_NODE_NAME
          valueFrom:
            fieldRef:
              apiVersion: v1
              fieldPath: spec.nodeName
        - name: CILIUM_K8S_NAMESPACE
          valueFrom:
            fieldRef:
              apiVersion: v1
              fieldPath: metadata.namespace
        - name: KUBERNETES_SERVICE_HOST
          value: "${apiserver_host}"
        - name: KUBERNETES_SERVICE_PORT
          value: "${apiserver_port}"
        volumeMounts:
        - name: tmp
          mountPath: /tmp
        terminationMessagePolicy: FallbackToLogsOnError
      # Required to mount cgroup2 filesystem on the underlying Kubernetes node.
      # We use nsenter command with host's cgroup and mount namespaces enabled.
      - name: mount-cgroup
        image: "${agent_repo}:${agent_tag}"
        imagePullPolicy: IfNotPresent
        env:
        - name: CGROUP_ROOT
          value: /run/cilium/cgroupv2
        - name: BIN_PATH
          value: /opt/cni/bin
        command:
        - sh
        - -ec
        # The statically linked Go program binary is invoked to avoid any
        # dependency on utilities like sh and mount that can be missing on certain
        # distros installed on the underlying host. Copy the binary to the
        # same directory where we install cilium cni plugin so that exec permissions
        # are available.
        - |
          cp /usr/bin/cilium-mount /hostbin/cilium-mount;
          nsenter --cgroup=/hostproc/1/ns/cgroup --mount=/hostproc/1/ns/mnt "$BIN_PATH/cilium-mount" $CGROUP_ROOT;
          rm /hostbin/cilium-mount
        volumeMounts:
        - name: hostproc
          mountPath: /hostproc
        - name: cni-path
          mountPath: /hostbin
        terminationMessagePolicy: FallbackToLogsOnError
        securityContext:
          privileged: true
      - name: apply-sysctl-overwrites
        image: "${agent_repo}:${agent_tag}"
        imagePullPolicy: IfNotPresent
        env:
        - name: BIN_PATH
          value: /opt/cni/bin
        command:
        - sh
        - -ec
        # The statically linked Go program binary is invoked to avoid any
        # dependency on utilities like sh that can be missing on certain
        # distros installed on the underlying host. Copy the binary to the
        # same directory where we install cilium cni plugin so that exec permissions
        # are available.
        - |
          cp /usr/bin/cilium-sysctlfix /hostbin/cilium-sysctlfix;
          nsenter --mount=/hostproc/1/ns/mnt "$BIN_PATH/cilium-sysctlfix";
          rm /hostbin/cilium-sysctlfix
        volumeMounts:
        - name: hostproc
          mountPath: /hostproc
        - name: cni-path
          mountPath: /hostbin
        terminationMessagePolicy: FallbackToLogsOnError
        securityContext:
          privileged: true
      - name: clean-cilium-state
        image: "${agent_repo}:${agent_tag}"
        imagePullPolicy: IfNotPresent
        command:
        - /init-container.sh
        env:
        - name: CILIUM_ALL_STATE
          valueFrom:
            configMapKeyRef:
              name: cilium-config
              key: clean-cilium-state
              optional: true
        - name: CILIUM_BPF_STATE
          valueFrom:
            configMapKeyRef:
              name: cilium-config
              key: clean-cilium-bpf-state
              optional: true
        - name: KUBERNETES_SERVICE_HOST
          value: "${apiserver_host}"
        - name: KUBERNETES_SERVICE_PORT
          value: "${apiserver_port}"
        terminationMessagePolicy: FallbackToLogsOnError
        securityContext:
          privileged: true
        volumeMounts:
        - name: bpf-maps
          mountPath: /sys/fs/bpf
          # Required to mount cgroup filesystem from the host to cilium agent pod
        - name: cilium-cgroup
          mountPath: /run/cilium/cgroupv2
          mountPropagation: HostToContainer
        - name: cilium-run
          mountPath: /var/run/cilium
        resources:
          requests:
            cpu: 100m
            memory: 100Mi # wait-for-kube-proxy
      # Install the CNI binaries in an InitContainer so we don't have a writable host mount in the agent
      - name: install-cni-binaries
        image: "${agent_repo}:${agent_tag}"
        imagePullPolicy: IfNotPresent
        command:
          - "/install-plugin.sh"
        resources:
          requests:
            cpu: 100m
            memory: 10Mi
        securityContext:
          privileged: true
          capabilities:
            drop:
              - ALL
        terminationMessagePolicy: FallbackToLogsOnError
        volumeMounts:
          - name: cni-path
            mountPath: /host/opt/cni/bin # .Values.cni.install
      restartPolicy: Always
      priorityClassName: system-node-critical
      serviceAccount: "cilium"
      serviceAccountName: "cilium"
      automountServiceAccountToken: true
      terminationGracePeriodSeconds: 1
      hostNetwork: true
      affinity:
        podAntiAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
          - labelSelector:
              matchLabels:
                k8s-app: cilium
            topologyKey: kubernetes.io/hostname
      nodeSelector:
        kubernetes.io/os: linux
      tolerations:
        - operator: Exists
      volumes:
        # For sharing configuration between the "config" initContainer and the agent
      - name: tmp
        emptyDir: {}
        # To keep state between restarts / upgrades
      - name: cilium-run
        hostPath:
          path: /var/run/cilium
          type: DirectoryOrCreate
        # To keep state between restarts / upgrades for bpf maps
      - name: bpf-maps
        hostPath:
          path: /sys/fs/bpf
          type: DirectoryOrCreate
      # To mount cgroup2 filesystem on the host
      - name: hostproc
        hostPath:
          path: /proc
          type: Directory
      # To keep state between restarts / upgrades for cgroup2 filesystem
      - name: cilium-cgroup
        hostPath:
          path: /run/cilium/cgroupv2
          type: DirectoryOrCreate
      # To install cilium cni plugin in the host
      - name: cni-path
        hostPath:
          path:  /opt/cni/bin
          type: DirectoryOrCreate
        # To install cilium cni configuration in the host
      - name: etc-cni-netd
        hostPath:
          path: /etc/cni/net.d
          type: DirectoryOrCreate
        # To be able to load kernel modules
      - name: lib-modules
        hostPath:
          path: /lib/modules
        # To access iptables concurrently with other processes (e.g. kube-proxy)
      - name: xtables-lock
        hostPath:
          path: /run/xtables.lock
          type: FileOrCreate
        # To read the clustermesh configuration
      - name: clustermesh-secrets
        projected:
          # note: the leading zero means this number is in octal representation: do not remove it
          defaultMode: 0400
          sources:
          - secret:
              name: cilium-clustermesh
              optional: true
              # note: items are not explicitly listed here, since the entries of this secret
              # depend on the peers configured, and that would cause a restart of all agents
              # at every addition/removal. Leaving the field empty makes each secret entry
              # to be automatically projected into the volume as a file whose name is the key.
          - secret:
              name: clustermesh-apiserver-remote-cert
              optional: true
              items:
              - key: tls.key
                path: common-etcd-client.key
              - key: tls.crt
                path: common-etcd-client.crt
              - key: ca.crt
                path: common-etcd-client-ca.crt
      - name: hubble-tls
        projected:
          # note: the leading zero means this number is in octal representation: do not remove it
          defaultMode: 0400
          sources:
          - secret:
              name: hubble-server-certs
              optional: true
              items:
              - key: tls.crt
                path: server.crt
              - key: tls.key
                path: server.key
              - key: ca.crt
                path: client-ca.crt
---
# Source: cilium/templates/cilium-operator/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: cilium-operator
  namespace: kube-system
  labels:
    io.cilium/app: operator
    name: cilium-operator
    app.kubernetes.io/part-of: cilium
    app.kubernetes.io/name: cilium-operator
spec:
  # See docs on ServerCapabilities.LeasesResourceLock in file pkg/k8s/version/version.go
  # for more details.
  replicas: 2
  selector:
    matchLabels:
      io.cilium/app: operator
      name: cilium-operator
  # ensure operator update on single node k8s clusters, by using rolling update with maxUnavailable=100% in case
  # of one replica and no user configured Recreate strategy.
  # otherwise an update might get stuck due to the default maxUnavailable=50% in combination with the
  # podAntiAffinity which prevents deployments of multiple operator replicas on the same node.
  strategy:
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 1
    type: RollingUpdate
  template:
    metadata:
      annotations:
        # ensure pods roll when configmap updates
        cilium.io/cilium-configmap-checksum: "a4f27fe415571092c38fa3a18181dcd6733f7443aac58abf65cde4c781c044b9"
      labels:
        io.cilium/app: operator
        name: cilium-operator
        app.kubernetes.io/part-of: cilium
        app.kubernetes.io/name: cilium-operator
    spec:
      containers:
      - name: cilium-operator
        image: "${operator_repo}-generic:${operator_tag}"
        imagePullPolicy: IfNotPresent
        command:
        - cilium-operator-generic
        args:
        - --config-dir=/tmp/cilium/config-map
        - --debug=$(CILIUM_DEBUG)
        env:
        - name: K8S_NODE_NAME
          valueFrom:
            fieldRef:
              apiVersion: v1
              fieldPath: spec.nodeName
        - name: CILIUM_K8S_NAMESPACE
          valueFrom:
            fieldRef:
              apiVersion: v1
              fieldPath: metadata.namespace
        - name: CILIUM_DEBUG
          valueFrom:
            configMapKeyRef:
              key: debug
              name: cilium-config
              optional: true
        - name: KUBERNETES_SERVICE_HOST
          value: "${apiserver_host}"
        - name: KUBERNETES_SERVICE_PORT
          value: "${apiserver_port}"
        livenessProbe:
          httpGet:
            host: "127.0.0.1"
            path: /healthz
            port: 9234
            scheme: HTTP
          initialDelaySeconds: 60
          periodSeconds: 10
          timeoutSeconds: 3
        readinessProbe:
          httpGet:
            host: "127.0.0.1"
            path: /healthz
            port: 9234
            scheme: HTTP
          initialDelaySeconds: 0
          periodSeconds: 5
          timeoutSeconds: 3
          failureThreshold: 5
        volumeMounts:
        - name: cilium-config-path
          mountPath: /tmp/cilium/config-map
          readOnly: true
        terminationMessagePolicy: FallbackToLogsOnError
      hostNetwork: true
      restartPolicy: Always
      priorityClassName: system-cluster-critical
      serviceAccount: "cilium-operator"
      serviceAccountName: "cilium-operator"
      automountServiceAccountToken: true
      # In HA mode, cilium-operator pods must not be scheduled on the same
      # node as they will clash with each other.
      affinity:
        podAntiAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
          - labelSelector:
              matchLabels:
                io.cilium/app: operator
            topologyKey: kubernetes.io/hostname
      nodeSelector:
        kubernetes.io/os: linux
      tolerations:
        - operator: Exists
      volumes:
        # To read the configuration from the config map
      - name: cilium-config-path
        configMap:
          name: cilium-config
---
# Source: cilium/templates/hubble-relay/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: hubble-relay
  namespace: kube-system
  labels:
    k8s-app: hubble-relay
    app.kubernetes.io/name: hubble-relay
    app.kubernetes.io/part-of: cilium
spec:
  replicas: 1
  selector:
    matchLabels:
      k8s-app: hubble-relay
  strategy:
    rollingUpdate:
      maxUnavailable: 1
    type: RollingUpdate
  template:
    metadata:
      annotations:
      labels:
        k8s-app: hubble-relay
        app.kubernetes.io/name: hubble-relay
        app.kubernetes.io/part-of: cilium
    spec:
      securityContext:
        fsGroup: 65532
      containers:
        - name: hubble-relay
          securityContext:
            capabilities:
              drop:
              - ALL
            runAsGroup: 65532
            runAsNonRoot: true
            runAsUser: 65532
          image: "${hubble_relay_repo}:${hubble_relay_tag}"
          imagePullPolicy: IfNotPresent
          command:
            - hubble-relay
          args:
            - serve
            - --debug
          ports:
            - name: grpc
              containerPort: 4245
          readinessProbe:
            tcpSocket:
              port: grpc
          livenessProbe:
            tcpSocket:
              port: grpc
          resources:
            limits:
              cpu: 1000m
              memory: 1024M
            requests:
              cpu: 100m
              memory: 64Mi
          volumeMounts:
          - name: config
            mountPath: /etc/hubble-relay
            readOnly: true
          - name: tls
            mountPath: /var/lib/hubble-relay/tls
            readOnly: true
          terminationMessagePolicy: FallbackToLogsOnError
      restartPolicy: Always
      priorityClassName: 
      serviceAccount: "hubble-relay"
      serviceAccountName: "hubble-relay"
      automountServiceAccountToken: false
      terminationGracePeriodSeconds: 1
      affinity:
        podAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
          - labelSelector:
              matchLabels:
                k8s-app: cilium
            topologyKey: kubernetes.io/hostname
      nodeSelector:
        kubernetes.io/os: linux
      volumes:
      - name: config
        configMap:
          name: hubble-relay-config
          items:
          - key: config.yaml
            path: config.yaml
      - name: tls
        projected:
          # note: the leading zero means this number is in octal representation: do not remove it
          defaultMode: 0400
          sources:
          - secret:
              name: hubble-relay-client-certs
              items:
                - key: tls.crt
                  path: client.crt
                - key: tls.key
                  path: client.key
                - key: ca.crt
                  path: hubble-server-ca.crt
---
# Source: cilium/templates/hubble/tls-cronjob/cronjob.yaml
apiVersion: batch/v1
kind: CronJob
metadata:
  name: hubble-generate-certs
  namespace: kube-system
  labels:
    k8s-app: hubble-generate-certs
    app.kubernetes.io/name: hubble-generate-certs
    app.kubernetes.io/part-of: cilium
  annotations:
spec:
  schedule: "0 0 1 */4 *"
  concurrencyPolicy: Forbid
  jobTemplate:
    spec:
      template:
        metadata:
          labels:
            k8s-app: hubble-generate-certs
        spec:
          containers:
            - name: certgen
              image: "${certgen_repo}:${certgen_tag}"
              imagePullPolicy: IfNotPresent
              command:
                - "/usr/bin/cilium-certgen"
              # Because this is executed as a job, we pass the values as command
              # line args instead of via config map. This allows users to inspect
              # the values used in past runs by inspecting the completed pod.
              args:
                - "--cilium-namespace=kube-system"
                - "--debug"
                - "--ca-generate"
                - "--ca-reuse-secret"
                - "--hubble-server-cert-generate"
                - "--hubble-server-cert-common-name=*.default.hubble-grpc.cilium.io"
                - "--hubble-server-cert-validity-duration=94608000s"
                - "--hubble-relay-client-cert-generate"
                - "--hubble-relay-client-cert-validity-duration=94608000s"
          hostNetwork: true
          serviceAccount: "hubble-generate-certs"
          serviceAccountName: "hubble-generate-certs"
          automountServiceAccountToken: true
          restartPolicy: OnFailure
      ttlSecondsAfterFinished: 1800
---
# Source: cilium/templates/cilium-secrets-namespace.yaml
# Only create the namespace if it's different from Ingress secret namespace or Ingress is not enabled.

# Only create the namespace if it's different from Ingress and Gateway API secret namespaces (if enabled).
---
# Source: cilium/templates/hubble/tls-cronjob/job.yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: hubble-generate-certs
  namespace: kube-system
  labels:
    k8s-app: hubble-generate-certs
    app.kubernetes.io/name: hubble-generate-certs
    app.kubernetes.io/part-of: cilium
  annotations:
    "helm.sh/hook": post-install,post-upgrade
spec:
  template:
    metadata:
      labels:
        k8s-app: hubble-generate-certs
    spec:
      containers:
        - name: certgen
          image: "${certgen_repo}:${certgen_tag}"
          imagePullPolicy: IfNotPresent
          command:
            - "/usr/bin/cilium-certgen"
          # Because this is executed as a job, we pass the values as command
          # line args instead of via config map. This allows users to inspect
          # the values used in past runs by inspecting the completed pod.
          args:
            - "--cilium-namespace=kube-system"
            - "--debug"
            - "--ca-generate"
            - "--ca-reuse-secret"
            - "--hubble-server-cert-generate"
            - "--hubble-server-cert-common-name=*.default.hubble-grpc.cilium.io"
            - "--hubble-server-cert-validity-duration=94608000s"
            - "--hubble-relay-client-cert-generate"
            - "--hubble-relay-client-cert-validity-duration=94608000s"
      hostNetwork: true
      serviceAccount: "hubble-generate-certs"
      serviceAccountName: "hubble-generate-certs"
      automountServiceAccountToken: true
      restartPolicy: OnFailure
  ttlSecondsAfterFinished: 1800
