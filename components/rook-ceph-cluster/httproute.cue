package holos

Component: {
	Name:      string
	Namespace: string

	Resources: HTTPRoute: (Name): {
		metadata: name:      Name
		metadata: namespace: Namespace
		spec: {
			hostnames: ["rook.brenix.com"]
			parentRefs: [{
				name:        "internal"
				namespace:   "kube-system"
				sectionName: "https"
			}]
			rules: [{
				backendRefs: [{
					name:      "rook-ceph-mgr-dashboard"
					namespace: "rook-ceph"
					port:      7000
				}]
			}]
		}
	}
}
