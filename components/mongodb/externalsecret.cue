package holos

Component: {
	Name:      string
	Namespace: string

	Resources: ExternalSecret: (Name): {
		metadata: name:      Name
		metadata: namespace: Namespace
		spec: {
			secretStoreRef: {
				kind: "ClusterSecretStore"
				name: "doppler"
			}
			target: {
				name:           "mongodb-init"
				deletionPolicy: "Delete"
				template: {
					engineVersion: "v2"
					data: "init-mongo.js": """
						db.getSiblingDB("unifi").createUser({user: "{{ .MONGODB_USER }}", pwd: "{{ .MONGODB_PASS }}", roles: [{role: "dbOwner", db: "unifi"}]});
						db.getSiblingDB("unifi_stat").createUser({user: "{{ .MONGODB_USER }}", pwd: "{{ .MONGODB_PASS }}", roles: [{role: "dbOwner", db: "unifi_stat"}]});
						"""
				}
			}
			data: [
				{secretKey: "MONGODB_USER", remoteRef: {key: "MONGODB_USER"}},
				{secretKey: "MONGODB_PASS", remoteRef: {key: "MONGODB_PASS"}},
			]
		}
	}
}
