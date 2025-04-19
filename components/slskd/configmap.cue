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
				name=$(echo "$1" | tr -d '\\\\' | jq -r '@uri "\\(.localDirectoryName)"')
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
				      run:
				        executable: /bin/sh
				        arglist:
				          - -c
				          - /scripts/beets.sh "$SLSKD_SCRIPT_DATA"
				    debug:
				      on:
				        - DownloadDirectoryComplete
				      run:
				        executable: /bin/sh
				        arglist:
				          - -c
				          - echo "$SLSKD_SCRIPT_DATA" | tr -d '\\\\' >>/config/debug.txt
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
