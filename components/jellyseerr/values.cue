package holos

#Values: {
	controllers: main: containers: main: {
		env: {
			LOG_LEVEL: "info"
			TZ:        "America/Los_Angeles"
		}
		image: {
			repository: "docker.io/fallenbagel/jellyseerr"
			tag:        "2.7.0"
		}
	}
	route: main: {
		hostnames: ["{{ .Release.Name }}.brenix.com", "requests.brenix.com"]
		parentRefs: [{
			name:        "external"
			namespace:   "kube-system"
			sectionName: "https"
		}]
	}
	persistence: {
		config: {
			existingClaim: "jellyseerr"
			globalMounts: [{path: "/app/config"}]
		}
		cache: {
			enabled:       true
			existingClaim: "jellyseerr-cache"
			globalMounts: [{path: "/app/config/cache"}]
		}
	}
	service: main: {
		annotations: "lbipam.cilium.io/ips": "192.168.2.8"
		controller:            "main"
		externalTrafficPolicy: "Local"
		ports: http: port: 5055
		type: "LoadBalancer"
	}
}
