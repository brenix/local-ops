package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:      "mongodb"
	Namespace: "default"
	Chart: {
		name:    "app-template"
		version: "3.6.0"
		release: "mongodb"
		repository: {
			name: "bjw-s"
			url:  "https://bjw-s.github.io/helm-charts"
		}
	}

	Values: #Values

	KustomizeConfig: Kustomization: namespace: Namespace
}
