package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:        "external-secrets"
	Namespace:   "security"
	EnableHooks: true
	KubeVersion: "1.32.0"
	Chart: {
		name:    "external-secrets"
		version: "1.1.1"
		repository: {
			name: "external-secrets"
			url:  "https://charts.external-secrets.io"
		}
	}

	Values: #Values

	KustomizeConfig: Kustomization: namespace: Namespace
}
