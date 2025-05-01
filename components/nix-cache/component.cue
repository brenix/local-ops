package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:      "nix-cache"
	Namespace: "default"
	Chart: {
		name:    "app-template"
		version: "3.7.3"
		release: "nix-cache"
		repository: {
			name: "bjw-s"
			url:  "https://bjw-s-labs.github.io/helm-charts"
		}
	}

	Values: #Values

	KustomizeConfig: Kustomization: namespace: Namespace
}
