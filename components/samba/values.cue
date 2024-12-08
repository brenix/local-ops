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
			pullPolicy: "Always"
			repository: "ghcr.io/crazy-max/samba"
			tag:        "4.19.9"
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
		downloads: {
			enabled: true
			globalMounts: [{path: "/downloads"}]
			hostPath:     "/media/downloads"
			hostPathType: "Directory"
			type:         "hostPath"
		}
		media: {
			enabled: true
			globalMounts: [{path: "/media"}]
			hostPath:     "/media"
			hostPathType: "Directory"
			type:         "hostPath"
		}
		temp: {
			enabled: true
			globalMounts: [{path: "/temp"}]
			hostPath:     "/tmp"
			hostPathType: "Directory"
			type:         "hostPath"
		}
	}
	service: main: {
		controller: "main"
		enabled:    false
	}
}
