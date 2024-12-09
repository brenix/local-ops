package holos

import (
	"path"
	ks "kustomize.toolkit.fluxcd.io/kustomization/v1"
)

#ComponentConfig: {
	Name:          _
	Namespace:     _
	OutputBaseDir: _

	let ArtifactPath = path.Join([OutputBaseDir, "gitops", "\(Name).kustomization.gen.yaml"], path.Unix)
	let ResourcesPath = path.Join([OutputBaseDir, "components", Name], path.Unix)

	Artifacts: "\(Name)-kustomization": {
		artifact: ArtifactPath
		generators: [{
			kind:   "Resources"
			output: artifact
			resources: Kustomization: (Name): ks.#Kustomization & {
				metadata: name:      Name
				metadata: namespace: "flux-system"
				spec: {
					targetNamespace: Namespace
					interval:        "10m"
					path:            ResourcesPath
					prune:           true
					sourceRef: {
						kind: "OCIRepository"
						name: "default"
					}
				}
			}
		}]
	}
}
