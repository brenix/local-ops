package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:        "cilium"
	Namespace:   "kube-system"
	EnableHooks: true
	Chart: {
		name:    "cilium"
		version: "1.17.0"
		repository: {
			name: "cilium"
			url:  "https://helm.cilium.io"
		}
	}

	Values: #Values

	KustomizeConfig: Kustomization: namespace: Namespace
}
