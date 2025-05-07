package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:        "external-secrets"
	Namespace:   "security"
	EnableHooks: true
	Chart: {
		name:    "external-secrets"
		version: "0.16.2"
		repository: {
			name: "external-secrets"
			url:  "https://charts.external-secrets.io"
		}
	}

	Values: #Values

	KustomizeConfig: Kustomization: namespace: Namespace
}
