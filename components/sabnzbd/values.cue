package holos

#Values: {
	controllers: main: containers: main: {
		env: {
			PGID: 1000
			PUID: 1000
			TZ:   "America/Los_Angeles"
		}
		image: {
			repository: "lscr.io/linuxserver/sabnzbd"
			tag:        "4.5.2"
		}
		probes: {
			liveness: {
				custom:  true
				enabled: true
				spec: {
					failureThreshold: 3
					httpGet: {
						path: "/api?mode=version"
						port: 8080
					}
					initialDelaySeconds: 0
					periodSeconds:       10
					timeoutSeconds:      1
				}
			}
			readiness: {
				custom:  true
				enabled: true
				spec: {
					failureThreshold: 3
					httpGet: {
						path: "/api?mode=version"
						port: 8080
					}
					initialDelaySeconds: 0
					periodSeconds:       10
					timeoutSeconds:      1
				}
			}
			startup: enabled: false
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
	persistence: {
		config: {
			existingClaim: "sabnzbd"
		}
		downloads: {
			enabled: true
			type:    "nfs"
			server:  "truenas.home.arpa"
			path:    "/mnt/main/media/downloads"
			globalMounts: [{path: "/downloads/complete", subPath: "complete"}]
		}
		incomplete: {
			type: "emptyDir"
			globalMounts: [{path: "/downloads/incomplete"}]
		}
	}
	service: main: {
		annotations: "lbipam.cilium.io/ips": "192.168.2.10"
		controller:            "main"
		externalTrafficPolicy: "Local"
		ports: http: port: 8080
		type: "LoadBalancer"
	}
}
