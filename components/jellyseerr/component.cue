package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:      "jellyseerr"
	Namespace: "default"
	Chart: {
		name:    "app-template"
		version: "3.7.3"
		release: "jellyseerr"
		repository: {
			name: "bjw-s"
			url:  "https://bjw-s.github.io/helm-charts"
		}
	}

	Values: #Values

	KustomizeConfig: Kustomization: namespace: Namespace
}
