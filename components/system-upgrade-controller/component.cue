package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:      "system-upgrade-controller"
	Namespace: "system-upgrade"
	Chart: {
		name:    "app-template"
		version: "4.2.0"
		release: "system-upgrade-controller"
		repository: {
			name: "bjw-s"
			url:  "https://bjw-s-labs.github.io/helm-charts"
		}
	}

	Values: #Values

	KustomizeConfig: Kustomization: namespace: Namespace
}
