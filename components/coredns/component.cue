package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:      "coredns"
	Namespace: "kube-system"
	Chart: {
		name:    "coredns"
		version: "1.41.0"
		repository: {
			name: "coredns"
			url:  "https://coredns.github.io/helm"
		}
	}

	Values: #Values

	KustomizeConfig: Kustomization: namespace: Namespace
}
