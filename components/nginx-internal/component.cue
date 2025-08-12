package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:        "nginx-internal"
	Namespace:   "network"
	EnableHooks: true
	Chart: {
		name:    "ingress-nginx"
		version: "4.13.1"
		release: "nginx-internal"
		repository: {
			name: "ingress-nginx"
			url:  "https://kubernetes.github.io/ingress-nginx"
		}
	}

	Values: #Values

	KustomizeConfig: Kustomization: namespace: Namespace
}
