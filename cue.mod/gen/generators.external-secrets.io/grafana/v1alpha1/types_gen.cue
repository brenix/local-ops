// Code generated by timoni. DO NOT EDIT.

//timoni:generate timoni mod vendor crd -f https://raw.githubusercontent.com/external-secrets/external-secrets/refs/tags/v0.16.1/deploy/crds/bundle.yaml

package v1alpha1

import "strings"

#Grafana: {
	// APIVersion defines the versioned schema of this representation
	// of an object.
	// Servers should convert recognized schemas to the latest
	// internal value, and
	// may reject unrecognized values.
	// More info:
	// https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
	apiVersion: "generators.external-secrets.io/v1alpha1"

	// Kind is a string value representing the REST resource this
	// object represents.
	// Servers may infer this from the endpoint the client submits
	// requests to.
	// Cannot be updated.
	// In CamelCase.
	// More info:
	// https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
	kind: "Grafana"
	metadata!: {
		name!: strings.MaxRunes(253) & strings.MinRunes(1) & {
			string
		}
		namespace!: strings.MaxRunes(63) & strings.MinRunes(1) & {
			string
		}
		labels?: {
			[string]: string
		}
		annotations?: {
			[string]: string
		}
	}

	// GrafanaSpec controls the behavior of the grafana generator.
	spec!: #GrafanaSpec
}

// GrafanaSpec controls the behavior of the grafana generator.
#GrafanaSpec: {
	// Auth is the authentication configuration to authenticate
	// against the Grafana instance.
	auth!: {
		// Basic auth credentials used to authenticate against the Grafana
		// instance.
		// Note: you need a token which has elevated permissions to create
		// service accounts.
		// See here for the documentation on basic roles offered by
		// Grafana:
		// https://grafana.com/docs/grafana/latest/administration/roles-and-permissions/access-control/rbac-fixed-basic-role-definitions/
		basic?: {
			// A basic auth password used to authenticate against the Grafana
			// instance.
			password!: {
				// The key where the token is found.
				key?: strings.MaxRunes(253) & strings.MinRunes(1) & {
					=~"^[-._a-zA-Z0-9]+$"
				}

				// The name of the Secret resource being referred to.
				name?: strings.MaxRunes(253) & strings.MinRunes(1) & {
					=~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
				}
			}

			// A basic auth username used to authenticate against the Grafana
			// instance.
			username!: string
		}

		// A service account token used to authenticate against the
		// Grafana instance.
		// Note: you need a token which has elevated permissions to create
		// service accounts.
		// See here for the documentation on basic roles offered by
		// Grafana:
		// https://grafana.com/docs/grafana/latest/administration/roles-and-permissions/access-control/rbac-fixed-basic-role-definitions/
		token?: {
			// The key where the token is found.
			key?: strings.MaxRunes(253) & strings.MinRunes(1) & {
				=~"^[-._a-zA-Z0-9]+$"
			}

			// The name of the Secret resource being referred to.
			name?: strings.MaxRunes(253) & strings.MinRunes(1) & {
				=~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
			}
		}
	}

	// ServiceAccount is the configuration for the service account
	// that
	// is supposed to be generated by the generator.
	serviceAccount!: {
		// Name is the name of the service account that will be created by
		// ESO.
		name!: string

		// Role is the role of the service account.
		// See here for the documentation on basic roles offered by
		// Grafana:
		// https://grafana.com/docs/grafana/latest/administration/roles-and-permissions/access-control/rbac-fixed-basic-role-definitions/
		role!: string
	}

	// URL is the URL of the Grafana instance.
	url!: string
}
