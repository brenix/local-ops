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
				name: "onepassword-connect"
			}
			target: {
				name:           "mongodb-init"
				deletionPolicy: "Delete"
				template: {
					engineVersion: "v2"
					data: "init-mongo.js": """
						db.getSiblingDB("unifi").createUser({user: "{{ .username }}", pwd: "{{ .password }}", roles: [{role: "dbOwner", db: "unifi"}]});
						db.getSiblingDB("unifi_stat").createUser({user: "{{ .username }}", pwd: "{{ .password }}", roles: [{role: "dbOwner", db: "unifi_stat"}]});
						"""
				}
			}
			data: [{
				secretKey: "username"
				remoteRef: {
					key:      Name
					property: "username"
				}
			}, {
				secretKey: "password"
				remoteRef: {
					key:      Name
					property: "password"
				}
			}]
		}
	}
}
