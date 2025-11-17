package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:        "snapshot-controller"
	Namespace:   "kube-system"
	EnableHooks: true
	KubeVersion: "1.32.0"
	Chart: {
		name:    "snapshot-controller"
		version: "4.2.0"
		release: "snapshot-controller"
		repository: {
			name: "piraeus-charts"
			url:  "https://piraeus.io/helm-charts/"
		}
	}

	Values: #Values

	KustomizeConfig: Kustomization: namespace: Namespace
}
