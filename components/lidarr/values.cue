package holos

#Values: {
	controllers: main: containers: main: {
		env: {
			PGID: 1000
			PUID: 1000
			TZ:   "America/Los_Angeles"
		}
		image: {
			repository: "lscr.io/linuxserver/lidarr"
			tag:        "2.12.4"
		}
		probes: liveness: {
			custom:  true
			enabled: true
			spec: {
				exec: command: [
					"/usr/bin/env",
					"bash",
					"-c",
					"curl --fail localhost:8686/api/v1/system/status?apiKey=`IFS=\\> && while read -d \\< E C; do if [[ $E = \"ApiKey\" ]]; then echo $C; fi; done < /config/config.xml`",
				]
				failureThreshold:    5
				initialDelaySeconds: 60
				periodSeconds:       10
				successThreshold:    1
				timeoutSeconds:      10
			}
		}
	}
	ingress: main: {
		className: "internal"
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
			existingClaim: "lidarr-data"
		}
		media: {
			enabled: true
			type:    "nfs"
			server:  "truenas.home.arpa"
			path:    "/mnt/main/media"
			globalMounts: [{path: "/media"}, {path: "/downloads", subPath: "downloads"}]
		}
	}
	service: main: {
		annotations: "lbipam.cilium.io/ips": "192.168.2.13"
		controller:            "main"
		externalTrafficPolicy: "Local"
		ports: http: port: 8686
		type: "LoadBalancer"
	}
}
