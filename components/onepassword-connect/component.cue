package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:      "onepassword-connect"
	Namespace: "security"
	Chart: {
		name:    "connect"
		version: "1.17.0"
		repository: {
			name: "onepassword"
			url:  "https://1password.github.io/connect-helm-charts"
		}
	}

	KustomizeConfig: Kustomization: namespace: Namespace
}
