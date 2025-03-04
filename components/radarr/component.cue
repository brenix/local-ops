package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:      "radarr"
	Namespace: "default"
	Chart: {
		name:    "app-template"
		version: "3.7.2"
		release: "radarr"
		repository: {
			name: "bjw-s"
			url:  "https://bjw-s.github.io/helm-charts"
		}
	}

	Values: #Values

	KustomizeConfig: Kustomization: namespace: Namespace
}
