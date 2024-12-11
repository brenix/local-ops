package holos

#Values: {
	controllers: main: containers: main: {
		env: {
			PGID: 1000
			PUID: 1000
			TZ:   "America/Los_Angeles"
		}
		image: {
			repository: "lscr.io/linuxserver/sonarr"
			tag:        "4.0.11"
		}
		probes: liveness: {
			custom:  true
			enabled: true
			spec: {
				exec: command: [
					"/usr/bin/env",
					"bash",
					"-c",
					"curl --fail localhost:8989/api/v3/system/status?apiKey=`IFS=\\> && while read -d \\< E C; do if [[ $E = \"ApiKey\" ]]; then echo $C; fi; done < /config/config.xml`",
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
			accessMode: "ReadWriteOnce"
			enabled:    true
			globalMounts: [{path: "/config"}]
			size: "1Gi"
			type: "persistentVolumeClaim"
		}
		downloads: {
			enabled: true
			globalMounts: [{path: "/downloads"}]
			hostPath: "/media/downloads"
			type:     "hostPath"
		}
		media: {
			enabled: true
			globalMounts: [{path: "/media"}]
			hostPath:     "/media"
			hostPathType: "Directory"
			type:         "hostPath"
		}
	}
	service: main: {
		annotations: "metallb.universe.tf/loadBalancerIPs": "192.168.2.4"
		controller:            "main"
		externalTrafficPolicy: "Local"
		ports: http: port: 8989
		type: "LoadBalancer"
	}
}
