package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:      "node-feature-discovery"
	Namespace: "kube-system"
	Chart: {
		name:    "node-feature-discovery"
		version: "0.17.4"
		repository: {
			name: "node-feature-discovery"
			url:  "https://kubernetes-sigs.github.io/node-feature-discovery/charts"
		}
	}

	KustomizeConfig: Kustomization: namespace: Namespace
}
