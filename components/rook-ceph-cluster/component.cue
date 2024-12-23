package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:      "rook-ceph-cluster"
	Namespace: "rook-ceph"
	Chart: {
		name:    "rook-ceph-cluster"
		release: "rook-ceph-cluster"
		version: "1.15.7"
		repository: {
			name: "rook-ceph"
			url:  "https://charts.rook.io/release"
		}
	}

	Values: #Values

	KustomizeConfig: Kustomization: namespace: Namespace
}
