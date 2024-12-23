package holos

holos: Component.BuildPlan

Component: #Kustomize & {
	Name:      "media"
	Namespace: "default"

	KustomizeConfig: Kustomization: namespace: Namespace

	Resources: PersistentVolumeClaim: (Name): {
		apiVersion: "v1"
		metadata: name: Name
		spec: {
			accessModes: ["ReadWriteMany"]
			resources: requests: storage: "300Gi"
			storageClassName: "ceph-filesystem"
		}
	}
}
