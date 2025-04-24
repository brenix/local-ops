package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:        "cert-manager"
	Namespace:   "cert-manager"
	EnableHooks: true
	Chart: {
		name:    "cert-manager"
		version: "v1.17.2"
		repository: {
			name: "jetstack"
			url:  "https://charts.jetstack.io"
		}
	}

	Values: #Values

	KustomizeConfig: Kustomization: namespace: Namespace
}
