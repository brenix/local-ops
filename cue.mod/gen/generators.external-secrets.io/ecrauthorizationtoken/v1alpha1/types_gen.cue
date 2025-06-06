// Code generated by timoni. DO NOT EDIT.

//timoni:generate timoni mod vendor crd -f https://raw.githubusercontent.com/external-secrets/external-secrets/refs/tags/v0.16.1/deploy/crds/bundle.yaml

package v1alpha1

import "strings"

// ECRAuthorizationTokenSpec uses the GetAuthorizationToken API to
// retrieve an
// authorization token.
// The authorization token is valid for 12 hours.
// The authorizationToken returned is a base64 encoded string that
// can be decoded
// and used in a docker login command to authenticate to a
// registry.
// For more information, see Registry authentication
// (https://docs.aws.amazon.com/AmazonECR/latest/userguide/Registries.html#registry_auth)
// in the Amazon Elastic Container Registry User Guide.
#ECRAuthorizationToken: {
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
	kind: "ECRAuthorizationToken"
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
	spec!: #ECRAuthorizationTokenSpec
}
#ECRAuthorizationTokenSpec: {
	// Auth defines how to authenticate with AWS
	auth?: {
		jwt?: {
			// A reference to a ServiceAccount resource.
			serviceAccountRef?: {
				// Audience specifies the `aud` claim for the service account
				// token
				// If the service account uses a well-known annotation for e.g.
				// IRSA or GCP Workload Identity
				// then this audiences will be appended to the list
				audiences?: [...string]

				// The name of the ServiceAccount resource being referred to.
				name!: strings.MaxRunes(253) & strings.MinRunes(1) & {
					=~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
				}

				// Namespace of the resource being referred to.
				// Ignored if referent is not cluster-scoped, otherwise defaults
				// to the namespace of the referent.
				namespace?: strings.MaxRunes(63) & strings.MinRunes(1) & {
					=~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
				}
			}
		}

		// AWSAuthSecretRef holds secret references for AWS credentials
		// both AccessKeyID and SecretAccessKey must be defined in order
		// to properly authenticate.
		secretRef?: {
			// The AccessKeyID is used for authentication
			accessKeyIDSecretRef?: {
				// A key in the referenced Secret.
				// Some instances of this field may be defaulted, in others it may
				// be required.
				key?: strings.MaxRunes(253) & strings.MinRunes(1) & {
					=~"^[-._a-zA-Z0-9]+$"
				}

				// The name of the Secret resource being referred to.
				name?: strings.MaxRunes(253) & strings.MinRunes(1) & {
					=~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
				}

				// The namespace of the Secret resource being referred to.
				// Ignored if referent is not cluster-scoped, otherwise defaults
				// to the namespace of the referent.
				namespace?: strings.MaxRunes(63) & strings.MinRunes(1) & {
					=~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
				}
			}

			// The SecretAccessKey is used for authentication
			secretAccessKeySecretRef?: {
				// A key in the referenced Secret.
				// Some instances of this field may be defaulted, in others it may
				// be required.
				key?: strings.MaxRunes(253) & strings.MinRunes(1) & {
					=~"^[-._a-zA-Z0-9]+$"
				}

				// The name of the Secret resource being referred to.
				name?: strings.MaxRunes(253) & strings.MinRunes(1) & {
					=~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
				}

				// The namespace of the Secret resource being referred to.
				// Ignored if referent is not cluster-scoped, otherwise defaults
				// to the namespace of the referent.
				namespace?: strings.MaxRunes(63) & strings.MinRunes(1) & {
					=~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
				}
			}

			// The SessionToken used for authentication
			// This must be defined if AccessKeyID and SecretAccessKey are
			// temporary credentials
			// see:
			// https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_use-resources.html
			sessionTokenSecretRef?: {
				// A key in the referenced Secret.
				// Some instances of this field may be defaulted, in others it may
				// be required.
				key?: strings.MaxRunes(253) & strings.MinRunes(1) & {
					=~"^[-._a-zA-Z0-9]+$"
				}

				// The name of the Secret resource being referred to.
				name?: strings.MaxRunes(253) & strings.MinRunes(1) & {
					=~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
				}

				// The namespace of the Secret resource being referred to.
				// Ignored if referent is not cluster-scoped, otherwise defaults
				// to the namespace of the referent.
				namespace?: strings.MaxRunes(63) & strings.MinRunes(1) & {
					=~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
				}
			}
		}
	}

	// Region specifies the region to operate in.
	region!: string

	// You can assume a role before making calls to the
	// desired AWS service.
	role?: string

	// Scope specifies the ECR service scope.
	// Valid options are private and public.
	scope?: string
}
