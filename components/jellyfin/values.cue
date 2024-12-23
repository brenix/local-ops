package holos

#Values: {
	controllers: main: containers: main: {
		env: {
			PGID: 100
			PUID: 1000
			TZ:   "America/Los_Angeles"
		}
		image: {
			repository: "lscr.io/linuxserver/jellyfin"
			tag:        "10.10.3"
		}
	}
	defaultPodOptions: hostNetwork: true
	ingress: main: {
		annotations: "external-dns.alpha.kubernetes.io/target": "external.brenix.com"
		className: "external"
		hosts: [{
			host: "{{.Release.Name }}.brenix.com"
			paths: [{
				path: "/"
				service: {
					identifier: "main"
					port:       "http"
				}
			}]
		}]
		tls: [{
			hosts: ["{{.Release.Name }}.brenix.com"]
		}]
	}
	persistence: {
		config: {
			existingClaim: "jellyfin-data"
		}
		cache: {
			enabled:       true
			existingClaim: "jellyfin-cache"
			globalMounts: [{path: "/config/cache"}]
		}
		media: {
			enabled:       true
			existingClaim: "media"
			globalMounts: [{path: "/media"}]
		}
		transcode: {
			enabled: true
			type:    "emptyDir"
		}
	}
	service: main: {
		annotations: "lbipam.cilium.io/ips": "192.168.2.7"
		controller:            "main"
		externalTrafficPolicy: "Local"
		ports: http: port: 8096
		type: "LoadBalancer"
	}
}
