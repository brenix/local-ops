// Code generated by timoni. DO NOT EDIT.

//timoni:generate timoni mod vendor crd -f https://raw.githubusercontent.com/external-secrets/external-secrets/refs/tags/v0.16.1/deploy/crds/bundle.yaml

package v1beta1

import (
	"strings"
	"struct"
)

// ClusterExternalSecret is the Schema for the
// clusterexternalsecrets API.
#ClusterExternalSecret: {
	// APIVersion defines the versioned schema of this representation
	// of an object.
	// Servers should convert recognized schemas to the latest
	// internal value, and
	// may reject unrecognized values.
	// More info:
	// https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
	apiVersion: "external-secrets.io/v1beta1"

	// Kind is a string value representing the REST resource this
	// object represents.
	// Servers may infer this from the endpoint the client submits
	// requests to.
	// Cannot be updated.
	// In CamelCase.
	// More info:
	// https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
	kind: "ClusterExternalSecret"
	metadata!: {
		name!: strings.MaxRunes(253) & strings.MinRunes(1) & {
			string
		}
		namespace?: strings.MaxRunes(63) & strings.MinRunes(1) & {
			string
		}
		labels?: {
			[string]: string
		}
		annotations?: {
			[string]: string
		}
	}

	// ClusterExternalSecretSpec defines the desired state of
	// ClusterExternalSecret.
	spec!: #ClusterExternalSecretSpec
}

// ClusterExternalSecretSpec defines the desired state of
// ClusterExternalSecret.
#ClusterExternalSecretSpec: {
	// The metadata of the external secrets to be created
	externalSecretMetadata?: {
		annotations?: close({
			[string]: string
		})
		labels?: close({
			[string]: string
		})
	}

	// The name of the external secrets to be created.
	// Defaults to the name of the ClusterExternalSecret
	externalSecretName?: strings.MaxRunes(253) & strings.MinRunes(1) & {
		=~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
	}

	// The spec for the ExternalSecrets to be created
	externalSecretSpec!: {
		// Data defines the connection between the Kubernetes Secret keys
		// and the Provider data
		data?: [...{
			// RemoteRef points to the remote secret and defines
			// which secret (version/property/..) to fetch.
			remoteRef!: {
				// Used to define a conversion Strategy
				conversionStrategy?: "Default" | "Unicode"

				// Used to define a decoding Strategy
				decodingStrategy?: "Auto" | "Base64" | "Base64URL" | "None"

				// Key is the key used in the Provider, mandatory
				key!: string

				// Policy for fetching tags/labels from provider secrets, possible
				// options are Fetch, None. Defaults to None
				metadataPolicy?: "None" | "Fetch"

				// Used to select a specific property of the Provider value (if a
				// map), if supported
				property?: string

				// Used to select a specific version of the Provider value, if
				// supported
				version?: string
			}

			// The key in the Kubernetes Secret to store the value.
			secretKey!: strings.MaxRunes(253) & strings.MinRunes(1) & {
				=~"^[-._a-zA-Z0-9]+$"
			}

			// SourceRef allows you to override the source
			// from which the value will be pulled.
			sourceRef?: struct.MaxFields(1) & struct.MinFields(1) & {
				// GeneratorRef points to a generator custom resource.
				//
				// Deprecated: The generatorRef is not implemented in .data[].
				// this will be removed with v1.
				generatorRef?: {
					// Specify the apiVersion of the generator resource
					apiVersion?: string

					// Specify the Kind of the generator resource
					kind!: "ACRAccessToken" | "ClusterGenerator" | "ECRAuthorizationToken" | "Fake" | "GCRAccessToken" | "GithubAccessToken" | "QuayAccessToken" | "Password" | "STSSessionToken" | "UUID" | "VaultDynamicSecret" | "Webhook" | "Grafana"

					// Specify the name of the generator resource
					name!: strings.MaxRunes(253) & strings.MinRunes(1) & {
						=~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
					}
				}

				// SecretStoreRef defines which SecretStore to fetch the
				// ExternalSecret data.
				storeRef?: {
					// Kind of the SecretStore resource (SecretStore or
					// ClusterSecretStore)
					// Defaults to `SecretStore`
					kind?: "SecretStore" | "ClusterSecretStore"

					// Name of the SecretStore resource
					name?: strings.MaxRunes(253) & strings.MinRunes(1) & {
						=~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
					}
				}
			}
		}]

		// DataFrom is used to fetch all properties from a specific
		// Provider data
		// If multiple entries are specified, the Secret keys are merged
		// in the specified order
		dataFrom?: [...{
			// Used to extract multiple key/value pairs from one secret
			// Note: Extract does not support sourceRef.Generator or
			// sourceRef.GeneratorRef.
			extract?: {
				// Used to define a conversion Strategy
				conversionStrategy?: "Default" | "Unicode"

				// Used to define a decoding Strategy
				decodingStrategy?: "Auto" | "Base64" | "Base64URL" | "None"

				// Key is the key used in the Provider, mandatory
				key!: string

				// Policy for fetching tags/labels from provider secrets, possible
				// options are Fetch, None. Defaults to None
				metadataPolicy?: "None" | "Fetch"

				// Used to select a specific property of the Provider value (if a
				// map), if supported
				property?: string

				// Used to select a specific version of the Provider value, if
				// supported
				version?: string
			}

			// Used to find secrets based on tags or regular expressions
			// Note: Find does not support sourceRef.Generator or
			// sourceRef.GeneratorRef.
			find?: {
				// Used to define a conversion Strategy
				conversionStrategy?: "Default" | "Unicode"

				// Used to define a decoding Strategy
				decodingStrategy?: "Auto" | "Base64" | "Base64URL" | "None"
				name?: {
					// Finds secrets base
					regexp?: string
				}

				// A root path to start the find operations.
				path?: string

				// Find secrets based on tags.
				tags?: close({
					[string]: string
				})
			}

			// Used to rewrite secret Keys after getting them from the secret
			// Provider
			// Multiple Rewrite operations can be provided. They are applied
			// in a layered order (first to last)
			rewrite?: [...{
				// Used to rewrite with regular expressions.
				// The resulting key will be the output of a regexp.ReplaceAll
				// operation.
				regexp?: {
					// Used to define the regular expression of a re.Compiler.
					source!: string

					// Used to define the target pattern of a ReplaceAll operation.
					target!: string
				}
				transform?: {
					// Used to define the template to apply on the secret name.
					// `.value ` will specify the secret name in the template.
					template!: string
				}
			}]

			// SourceRef points to a store or generator
			// which contains secret values ready to use.
			// Use this in combination with Extract or Find pull values out of
			// a specific SecretStore.
			// When sourceRef points to a generator Extract or Find is not
			// supported.
			// The generator returns a static map of values
			sourceRef?: struct.MaxFields(1) & struct.MinFields(1) & {
				// GeneratorRef points to a generator custom resource.
				generatorRef?: {
					// Specify the apiVersion of the generator resource
					apiVersion?: string

					// Specify the Kind of the generator resource
					kind!: "ACRAccessToken" | "ClusterGenerator" | "ECRAuthorizationToken" | "Fake" | "GCRAccessToken" | "GithubAccessToken" | "QuayAccessToken" | "Password" | "STSSessionToken" | "UUID" | "VaultDynamicSecret" | "Webhook" | "Grafana"

					// Specify the name of the generator resource
					name!: strings.MaxRunes(253) & strings.MinRunes(1) & {
						=~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
					}
				}

				// SecretStoreRef defines which SecretStore to fetch the
				// ExternalSecret data.
				storeRef?: {
					// Kind of the SecretStore resource (SecretStore or
					// ClusterSecretStore)
					// Defaults to `SecretStore`
					kind?: "SecretStore" | "ClusterSecretStore"

					// Name of the SecretStore resource
					name?: strings.MaxRunes(253) & strings.MinRunes(1) & {
						=~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
					}
				}
			}
		}]

		// RefreshInterval is the amount of time before the values are
		// read again from the SecretStore provider,
		// specified as Golang Duration strings.
		// Valid time units are "ns", "us" (or "µs"), "ms", "s", "m", "h"
		// Example values: "1h", "2h30m", "10s"
		// May be set to zero to fetch and create it once. Defaults to 1h.
		refreshInterval?: string

		// RefreshPolicy determines how the ExternalSecret should be
		// refreshed:
		// - CreatedOnce: Creates the Secret only if it does not exist and
		// does not update it thereafter
		// - Periodic: Synchronizes the Secret from the external source at
		// regular intervals specified by refreshInterval.
		// No periodic updates occur if refreshInterval is 0.
		// - OnChange: Only synchronizes the Secret when the
		// ExternalSecret's metadata or specification changes
		refreshPolicy?: "CreatedOnce" | "Periodic" | "OnChange"

		// SecretStoreRef defines which SecretStore to fetch the
		// ExternalSecret data.
		secretStoreRef?: {
			// Kind of the SecretStore resource (SecretStore or
			// ClusterSecretStore)
			// Defaults to `SecretStore`
			kind?: "SecretStore" | "ClusterSecretStore"

			// Name of the SecretStore resource
			name?: strings.MaxRunes(253) & strings.MinRunes(1) & {
				=~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
			}
		}

		// ExternalSecretTarget defines the Kubernetes Secret to be
		// created
		// There can be only one target per ExternalSecret.
		target?: {
			// CreationPolicy defines rules on how to create the resulting
			// Secret.
			// Defaults to "Owner"
			creationPolicy?: "Owner" | "Orphan" | "Merge" | "None"

			// DeletionPolicy defines rules on how to delete the resulting
			// Secret.
			// Defaults to "Retain"
			deletionPolicy?: "Delete" | "Merge" | "Retain"

			// Immutable defines if the final secret will be immutable
			immutable?: bool

			// The name of the Secret resource to be managed.
			// Defaults to the .metadata.name of the ExternalSecret resource
			name?: strings.MaxRunes(253) & strings.MinRunes(1) & {
				=~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
			}

			// Template defines a blueprint for the created Secret resource.
			template?: {
				data?: close({
					[string]: string
				})

				// EngineVersion specifies the template engine version
				// that should be used to compile/execute the
				// template specified in .data and .templateFrom[].
				engineVersion?: "v2"
				mergePolicy?:   "Replace" | "Merge"

				// ExternalSecretTemplateMetadata defines metadata fields for the
				// Secret blueprint.
				metadata?: {
					annotations?: close({
						[string]: string
					})
					labels?: close({
						[string]: string
					})
				}
				templateFrom?: [...{
					configMap?: {
						// A list of keys in the ConfigMap/Secret to use as templates for
						// Secret data
						items!: [...{
							// A key in the ConfigMap/Secret
							key!: strings.MaxRunes(253) & strings.MinRunes(1) & {
								=~"^[-._a-zA-Z0-9]+$"
							}
							templateAs?: "Values" | "KeysAndValues"
						}]

						// The name of the ConfigMap/Secret resource
						name!: strings.MaxRunes(253) & strings.MinRunes(1) & {
							=~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
						}
					}
					literal?: string
					secret?: {
						// A list of keys in the ConfigMap/Secret to use as templates for
						// Secret data
						items!: [...{
							// A key in the ConfigMap/Secret
							key!: strings.MaxRunes(253) & strings.MinRunes(1) & {
								=~"^[-._a-zA-Z0-9]+$"
							}
							templateAs?: "Values" | "KeysAndValues"
						}]

						// The name of the ConfigMap/Secret resource
						name!: strings.MaxRunes(253) & strings.MinRunes(1) & {
							=~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
						}
					}
					target?: "Data" | "Annotations" | "Labels"
				}]
				type?: string
			}
		}
	}

	// The labels to select by to find the Namespaces to create the
	// ExternalSecrets in.
	// Deprecated: Use NamespaceSelectors instead.
	namespaceSelector?: {
		// matchExpressions is a list of label selector requirements. The
		// requirements are ANDed.
		matchExpressions?: [...{
			// key is the label key that the selector applies to.
			key!: string

			// operator represents a key's relationship to a set of values.
			// Valid operators are In, NotIn, Exists and DoesNotExist.
			operator!: string

			// values is an array of string values. If the operator is In or
			// NotIn,
			// the values array must be non-empty. If the operator is Exists
			// or DoesNotExist,
			// the values array must be empty. This array is replaced during a
			// strategic
			// merge patch.
			values?: [...string]
		}]

		// matchLabels is a map of {key,value} pairs. A single {key,value}
		// in the matchLabels
		// map is equivalent to an element of matchExpressions, whose key
		// field is "key", the
		// operator is "In", and the values array contains only "value".
		// The requirements are ANDed.
		matchLabels?: close({
			[string]: string
		})
	}

	// A list of labels to select by to find the Namespaces to create
	// the ExternalSecrets in. The selectors are ORed.
	namespaceSelectors?: [...{
		// matchExpressions is a list of label selector requirements. The
		// requirements are ANDed.
		matchExpressions?: [...{
			// key is the label key that the selector applies to.
			key!: string

			// operator represents a key's relationship to a set of values.
			// Valid operators are In, NotIn, Exists and DoesNotExist.
			operator!: string

			// values is an array of string values. If the operator is In or
			// NotIn,
			// the values array must be non-empty. If the operator is Exists
			// or DoesNotExist,
			// the values array must be empty. This array is replaced during a
			// strategic
			// merge patch.
			values?: [...string]
		}]

		// matchLabels is a map of {key,value} pairs. A single {key,value}
		// in the matchLabels
		// map is equivalent to an element of matchExpressions, whose key
		// field is "key", the
		// operator is "In", and the values array contains only "value".
		// The requirements are ANDed.
		matchLabels?: close({
			[string]: string
		})
	}]

	// Choose namespaces by name. This field is ORed with anything
	// that NamespaceSelectors ends up choosing.
	// Deprecated: Use NamespaceSelectors instead.
	namespaces?: [...strings.MaxRunes(63) & strings.MinRunes(1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"]

	// The time in which the controller should reconcile its objects
	// and recheck namespaces for labels.
	refreshTime?: string
}
