package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:        "grafana"
	Namespace:   "monitoring"
	EnableHooks: true
	Chart: {
		name:    "grafana"
		version: "8.8.5"
		repository: {
			name: "grafana"
			url:  "https://grafana.github.io/helm-charts"
		}
	}

	Values: #Values

	KustomizeConfig: Kustomization: namespace: Namespace
}
