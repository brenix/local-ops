package holos

Component: {
	Name:      string
	Namespace: string

	Resources: ConfigMap: (Name): {
		metadata: name:      Name
		metadata: namespace: Namespace
		data: {
			"beets.sh": """
				#!/usr/bin/env sh
				name=$(echo "$1" | awk -F'"localDirectoryName": "' '{print $2}' | awk -F'",' '{print $1}')
				wget -q -O/dev/null \\
				     --post-data "name=${name}&path=${name}" \\
				     --header="X-API-KEY: ${BETANIN_API_KEY}" \\
				     --header="User-Agent: notify-beats.sh" \\
				      "http://${BEETS_HOST}/api/torrents"

				"""
			"slskd.yml": """
				---
				directories:
				  downloads: /media/downloads/soulseek/complete
				  incomplete: /media/downloads/soulseek/incomplete
				flags:
				  no_version_check: true
				integration:
				  scripts:
				    beets:
				      on:
				        - DownloadDirectoryComplete
				      run: /bin/sh /scripts/beets.sh $DATA
				    debug:
				      on:
				        - DownloadDirectoryComplete
				      run: echo "$DATA" >> /config/debug.txt
				metrics:
				  enabled: true
				  url: /metrics
				  authentication:
				    disabled: true
				permissions:
				  file:
				    mode: 750
				remote_configuration: false
				shares:
				  directories:
				    - /media/downloads/soulseek/shared
				  filters:
				    - \\.ini$
				    - Thumbs.db$
				    - \\.DS_Store$

				"""
		}
	}
}
