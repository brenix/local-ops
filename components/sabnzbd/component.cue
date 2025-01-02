package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:      "sabnzbd"
	Namespace: "default"
	Chart: {
		name:    "app-template"
		version: "3.5.1"
		release: "sabnzbd"
		repository: {
			name: "bjw-s"
			url:  "https://bjw-s.github.io/helm-charts"
		}
	}

	Values: #Values

	KustomizeConfig: Kustomization: namespace: Namespace
}
