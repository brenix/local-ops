package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:        "forgejo"
	Namespace:   "default"
	EnableHooks: false
	Chart: {
		name:    "oci://code.forgejo.org/forgejo-helm/forgejo"
		version: "10.1.1"
		release: Name
	}

	Values: #Values

	KustomizeConfig: Kustomization: namespace: Namespace
}
