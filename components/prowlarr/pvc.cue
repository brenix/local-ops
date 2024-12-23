package holos

Component: Resources: PersistentVolumeClaim: {
	data: {
		apiVersion: "v1"
		metadata: name: "prowlarr"
		spec: {
			accessModes: ["ReadWriteOnce"]
			resources: requests: storage: "1Gi"
			storageClassName: "ceph-block"
		}
	}
}
