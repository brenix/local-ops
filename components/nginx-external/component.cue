package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:        "nginx-external"
	Namespace:   "network"
	EnableHooks: true
	Chart: {
		name:    "ingress-nginx"
		release: "nginx-external"
		version: "4.11.3"
		repository: {
			name: "ingress-nginx"
			url:  "https://kubernetes.github.io/ingress-nginx"
		}
	}

	Values: #Values

	KustomizeConfig: Kustomization: namespace: Namespace
}
