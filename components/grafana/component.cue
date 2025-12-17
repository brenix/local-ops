package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:        "grafana"
	Namespace:   "monitoring"
	EnableHooks: true
	KubeVersion: "1.32.0"
	Chart: {
		name:    "grafana"
		version: "10.3.2"
		repository: {
			name: "grafana"
			url:  "https://grafana.github.io/helm-charts"
		}
	}

	Values: #Values

	KustomizeConfig: Kustomization: namespace: Namespace
}
