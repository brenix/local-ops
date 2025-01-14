package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:        "prometheus"
	Namespace:   "monitoring"
	EnableHooks: true
	Chart: {
		name:    "kube-prometheus-stack"
		version: "68.1.0"
		release: "prometheus"
		repository: {
			name: "prometheus"
			url:  "https://prometheus-community.github.io/helm-charts"
		}
	}

	Values: #Values

	KustomizeConfig: Kustomization: namespace: Namespace
}
