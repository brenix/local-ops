package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:      "mongodb"
	Namespace: "default"
	Chart: {
		name:    "app-template"
		version: "4.0.1"
		release: "mongodb"
		repository: {
			name: "bjw-s"
			url:  "https://bjw-s-labs.github.io/helm-charts"
		}
	}

	Values: #Values

	KustomizeConfig: Kustomization: namespace: Namespace
}
