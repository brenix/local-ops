package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:      "linkding"
	Namespace: "default"
	Chart: {
		name:    "app-template"
		version: "4.4.0"
		release: "linkding"
		repository: {
			name: "bjw-s"
			url:  "https://bjw-s-labs.github.io/helm-charts"
		}
	}

	APIVersions: ["gateway.networking.k8s.io/v1/HTTPRoute"]

	Values: #Values

	KustomizeConfig: Kustomization: namespace: Namespace
}
