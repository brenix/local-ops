package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:      "prometheus"
	Namespace: "monitoring"
	Chart: {
		name:    "kube-prometheus-stack"
		release: "prometheus"
		version: "66.3.1"
		repository: {
			name: "prometheus"
			url:  "https://prometheus-community.github.io/helm-charts"
		}
	}

	KustomizeConfig: Kustomization: namespace: Namespace
}
