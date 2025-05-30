package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:        "ping-exporter"
	Namespace:   "monitoring"
	EnableHooks: true
	Chart: {
		name:    "ping-exporter"
		version: "1.1.0"
		release: "ping-exporter"
		repository: {
			name: "ping-exporter"
			url:  "https://raw.githubusercontent.com/czerwonk/ping_exporter/main/dist/charts"
		}
	}

	Values: #Values

	KustomizeConfig: Kustomization: namespace: Namespace
}
