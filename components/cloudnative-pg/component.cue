package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:        "cloudnative-pg"
	Namespace:   "database"
	EnableHooks: true
	Chart: {
		name:    "cloudnative-pg"
		version: "0.23.1"
		repository: {
			name: "cloudnative-pg"
			url:  "https://cloudnative-pg.github.io/charts"
		}
	}

	Values: #Values

	KustomizeConfig: Kustomization: namespace: Namespace
}
