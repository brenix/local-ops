package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:      "reloader"
	Namespace: "kube-system"
	Chart: {
		name:    "reloader"
		version: "2.2.0"
		release: "reloader"
		repository: {
			name: "stakater"
			url:  "https://stakater.github.io/stakater-charts"
		}
	}

	Values: fullnameOverride: "reloader"

	KustomizeConfig: Kustomization: namespace: Namespace
}
