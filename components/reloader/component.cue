package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:      "reloader"
	Namespace: "kube-system"
	Chart: {
		name:    "reloader"
		release: "reloader"
		version: "1.2.0"
		repository: {
			name: "stakater"
			url:  "https://stakater.github.io/stakater-charts"
		}
	}

	Values: fullnameOverride: "reloader"

	KustomizeConfig: Kustomization: namespace: Namespace
}
