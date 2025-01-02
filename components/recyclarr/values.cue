package holos

#Values: {
	controllers: recyclarr: {
		type: "cronjob"
		cronjob: {
			schedule:                "0 0 * * *"
			backoffLimit:            0
			concurrencyPolicy:       "Forbid"
			successfulJobsHistory:   1
			failedJobsHistory:       1
			ttlSecondsAfterFinished: 86400
		}
		containers: app: {
			image: {
				repository: "ghcr.io/recyclarr/recyclarr"
				tag:        "7.4.0@sha256:619c3b8920a179f2c578acd0f54e9a068f57c049aff840469eed66e93a4be2cf"
			}
			envFrom: [{
				secretRef: name: "recyclarr"
			}]
			args: ["sync"]
			securityContext: {
				allowPrivilegeEscalation: false
				readOnlyRootFilesystem:   true
				capabilities: drop: ["ALL"]
			}
			resources: {
				requests: cpu:  "10m"
				limits: memory: "128Mi"
			}
		}
		pod: restartPolicy: "Never"
	}
	defaultPodOptions: securityContext: {
		runAsNonRoot:        true
		runAsUser:           1000
		runAsGroup:          1000
		fsGroup:             1000
		fsGroupChangePolicy: "OnRootMismatch"
		seccompProfile: type: "RuntimeDefault"
	}
	persistence: {
		config: existingClaim: "recyclarr"
		"config-file": {
			type: "configMap"
			name: "recyclarr"
			globalMounts: [{
				path:     "/config/recyclarr.yml"
				subPath:  "recyclarr.yml"
				readOnly: true
			}]
		}
		"config-logs": {
			type: "emptyDir"
			globalMounts: [{path: "/config/logs"}]
		}
	}
}
