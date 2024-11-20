package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:      "prowlarr"
	Namespace: "default"
	Chart: {
		name:    "app-template"
		release: "prowlarr"
		version: "3.5.1"
		repository: {
			name: "bjw-s"
			url:  "https://bjw-s.github.io/helm-charts"
		}
	}

	Values: #Values

	KustomizeConfig: Kustomization: namespace: Namespace
}
