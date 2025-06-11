package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:      "jellyfin"
	Namespace: "default"
	Chart: {
		name:    "app-template"
		version: "4.1.0"
		release: "jellyfin"
		repository: {
			name: "bjw-s"
			url:  "https://bjw-s-labs.github.io/helm-charts"
		}
	}

	Values: #Values

	KustomizeConfig: Kustomization: namespace: Namespace
}
