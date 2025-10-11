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
			tag:        "nightly-version-2025100605ubu2404"
			pullPolicy: "Always"
		}
		resources: {
			requests: memory: "512Mi"
			limits: memory:   "8Gi"
		}
		securityContext: privileged: true
	}
	route: main: {
		hostnames: ["{{ .Release.Name }}.brenix.com"]
		parentRefs: [{
			name:        "external"
			namespace:   "kube-system"
			sectionName: "https"
		}]
		rules: [
			{
				backendRefs: [
					{
						group:     ""
						kind:      "Service"
						name:      "jellyfin"
						namespace: "default"
						port:      8096
						weight:    1
					},
				]
				timeouts: {
					request: "1h"
				}
			},
		]
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
			enabled: true
			type:    "nfs"
			server:  "truenas.home.arpa"
			path:    "/mnt/main/media"
			globalMounts: [{path: "/media"}]
		}
		transcode: {
			enabled: true
			type:    "emptyDir"
		}
		dri: {
			enabled:      true
			type:         "hostPath"
			hostPathType: "Directory"
			hostPath:     "/dev/dri"
		}
	}
	service: main: {
		annotations: "lbipam.cilium.io/ips": "192.168.2.7"
		controller:            "main"
		externalTrafficPolicy: "Local"
		ports: http: {
			port:        8096
			appProtocol: "kubernetes.io/ws"
		}
		type: "LoadBalancer"
	}
}
