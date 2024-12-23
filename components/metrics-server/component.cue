package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:      "metrics-server"
	Namespace: "kube-system"
	Chart: {
		name:    "metrics-server"
		version: "3.12.2"
		repository: {
			name: "metrics-server"
			url:  "https://kubernetes-sigs.github.io/metrics-server/"
		}
	}

	Values: #Values

	KustomizeConfig: Kustomization: namespace: Namespace
}
