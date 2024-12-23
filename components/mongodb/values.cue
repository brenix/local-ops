package holos

#Values: {
	controllers: main: {
		containers: main: {
			image: {
				repository: "docker.io/library/mongo"
				tag:        "4.4"
			}
			probes: {
				liveness: enabled:  false
				readiness: enabled: false
				startup: enabled:   false
			}
		}
		type: "statefulset"
	}
	persistence: {
		data: {
			enabled:       true
			existingClaim: "mongo-data"
			globalMounts: [{path: "/data/db"}]
		}
		initdb: {
			enabled: true
			globalMounts: [{path: "/docker-entrypoint-initdb.d"}]
			name: "mongodb-init"
			type: "secret"
		}
	}
	service: main: {
		controller: "main"
		ports: {
			http: {
				enabled: false
				port:    80
			}
			mongodb: {
				enabled:  true
				port:     27017
				primary:  true
				protocol: "TCP"
			}
		}
		type: "ClusterIP"
	}
}
