package holos

Component: Resources: PersistentVolumeClaim: {
	cache: {
		apiVersion: "v1"
		metadata: name: "pacoloco"
		spec: {
			accessModes: ["ReadWriteOnce"]
			resources: requests: storage: "30Gi"
			storageClassName: "ceph-block"
		}
	}
}
