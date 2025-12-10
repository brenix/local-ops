package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:        "blackbox-exporter"
	Namespace:   "monitoring"
	EnableHooks: true
	KubeVersion: "1.32.0"
	Chart: {
		name:    "prometheus-blackbox-exporter"
		version: "11.6.1"
		release: "prometheus-blackbox-exporter"
		repository: {
			name: "prometheus-community"
			url:  "https://prometheus-community.github.io/helm-charts"
		}
	}

	Values: #Values

	KustomizeConfig: Kustomization: namespace: Namespace
}
