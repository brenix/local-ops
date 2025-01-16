package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:        "snapshot-controller"
	Namespace:   "kube-system"
	EnableHooks: true
	Chart: {
		name:    "snapshot-controller"
		version: "4.0.1"
		release: "snapshot-controller"
		repository: {
			name: "piraeus-charts"
			url:  "https://piraeus.io/helm-charts/"
		}
	}

	Values: #Values

	KustomizeConfig: Kustomization: namespace: Namespace
}
