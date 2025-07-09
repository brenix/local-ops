package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:      "onepassword-connect"
	Namespace: "security"
	Chart: {
		name:    "connect"
		version: "2.0.1"
		repository: {
			name: "onepassword"
			url:  "https://1password.github.io/connect-helm-charts"
		}
	}

	KustomizeConfig: Kustomization: namespace: Namespace
}
