package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:      "rook-ceph-operator"
	Namespace: "rook-ceph"
	Chart: {
		name:    "rook-ceph"
		release: "rook-ceph-operator"
		version: "1.15.7"
		repository: {
			name: "rook-ceph"
			url:  "https://charts.rook.io/release"
		}
	}

	Values: #Values

	KustomizeConfig: Kustomization: namespace: Namespace
}
