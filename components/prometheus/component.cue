package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:        "prometheus"
	Namespace:   "monitoring"
	EnableHooks: true
	KubeVersion: "1.32.0"
	Chart: {
		name:    "kube-prometheus-stack"
		version: "79.7.1"
		release: "prometheus"
		repository: {
			name: "prometheus"
			url:  "https://prometheus-community.github.io/helm-charts"
		}
	}

	Values: #Values

	KustomizeConfig: Kustomization: namespace: Namespace
}
