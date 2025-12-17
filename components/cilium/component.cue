package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:        "cilium"
	Namespace:   "kube-system"
	EnableHooks: true
	KubeVersion: "1.32.0"
	Chart: {
		name:    "cilium"
		version: "1.18.5"
		repository: {
			name: "cilium"
			url:  "https://helm.cilium.io"
		}

	}
	APIVersions: [
		"gateway.networking.k8s.io/v1/GatewayClass",
		"gateway.networking.k8s.io/v1/HTTPRoute",
		"monitoring.coreos.com/v1/ServiceMonitor",
	]

	Values: #Values
}
