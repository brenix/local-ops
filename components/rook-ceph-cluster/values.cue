package holos

#Values: {
	monitoring: {
		enabled:               false
		createPrometheusRules: false
	}
	ingress: dashboard: {
		ingressClassName: "internal"
		host: {
			name: "rook.brenix.com"
			path: "/"
		}
	}
	toolbox: enabled: false
	configOverride: """
		[global]
		bdev_enable_discard = true
		bdev_async_discard = true
		osd_class_update_on_start = false

		"""
	cephClusterSpec: {
		crashCollector: disable: true
		dashboard: {
			enabled:            true
			urlPrefix:          "/"
			ssl:                false
			prometheusEndpoint: "http://prometheus-operated.monitoring.svc.cluster.local:9090"
		}
		network: {
			provider: "host"
			connections: requireMsgr2: true
		}
		resources: {
			mgr: {
				requests: {
					cpu:    "100m"
					memory: "512Mi"
				}
				limits: memory: "2Gi"
			}
			mon: {
				requests: {
					cpu:    "50m"
					memory: "512Mi"
				}
				limits: memory: "1Gi"
			}
			osd: {
				requests: {
					cpu:    "500m"
					memory: "2Gi"
				}
				limits: memory: "4Gi"
			}
			"mgr-sidecar": {
				requests: {
					cpu:    "50m"
					memory: "128Mi"
				}
				limits: memory: "256Mi"
			}
		}
		// storage: {
		// 	useAllNodes:   false
		// 	useAllDevices: false
		// 	config: osdsPerDevice: "1"
		// }
	}
	cephBlockPools: [{
		name: "ceph-blockpool"
		spec: {
			failureDomain: "host"
			replicated: size: 3
		}
		storageClass: {
			enabled:              true
			name:                 "ceph-block"
			isDefault:            true
			reclaimPolicy:        "Delete"
			allowVolumeExpansion: true
			volumeBindingMode:    "Immediate"
			parameters: {
				imageFormat:                                             "2"
				imageFeatures:                                           "layering"
				"csi.storage.k8s.io/provisioner-secret-name":            "rook-csi-rbd-provisioner"
				"csi.storage.k8s.io/provisioner-secret-namespace":       "rook-ceph"
				"csi.storage.k8s.io/controller-expand-secret-name":      "rook-csi-rbd-provisioner"
				"csi.storage.k8s.io/controller-expand-secret-namespace": "rook-ceph"
				"csi.storage.k8s.io/node-stage-secret-name":             "rook-csi-rbd-node"
				"csi.storage.k8s.io/node-stage-secret-namespace":        "rook-ceph"
				"csi.storage.k8s.io/fstype":                             "ext4"
			}
		}
	}]
	cephBlockPoolsVolumeSnapshotClass: {
		enabled:        true
		name:           "csi-ceph-blockpool"
		isDefault:      false
		deletionPolicy: "Delete"
	}

	cephFileSystems: []
	// cephFileSystems: [{
	// 	name: "ceph-filesystem"
	// 	spec: {
	// 		metadataPool: replicated: size: 3
	// 		dataPools: [{
	// 			failureDomain: "host"
	// 			replicated: size: 3
	// 			name: "data0"
	// 		}]
	// 		metadataServer: {
	// 			activeCount:       1
	// 			activeStandby:     true
	// 			priorityClassName: "system-cluster-critical"
	// 			resources: {
	// 				requests: {
	// 					cpu:    "100m"
	// 					memory: "1Gi"
	// 				}
	// 				limits: memory: "3Gi"
	// 			}
	// 		}
	// 	}
	// 	storageClass: {
	// 		enabled:              true
	// 		isDefault:            false
	// 		name:                 "ceph-filesystem"
	// 		reclaimPolicy:        "Delete"
	// 		allowVolumeExpansion: true
	// 		volumeBindingMode:    "Immediate"
	// 		parameters: {
	// 			"csi.storage.k8s.io/provisioner-secret-name":            "rook-csi-cephfs-provisioner"
	// 			"csi.storage.k8s.io/provisioner-secret-namespace":       "rook-ceph"
	// 			"csi.storage.k8s.io/controller-expand-secret-name":      "rook-csi-cephfs-provisioner"
	// 			"csi.storage.k8s.io/controller-expand-secret-namespace": "rook-ceph"
	// 			"csi.storage.k8s.io/node-stage-secret-name":             "rook-csi-cephfs-node"
	// 			"csi.storage.k8s.io/node-stage-secret-namespace":        "rook-ceph"
	// 			"csi.storage.k8s.io/fstype":                             "ext4"
	// 		}
	// 	}
	// }]

	// cephFileSystemVolumeSnapshotClass: {
	// 	enabled:        true
	// 	name:           "csi-ceph-filesystem"
	// 	isDefault:      false
	// 	deletionPolicy: "Delete"
	// }
	cephObjectStores: []
}