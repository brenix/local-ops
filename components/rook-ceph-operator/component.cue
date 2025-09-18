package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:      "rook-ceph-operator"
	Namespace: "rook-ceph"
	Chart: {
		name:    "rook-ceph"
		version: "v1.18.2"
		release: "rook-ceph-operator"
		repository: {
			name: "rook-ceph"
			url:  "https://charts.rook.io/release"
		}
	}

	Values: #Values

	KustomizeConfig: Kustomization: namespace: Namespace
}
