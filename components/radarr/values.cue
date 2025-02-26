package holos

#Values: {
	controllers: main: containers: main: {
		env: {
			PGID: 1000
			PUID: 1000
			TZ:   "America/Los_Angeles"
		}
		image: {
			repository: "lscr.io/linuxserver/radarr"
			tag:        "5.19.3"
		}
		probes: liveness: {
			custom:  true
			enabled: true
			spec: {
				exec: command: [
					"/usr/bin/env",
					"bash",
					"-c",
					"curl --fail localhost:7878/api/v3/system/status?apiKey=`IFS=\\> && while read -d \\< E C; do if [[ $E = \"ApiKey\" ]]; then echo $C; fi; done < /config/config.xml`",
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
			host: "{{ .Release.Name }}.brenix.com"
			paths: [{
				path: "/"
				service: {
					identifier: "main"
					port:       "http"
				}
			}]
		}]
		tls: [{
			hosts: ["{{ .Release.Name }}.brenix.com"]
		}]
	}
	persistence: {
		config: {
			existingClaim: "radarr-data"
		}
		cache: {
			existingClaim: "radarr-cache"
			globalMounts: [{path: "/config/MediaCover"}]
		}
		media: {
			enabled: true
			type:    "nfs"
			server:  "truenas.lan"
			path:    "/mnt/main/media"
			globalMounts: [{path: "/media"}, {path: "/downloads", subPath: "downloads"}]
		}
	}
	service: main: {
		annotations: "lbipam.cilium.io/ips": "192.168.2.3"
		controller:            "main"
		externalTrafficPolicy: "Local"
		ports: http: port: 7878
		type: "LoadBalancer"
	}
}
