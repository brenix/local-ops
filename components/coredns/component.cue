package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:      "coredns"
	Namespace: "kube-system"
	Chart: {
		name:    "coredns"
		version: "1.42.2"
		repository: {
			name: "coredns"
			url:  "https://coredns.github.io/helm"
		}
	}

	Values: #Values

	KustomizeConfig: Kustomization: namespace: Namespace
}
