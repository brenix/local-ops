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
			ND_SCANSCHEDULE:            "12h"
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
		ports: http: port: 80
		type: "LoadBalancer"
	}
	ingress: main: {
		annotations: "external-dns.alpha.kubernetes.io/target": "external.brenix.com"
		className: "external"
		hosts: [{
			host: "music.brenix.com"
			paths: [{
				path: "/"
				service: {
					identifier: "main"
					port:       "http"
				}
			}]
		}]
		tls: [{
			hosts: ["music.brenix.com"]
		}]
	}
	persistence: {
		config: {
			existingClaim: "navidrome-data"
		}
		music: {
			enabled: true
			type:    "nfs"
			server:  "truenas.lan"
			path:    "/mnt/main/media"
			globalMounts: [{path: "/music", subPath: "music"}]
		}
	}
}
