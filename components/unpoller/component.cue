package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:      "unpoller"
	Namespace: "monitoring"
	Chart: {
		name:    "app-template"
		version: "3.7.3"
		release: "unpoller"
		repository: {
			name: "bjw-s"
			url:  "https://bjw-s-labs.github.io/helm-charts"
		}
	}

	Values: #Values

	KustomizeConfig: Kustomization: namespace: Namespace
}
