package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:      "linkding"
	Namespace: "default"
	Chart: {
		name:    "app-template"
		version: "4.0.1"
		release: "linkding"
		repository: {
			name: "bjw-s"
			url:  "https://bjw-s-labs.github.io/helm-charts"
		}
	}

	Values: #Values

	KustomizeConfig: Kustomization: namespace: Namespace
}
