package holos

#Values: {
	replicaCount: 1
	gitea: {
		admin: existingSecret: "gitea-admin"
		config: {
			cache: ADAPTER:    "memory"
			database: DB_TYPE: "sqlite3"
			queue: TYPE:       "level"
			server: {
				DOMAIN:     "git.brenix.com"
				ROOT_URL:   "https://git.brenix.com"
				SSH_DOMAIN: "git.brenix.com"
			}
			session: PROVIDER: "memory"
		}
	}
	httpRoute: {
		enabled: true
		hostnames: ["git.brenix.com"]
		parentRefs: [{
			name:        "internal"
			namespace:   "kube-system"
			sectionName: "https"
		}]
	}
	postgresql: enabled:      false
	"postgresql-ha": enabled: false
	"redis-cluster": enabled: false
	service: {
		http: {
			annotations: {
				"lbipam.cilium.io/sharing-key": "gitea-192.168.2.11"
				"lbipam.cilium.io/ips":         "192.168.2.11"
			}
			type: "LoadBalancer"
		}
		ssh: {
			annotations: {
				"lbipam.cilium.io/sharing-key": "gitea-192.168.2.11"
				"lbipam.cilium.io/ips":         "192.168.2.11"
			}
			type: "LoadBalancer"
		}
	}
}
