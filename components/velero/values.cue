package holos

#Values: {
	initContainers: [{
		name:            "velero-plugin-for-csi"
		image:           "velero/velero-plugin-for-csi:v0.7.1"
		imagePullPolicy: "IfNotPresent"
		volumeMounts: [{
			mountPath: "/target"
			name:      "plugins"
		}]
	}, {
		name:            "velero-plugin-for-aws"
		image:           "velero/velero-plugin-for-aws:v1.13.1"
		imagePullPolicy: "IfNotPresent"
		volumeMounts: [{
			mountPath: "/target"
			name:      "plugins"
		}]
	}]
	credentials: {
		existingSecret: "minio-creds"
	}
	configuration: features: "EnableCSI"
	configuration: backupStorageLocation: [{
		name: "default"
		// provider is the name for the backup storage location provider.
		provider: "aws"
		// bucket is the name of the bucket to store backups in. Required.
		bucket: "velero"
		// default indicates this location is the default backup storage location. Optional.
		default:    true
		accessMode: "ReadWrite"
		config: {
			region:                "minio"
			s3ForcePathStyle:      true
			s3Url:                 "http://truenas.home.arpa:9000"
			publicUrl:             "http://truenas.home.arpa:9000"
			insecureSkipTLSVerify: true
		}
	}]
	configuration: volumeSnapshotLocation: [{
		name:     "default"
		provider: "aws"
		config: {
			region: "minio"
		}
	}]
	schedules: main: {
		schedule: "0 4 * * *"
		template: ttl: "24h0m0s"
	}
	deployNodeAgent: true
}
