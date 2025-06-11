package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:      "sabnzbd"
	Namespace: "default"
	Chart: {
		name:    "app-template"
		version: "4.1.0"
		release: "sabnzbd"
		repository: {
			name: "bjw-s"
			url:  "https://bjw-s-labs.github.io/helm-charts"
		}
	}

	Values: #Values

	KustomizeConfig: Kustomization: namespace: Namespace
}
