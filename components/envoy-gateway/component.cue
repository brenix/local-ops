package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:        "envoy-gateway"
	Namespace:   "kube-system"
	EnableHooks: true
	Chart: {
		name: "oci://docker.io/envoyproxy/gateway-helm"
		// renovate: datasource=docker depName=docker.io/envoyproxy/gateway-helm
		version: "1.5.3"
		release: Name
	}

	Resources: {
		GatewayClass: (Name): {
			metadata: name:      "envoy"
			metadata: namespace: Namespace
			spec: {
				controllerName: "gateway.envoyproxy.io/gatewayclass-controller"
				parametersRef: {
					group:     "gateway.envoyproxy.io"
					kind:      "EnvoyProxy"
					name:      "config"
					namespace: "kube-system"
				}
			}
		}
		EnvoyProxy: (Name): {
			metadata: name:      "config"
			metadata: namespace: Namespace
			spec: {
				telemetry: metrics: prometheus: compression: type: "Gzip"
				shutdown: drainTimeout: "60s"
				logging: level: default: "info"
				provider: {
					type: "Kubernetes"
					kubernetes: {
						envoyDeployment: container: resources: {
							requests: {
								cpu:    "150m"
								memory: "640Mi"
							}
							limits: memory: "1Gi"
						}
						envoyService: {
							// Cilium's L2 announce doesn't support Local, since it announces on a
							// different node than the pod is running on.
							// https://github.com/cilium/cilium/issues/27800
							externalTrafficPolicy: "Cluster"
						}
					}
				}
			}
		}
		BackendTrafficPolicy: (Name): {
			metadata: name:      "backend"
			metadata: namespace: Namespace
			spec: {
				targetRefs: [{
					group: "gateway.networking.k8s.io"
					kind:  "Gateway"
					name:  "internal"
				}, {
					group: "gateway.networking.k8s.io"
					kind:  "Gateway"
					name:  "external"
				}]
				connection: bufferLimit: "8Mi"
				tcpKeepalive: {}
				timeout: http: requestTimeout: "0s"
				compression: [{
					type: "Brotli"
				}, {
					type: "Gzip"
				}]
			}
		}
		ClientTrafficPolicy: (Name): {
			metadata: name:      "client"
			metadata: namespace: Namespace
			spec: {
				targetRefs: [{
					group: "gateway.networking.k8s.io"
					kind:  "Gateway"
					name:  "internal"
				}, {
					group: "gateway.networking.k8s.io"
					kind:  "Gateway"
					name:  "external"
				}]
				clientIPDetection: xForwardedFor: numTrustedHops: 1
				connection: {
					bufferLimit:             "4Mi"
					maxAcceptPerSocketEvent: 0
				}
				tls: {
					minVersion: "1.2"
					alpnProtocols: [
						"h2",
						"http/1.1",
					]
				}
				http2: {
					initialStreamWindowSize:     "512Ki"
					initialConnectionWindowSize: "8Mi"
					onInvalidMessage:            "TerminateStream"
				}
				http3: {}
				timeout: http: requestReceivedTimeout: "0s"
				tcpKeepalive: {}
			}

		}
	}
}
