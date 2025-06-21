package holos

#Values: {
	configMaps: config: {
		data: "config.yml": """
			auth:
			  - user: nobody
			    group: nobody
			    uid: 65534
			    gid: 65534
			    password:

			global:
			  - "force user = nobody"
			  - "force group = nobody"

			share:
			  - name: downloads
			    path: /downloads
			    browseable: yes
			    readonly: no
			    guestok: yes
			    validusers: nobody
			    writelist: nobody
			    veto: no
			  - name: media
			    path: /media
			    browseable: yes
			    readonly: no
			    guestok: yes
			    validusers: nobody
			    writelist: nobody
			    veto: no
			  - name: tmp
			    path: /temp
			    browseable: yes
			    readonly: no
			    guestok: yes
			    validusers: nobody
			    writelist: nobody
			    veto: no

			"""
		enabled: true
	}
	controllers: main: containers: main: {
		env: {
			CONFIG_FILE: "/config/config.yml"
			TZ:          "America/Los_Angeles"
		}
		image: {
			repository: "ghcr.io/crazy-max/samba"
			tag:        "4.21.4"
		}
	}
	defaultPodOptions: {
		hostNetwork:                   true
		terminationGracePeriodSeconds: 15
	}
	persistence: {
		config: {
			enabled: true
			name:    "samba-config"
			type:    "configMap"
		}
		media: {
			enabled:       true
			existingClaim: "media"
			globalMounts: [{path: "/media"}, {path: "/downloads", subPath: "downloads"}]
		}
		temp: {
			enabled: true
			globalMounts: [{path: "/temp"}]
			type: "emptyDir"
		}
	}
	service: main: {
		controller: "main"
		enabled:    false
	}
}
