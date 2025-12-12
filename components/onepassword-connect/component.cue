package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:      "onepassword-connect"
	Namespace: "security"
	KubeVersion: "1.32.0"
	Chart: {
		name:    "connect"
		version: "2.1.1"
		repository: {
			name: "onepassword"
			url:  "https://1password.github.io/connect-helm-charts"
		}
	}

	KustomizeConfig: Kustomization: namespace: Namespace
}
