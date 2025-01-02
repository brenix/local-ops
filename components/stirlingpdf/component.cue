package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:      "stirlingpdf"
	Namespace: "default"
	Chart: {
		name:    "app-template"
		version: "3.5.1"
		release: "stirlingpdf"
		repository: {
			name: "bjw-s"
			url:  "https://bjw-s.github.io/helm-charts"
		}
	}

	Values: #Values

	KustomizeConfig: Kustomization: namespace: Namespace
}
