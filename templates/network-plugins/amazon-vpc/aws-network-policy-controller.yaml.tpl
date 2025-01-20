apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  annotations:
    controller-gen.kubebuilder.io/version: v0.16.3
  labels:
    app.kubernetes.io/name: amazon-network-policy-controller-k8s
  name: policyendpoints.networking.k8s.aws
spec:
  group: networking.k8s.aws
  names:
    kind: PolicyEndpoint
    listKind: PolicyEndpointList
    plural: policyendpoints
    singular: policyendpoint
  scope: Namespaced
  versions:
  - name: v1alpha1
    schema:
      openAPIV3Schema:
        description: PolicyEndpoint is the Schema for the policyendpoints API
        properties:
          apiVersion:
            description: |-
              APIVersion defines the versioned schema of this representation of an object.
              Servers should convert recognized schemas to the latest internal value, and
              may reject unrecognized values.
              More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
            type: string
          kind:
            description: |-
              Kind is a string value representing the REST resource this object represents.
              Servers may infer this from the endpoint the client submits requests to.
              Cannot be updated.
              In CamelCase.
              More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
            type: string
          metadata:
            type: object
          spec:
            description: PolicyEndpointSpec defines the desired state of PolicyEndpoint
            properties:
              egress:
                description: Egress is the list of egress rules containing resolved
                  network addresses
                items:
                  description: EndpointInfo defines the network endpoint information
                    for the policy ingress/egress
                  properties:
                    cidr:
                      description: CIDR is the network address(s) of the endpoint
                      type: string
                    except:
                      description: Except is the exceptions to the CIDR ranges mentioned
                        above.
                      items:
                        type: string
                      type: array
                    ports:
                      description: Ports is the list of ports
                      items:
                        description: Port contains information about the transport
                          port/protocol
                        properties:
                          endPort:
                            description: |-
                              Endport specifies the port range port to endPort
                              port must be defined and an integer, endPort > port
                            format: int32
                            type: integer
                          port:
                            description: Port specifies the numerical port for the
                              protocol. If empty applies to all ports
                            format: int32
                            type: integer
                          protocol:
                            default: TCP
                            description: Protocol specifies the transport protocol,
                              default TCP
                            type: string
                        type: object
                      type: array
                  required:
                  - cidr
                  type: object
                type: array
              ingress:
                description: Ingress is the list of ingress rules containing resolved
                  network addresses
                items:
                  description: EndpointInfo defines the network endpoint information
                    for the policy ingress/egress
                  properties:
                    cidr:
                      description: CIDR is the network address(s) of the endpoint
                      type: string
                    except:
                      description: Except is the exceptions to the CIDR ranges mentioned
                        above.
                      items:
                        type: string
                      type: array
                    ports:
                      description: Ports is the list of ports
                      items:
                        description: Port contains information about the transport
                          port/protocol
                        properties:
                          endPort:
                            description: |-
                              Endport specifies the port range port to endPort
                              port must be defined and an integer, endPort > port
                            format: int32
                            type: integer
                          port:
                            description: Port specifies the numerical port for the
                              protocol. If empty applies to all ports
                            format: int32
                            type: integer
                          protocol:
                            default: TCP
                            description: Protocol specifies the transport protocol,
                              default TCP
                            type: string
                        type: object
                      type: array
                  required:
                  - cidr
                  type: object
                type: array
              podIsolation:
                description: |-
                  PodIsolation specifies whether the pod needs to be isolated for a
                  particular traffic direction Ingress or Egress, or both. If default isolation is not
                  specified, and there are no ingress/egress rules, then the pod is not isolated
                  from the point of view of this policy. This follows the NetworkPolicy spec.PolicyTypes.
                items:
                  description: |-
                    PolicyType string describes the NetworkPolicy type
                    This type is beta-level in 1.8
                  type: string
                type: array
              podSelector:
                description: PodSelector is the podSelector from the policy resource
                properties:
                  matchExpressions:
                    description: matchExpressions is a list of label selector requirements.
                      The requirements are ANDed.
                    items:
                      description: |-
                        A label selector requirement is a selector that contains values, a key, and an operator that
                        relates the key and values.
                      properties:
                        key:
                          description: key is the label key that the selector applies
                            to.
                          type: string
                        operator:
                          description: |-
                            operator represents a key's relationship to a set of values.
                            Valid operators are In, NotIn, Exists and DoesNotExist.
                          type: string
                        values:
                          description: |-
                            values is an array of string values. If the operator is In or NotIn,
                            the values array must be non-empty. If the operator is Exists or DoesNotExist,
                            the values array must be empty. This array is replaced during a strategic
                            merge patch.
                          items:
                            type: string
                          type: array
                          x-kubernetes-list-type: atomic
                      required:
                      - key
                      - operator
                      type: object
                    type: array
                    x-kubernetes-list-type: atomic
                  matchLabels:
                    additionalProperties:
                      type: string
                    description: |-
                      matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels
                      map is equivalent to an element of matchExpressions, whose key field is "key", the
                      operator is "In", and the values array contains only "value". The requirements are ANDed.
                    type: object
                type: object
                x-kubernetes-map-type: atomic
              podSelectorEndpoints:
                description: |-
                  PodSelectorEndpoints contains information about the pods
                  matching the podSelector
                items:
                  description: PodEndpoint defines the summary information for the
                    pods
                  properties:
                    hostIP:
                      description: HostIP is the IP address of the host the pod is
                        currently running on
                      type: string
                    name:
                      description: Name is the pod name
                      type: string
                    namespace:
                      description: Namespace is the pod namespace
                      type: string
                    podIP:
                      description: PodIP is the IP address of the pod
                      type: string
                  required:
                  - hostIP
                  - name
                  - namespace
                  - podIP
                  type: object
                type: array
              policyRef:
                description: PolicyRef is a reference to the Kubernetes NetworkPolicy
                  resource.
                properties:
                  name:
                    description: Name is the name of the Policy
                    type: string
                  namespace:
                    description: Namespace is the namespace of the Policy
                    type: string
                required:
                - name
                - namespace
                type: object
            required:
            - policyRef
            type: object
          status:
            description: PolicyEndpointStatus defines the observed state of PolicyEndpoint
            type: object
        type: object
    served: true
    storage: true
    subresources:
      status: {}
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
  - pods
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
