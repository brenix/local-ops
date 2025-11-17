package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:        "external-dns"
	Namespace:   "network"
	EnableHooks: true
	KubeVersion: "1.32.0"
	Chart: {
		name:    "external-dns"
		version: "1.19.0"
		repository: {
			name: "external-dns"
			url:  "https://kubernetes-sigs.github.io/external-dns"
		}
	}

	Values: #Values

	KustomizeConfig: Kustomization: namespace: Namespace
}
