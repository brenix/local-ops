package holos

Component: Resources: PersistentVolumeClaim: {
	cache: {
		apiVersion: "v1"
		metadata: name: "mumble"
		spec: {
			accessModes: ["ReadWriteOnce"]
			resources: requests: storage: "1Gi"
			storageClassName: "ceph-block"
		}
	}
}
