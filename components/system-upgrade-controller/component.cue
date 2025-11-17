package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:      "system-upgrade-controller"
	Namespace: "system-upgrade"
	KubeVersion: "1.32.0"
	Chart: {
		name:    "app-template"
		version: "4.4.0"
		release: "system-upgrade-controller"
		repository: {
			name: "bjw-s"
			url:  "https://bjw-s-labs.github.io/helm-charts"
		}
	}

	Values: #Values

	KustomizeConfig: Kustomization: namespace: Namespace
}
