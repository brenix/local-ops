package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:      "nix-cache"
	Namespace: "default"
	Chart: {
		name:    "app-template"
		version: "4.1.1"
		release: "nix-cache"
		repository: {
			name: "bjw-s"
			url:  "https://bjw-s-labs.github.io/helm-charts"
		}
	}

	APIVersions: ["gateway.networking.k8s.io/v1/HTTPRoute"]

	Values: #Values

	KustomizeConfig: Kustomization: namespace: Namespace
}
