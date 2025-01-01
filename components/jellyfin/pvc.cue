package holos

Component: Resources: PersistentVolumeClaim: {
	data: {
		apiVersion: "v1"
		metadata: name: "jellyfin-data"
		spec: {
			accessModes: ["ReadWriteOnce"]
			resources: requests: storage: "2Gi"
			storageClassName: "ceph-block"
		}
	}
	cache: {
		apiVersion: "v1"
		metadata: name: "jellyfin-cache"
		spec: {
			accessModes: ["ReadWriteOnce"]
			resources: requests: storage: "1Gi"
			storageClassName: "ceph-block"
		}
	}
}
