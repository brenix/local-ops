package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:      "coredns"
	Namespace: "kube-system"
	KubeVersion: "1.32.0"
	Chart: {
		name:    "coredns"
		version: "1.45.0"
		repository: {
			name: "coredns"
			url:  "https://coredns.github.io/helm"
		}
	}

	Values: #Values

	KustomizeConfig: Kustomization: namespace: Namespace
}
