package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:      "node-feature-discovery"
	Namespace: "kube-system"
	KubeVersion: "1.32.0"
	Chart: {
		name:    "node-feature-discovery"
		version: "0.18.3"
		repository: {
			name: "node-feature-discovery"
			url:  "https://kubernetes-sigs.github.io/node-feature-discovery/charts"
		}
	}

	KustomizeConfig: Kustomization: namespace: Namespace
}
