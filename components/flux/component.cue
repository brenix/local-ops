package holos

// import "encoding/yaml"

holos: Component.BuildPlan

Component: #Kustomize & {
	Name:      "flux"
	Namespace: "flux-system"
	KustomizeConfig: Kustomization: namespace: Namespace
	Resources: OCIRepository: {
		flux: {
			metadata: name:      "flux"
			metadata: namespace: Namespace
			spec: {
				interval: "10m"
				ref: {
					// renovate: datasource=github-releases depName=fluxcd/flux2
					tag: v2.6.2
				}
				url: "oci://ghcr.io/fluxcd/flux-manifests"
			}
		}
		default: {
			metadata: name:      "default"
			metadata: namespace: Namespace
			spec: {
				interval: "10m"
				ref: tag: "main"
				url: "oci://ghcr.io/brenix/local-ops"
			}
		}
	}

	// Resources: Kustomization: flux: {
	// 	metadata: name:      Name
	// 	metadata: namespace: Namespace
	// 	spec: {
	// 		interval: "10m"
	// 		path:     "./"
	// 		prune:    false
	// 		wait:     true
	// 		sourceRef: {
	// 			kind: "OCIRepository"
	// 			name: "flux"
	// 		}
	// 		patches: [
	// 			{
	// 				target: kind: "Deployment"
	// 				target: name: "'(kustomize-controller|helm-controller|source-controller)'"
	// 				patch: yaml.Marshal([
	// 					{
	// 						op:    "add"
	// 						path:  "/spec/template/spec/containers/0/args/-"
	// 						value: "--concurrent=12"
	// 					},
	// 					{
	// 						op:    "add"
	// 						path:  "/spec/template/spec/containers/0/args/-"
	// 						value: "--kube-api-qps=500"
	// 					},
	// 					{
	// 						op:    "add"
	// 						path:  "/spec/template/spec/containers/0/args/-"
	// 						value: "--kube-api-burst=1000"
	// 					},
	// 					{
	// 						op:    "add"
	// 						path:  "/spec/template/spec/containers/0/args/-"
	// 						value: "--requeue-dependency=5s"
	// 					},
	// 				])
	// 			},
	// 			{
	// 				target: kind: "Deployment"
	// 				target: name: "'(kustomize-controller|helm-controller|source-controller)'"
	// 				patch: yaml.Marshal([{
	// 					apiVersion: "apps/v1"
	// 					kind:       "Deployment"
	// 					metadata: name: "not-used"
	// 					spec: template: spec: containers: [{
	// 						name: "manager"
	// 						resources: limits: memory: "2Gi"
	// 					}]
	// 				}])
	// 			},
	// 			{
	// 				target: kind: "Deployment"
	// 				target: name: "kustomize-controller"
	// 				patch: """
	// 					- op: replace
	// 					  path: /spec/template/spec/volumes/0
	// 					  value:
	// 					    name: temp
	// 					    emptyDir:
	// 					      medium: Memory
	// 					"""
	// 			},
	// 		]
	// 	}
	// }

	Resources: Kustomization: "cluster-apps": {
		metadata: name:      "cluster-apps"
		metadata: namespace: Namespace
		spec: {
			interval: "10m"
			path:     "./gitops"
			prune:    true
			wait:     true
			sourceRef: {
				kind: "OCIRepository"
				name: "default"
			}
		}
	}
}
