package holos

#Values: {
	controllers: main: containers: main: {
		env: {
			MONGO_DBNAME: "unifi"
			MONGO_HOST:   "mongodb.default.svc.cluster.local"
			MONGO_PORT:   27017
			PGID:         1000
			PUID:         1000
			TZ:           "America/Los_Angeles"
		}
		envFrom: [{
			secretRef: name: "unifi"
		}]
		image: {
			repository: "lscr.io/linuxserver/unifi-network-application"
			tag:        "9.3.45"
		}
	}
	route: main: {
		hostnames: ["{{ .Release.Name }}.brenix.com"]
		parentRefs: [{
			name:        "internal"
			namespace:   "kube-system"
			sectionName: "https"
		}]
	}
	persistence: data: {
		enabled:       true
		existingClaim: "unifi-data"
		globalMounts: [{path: "/config"}]
	}
	service: main: {
		annotations: "lbipam.cilium.io/ips": "192.168.2.2"
		controller:            "main"
		externalTrafficPolicy: "Local"
		ports: {
			controller: {
				enabled:  true
				port:     8080
				protocol: "TCP"
			}
			discovery: {
				enabled:  true
				port:     10001
				protocol: "UDP"
			}
			https: {
				port:        8443
				protocol:    "HTTPS"
				appProtocol: "https"
			}
			"portal-http": {
				enabled:  false
				port:     8880
				protocol: "HTTP"
			}
			"portal-https": {
				enabled:  false
				port:     8843
				protocol: "HTTPS"
			}
			speedtest: {
				enabled:  true
				port:     6789
				protocol: "TCP"
			}
			stun: {
				enabled:  true
				port:     3478
				protocol: "UDP"
			}
			syslog: {
				enabled:  true
				port:     5514
				protocol: "UDP"
			}
		}
		type: "LoadBalancer"
	}
}
