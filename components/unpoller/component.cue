package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:      "unpoller"
	Namespace: "monitoring"
	Chart: {
		name:    "app-template"
		release: "unpoller"
		version: "3.5.1"
		repository: {
			name: "bjw-s"
			url:  "https://bjw-s.github.io/helm-charts"
		}
	}

	Values: #Values

	KustomizeConfig: Kustomization: namespace: Namespace
}
