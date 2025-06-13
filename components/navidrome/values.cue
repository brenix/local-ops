package holos

#Values: {
	controllers: main: containers: main: {
		image: {
			repository: "ghcr.io/navidrome/navidrome"
			tag:        "0.55.0"
			pullPolicy: "Always"
		}
		env: {
			PGID:                       1000
			PUID:                       1000
			TZ:                         "America/Los_Angeles"
			ND_SCANSCHEDULE:            "*/5 * * * *"
			ND_SESSIONTIMEOUT:          "24h"
			ND_LOGLEVEL:                "info"
			ND_ENABLETRANSCODINGCONFIG: "false"
			ND_TRANSCODINGCACHESIZE:    "512MB"
			ND_ENABLESTARRATING:        "false"
			ND_ENABLEFAVOURITES:        "false"
		}
	}
	service: main: {
		annotations: "lbipam.cilium.io/ips": "192.168.2.12"
		controller:            "main"
		externalTrafficPolicy: "Local"
		ports: http: port: 4533
		type: "LoadBalancer"
	}
	route: main: {
		hostnames: ["{{ .Release.Name }}.brenix.com"]
		parentRefs: [{
			name:        "external"
			namespace:   "kube-system"
			sectionName: "https"
		}]
	}
	persistence: {
		config: {
			existingClaim: "navidrome-data"
			globalMounts: [{path: "/data"}]
		}
		music: {
			enabled: true
			type:    "nfs"
			server:  "truenas.home.arpa"
			path:    "/mnt/main/media"
			globalMounts: [{path: "/music", subPath: "music"}]
		}
	}
}
