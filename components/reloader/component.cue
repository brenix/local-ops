package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:      "reloader"
	Namespace: "kube-system"
	KubeVersion: "1.32.0"
	Chart: {
		name:    "reloader"
		version: "2.2.6"
		release: "reloader"
		repository: {
			name: "stakater"
			url:  "https://stakater.github.io/stakater-charts"
		}
	}

	Values: fullnameOverride: "reloader"

	KustomizeConfig: Kustomization: namespace: Namespace
}
