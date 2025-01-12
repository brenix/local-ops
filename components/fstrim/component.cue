package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:      "fstrim"
	Namespace: "default"
	Chart: {
		name:    "app-template"
		version: "3.6.1"
		release: "fstrim"
		repository: {
			name: "bjw-s"
			url:  "https://bjw-s.github.io/helm-charts"
		}
	}

	Values: #Values

	KustomizeConfig: Kustomization: namespace: Namespace
}