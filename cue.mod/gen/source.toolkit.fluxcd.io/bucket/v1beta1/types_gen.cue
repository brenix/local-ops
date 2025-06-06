// Code generated by timoni. DO NOT EDIT.

//timoni:generate timoni vendor crd -f https://github.com/fluxcd/source-controller/releases/download/v1.6.0/source-controller.crds.yaml

package v1beta1

import "strings"

// Bucket is the Schema for the buckets API
#Bucket: {
	// APIVersion defines the versioned schema of this representation
	// of an object.
	// Servers should convert recognized schemas to the latest
	// internal value, and
	// may reject unrecognized values.
	// More info:
	// https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
	apiVersion: "source.toolkit.fluxcd.io/v1beta1"

	// Kind is a string value representing the REST resource this
	// object represents.
	// Servers may infer this from the endpoint the client submits
	// requests to.
	// Cannot be updated.
	// In CamelCase.
	// More info:
	// https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
	kind: "Bucket"
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

	// BucketSpec defines the desired state of an S3 compatible bucket
	spec!: #BucketSpec
}

// BucketSpec defines the desired state of an S3 compatible bucket
#BucketSpec: {
	accessFrom?: {
		// NamespaceSelectors is the list of namespace selectors to which
		// this ACL applies.
		// Items in this list are evaluated using a logical OR operation.
		namespaceSelectors: [...{
			// MatchLabels is a map of {key,value} pairs. A single {key,value}
			// in the matchLabels
			// map is equivalent to an element of matchExpressions, whose key
			// field is "key", the
			// operator is "In", and the values array contains only "value".
			// The requirements are ANDed.
			matchLabels?: {
				[string]: string
			}
		}]
	}

	// The bucket name.
	bucketName: string

	// The bucket endpoint address.
	endpoint: string

	// Ignore overrides the set of excluded patterns in the
	// .sourceignore format
	// (which is the same as .gitignore). If not provided, a default
	// will be used,
	// consult the documentation for your version to find out what
	// those are.
	ignore?: string

	// Insecure allows connecting to a non-TLS S3 HTTP endpoint.
	insecure?: bool

	// The interval at which to check for bucket updates.
	interval: string

	// The S3 compatible storage provider name, default ('generic').
	provider?: "generic" | "aws" | "gcp" | *"generic"

	// The bucket region.
	region?: string
	secretRef?: {
		// Name of the referent.
		name: string
	}

	// This flag tells the controller to suspend the reconciliation of
	// this source.
	suspend?: bool

	// The timeout for download operations, defaults to 60s.
	timeout?: string | *"60s"
}
