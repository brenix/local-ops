package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:        "cert-manager"
	Namespace:   "cert-manager"
	EnableHooks: true
	Chart: {
		name:    "cert-manager"
		version: "1.16.2"
		repository: {
			name: "jetstack"
			url:  "https://charts.jetstack.io"
		}
	}

	Values: #Values

	KustomizeConfig: Kustomization: namespace: Namespace
}
