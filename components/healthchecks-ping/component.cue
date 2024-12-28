package holos

holos: Component.BuildPlan

Component: #Kubernetes & {
	Name:      "healthchecks-ping"
	Namespace: "monitoring"
	Resources: {
		CronJob: healthchecksio: {
			metadata: name:      Name
			metadata: namespace: Namespace
			spec: {
				schedule:                   "*/20 * * * *"
				concurrencyPolicy:          "Forbid"
				successfulJobsHistoryLimit: 1
				jobTemplate: spec: {
					ttlSecondsAfterFinished: 300
					template: spec: {
						restartPolicy: "Never"
						containers: [{
							name:  "healthcheck-ping"
							image: "cgr.dev/chainguard/curl:latest"
							args: ["$(HC_URL)"]
							env: [{
								name: "HC_URL"
								valueFrom: secretKeyRef: {
									name: Name
									key:  "url"
								}
							}]
						}]
					}
				}
			}
		}
		ExternalSecret: healthchecksio: {
			metadata: name:      Name
			metadata: namespace: Namespace
			spec: {
				target: name: metadata.name
				target: template: {
					engineVersion: "v2"
					data: url: "{{ .HEALTHCHECKS_IO_URL }}"
				}
				data: [{secretKey: "HEALTHCHECKS_IO_URL", remoteRef: {key: "HEALTHCHECKS_IO_URL"}}]
				secretStoreRef: kind: "ClusterSecretStore"
				secretStoreRef: name: "doppler"
			}
		}
	}
}
