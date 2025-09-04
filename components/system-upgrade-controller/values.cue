package holos

#Values: {
	controllers: "system-upgrade-controller": {
		strategy: "RollingUpdate"
		containers: app: {
			image: {
				repository: "docker.io/rancher/system-upgrade-controller"
				tag:        "v0.16.3"
			}
			env: {
				SYSTEM_UPGRADE_CONTROLLER_LEADER_ELECT: true
				SYSTEM_UPGRADE_CONTROLLER_NAME:         "{{ .Release.Name }}"
				SYSTEM_UPGRADE_CONTROLLER_NAMESPACE:    "{{ .Release.Namespace }}"
				SYSTEM_UPGRADE_CONTROLLER_NODE_NAME: valueFrom: fieldRef: fieldPath: "spec.nodeName"
				SYSTEM_UPGRADE_JOB_BACKOFF_LIMIT: "99"
				SYSTEM_UPGRADE_JOB_PRIVILEGED:    false
			}
			securityContext: {
				allowPrivilegeEscalation: false
				readOnlyRootFilesystem:   true
				capabilities: drop: ["ALL"]
			}
		}
	}
	defaultPodOptions: securityContext: {
		runAsNonRoot: true
		runAsUser:    1000
		runAsGroup:   1000
	}
	rawResources: talosServiceAccount: {
		apiVersion: "talos.dev/v1alpha1"
		kind:       "ServiceAccount"
		spec: spec: roles: ["os:admin"]
	}
	rbac: bindings: "system-upgrade-controller": {
		type: "ClusterRoleBinding"
		roleRef: {
			kind: "ClusterRole"
			name: "cluster-admin"
		}
		subjects: [{identifier: "system-upgrade-controller"}]
	}
	serviceAccount: "system-upgrade-controller": {}
}
