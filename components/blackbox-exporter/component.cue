package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:        "blackbox-exporter"
	Namespace:   "monitoring"
	EnableHooks: true
	Chart: {
		name:    "prometheus-blackbox-exporter"
		version: "11.2.0"
		release: "prometheus-blackbox-exporter"
		repository: {
			name: "prometheus-community"
			url:  "https://prometheus-community.github.io/helm-charts"
		}
	}

	Values: #Values

	KustomizeConfig: Kustomization: namespace: Namespace
}
