package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:        "nginx-external"
	Namespace:   "network"
	EnableHooks: true
	Chart: {
		name:    "ingress-nginx"
		version: "4.12.2"
		release: "nginx-external"
		repository: {
			name: "ingress-nginx"
			url:  "https://kubernetes.github.io/ingress-nginx"
		}
	}

	Values: #Values

	KustomizeConfig: Kustomization: namespace: Namespace
}
