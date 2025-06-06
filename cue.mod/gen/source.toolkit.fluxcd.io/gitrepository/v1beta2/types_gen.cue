// Code generated by timoni. DO NOT EDIT.

//timoni:generate timoni vendor crd -f https://github.com/fluxcd/source-controller/releases/download/v1.6.0/source-controller.crds.yaml

package v1beta2

import "strings"

// GitRepository is the Schema for the gitrepositories API.
#GitRepository: {
	// APIVersion defines the versioned schema of this representation
	// of an object.
	// Servers should convert recognized schemas to the latest
	// internal value, and
	// may reject unrecognized values.
	// More info:
	// https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
	apiVersion: "source.toolkit.fluxcd.io/v1beta2"

	// Kind is a string value representing the REST resource this
	// object represents.
	// Servers may infer this from the endpoint the client submits
	// requests to.
	// Cannot be updated.
	// In CamelCase.
	// More info:
	// https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
	kind: "GitRepository"
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

	// GitRepositorySpec specifies the required configuration to
	// produce an
	// Artifact for a Git repository.
	spec!: #GitRepositorySpec
}

// GitRepositorySpec specifies the required configuration to
// produce an
// Artifact for a Git repository.
#GitRepositorySpec: {
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

	// GitImplementation specifies which Git client library
	// implementation to
	// use. Defaults to 'go-git', valid values are ('go-git',
	// 'libgit2').
	// Deprecated: gitImplementation is deprecated now that 'go-git'
	// is the
	// only supported implementation.
	gitImplementation?: "go-git" | "libgit2" | *"go-git"

	// Ignore overrides the set of excluded patterns in the
	// .sourceignore format
	// (which is the same as .gitignore). If not provided, a default
	// will be used,
	// consult the documentation for your version to find out what
	// those are.
	ignore?: string

	// Include specifies a list of GitRepository resources which
	// Artifacts
	// should be included in the Artifact produced for this
	// GitRepository.
	include?: [...{
		// FromPath specifies the path to copy contents from, defaults to
		// the root
		// of the Artifact.
		fromPath?: string
		repository: {
			// Name of the referent.
			name: string
		}

		// ToPath specifies the path to copy contents to, defaults to the
		// name of
		// the GitRepositoryRef.
		toPath?: string
	}]

	// Interval at which to check the GitRepository for updates.
	interval: =~"^([0-9]+(\\.[0-9]+)?(ms|s|m|h))+$"

	// RecurseSubmodules enables the initialization of all submodules
	// within
	// the GitRepository as cloned from the URL, using their default
	// settings.
	recurseSubmodules?: bool

	// Reference specifies the Git reference to resolve and monitor
	// for
	// changes, defaults to the 'master' branch.
	ref?: {
		// Branch to check out, defaults to 'master' if no other field is
		// defined.
		branch?: string

		// Commit SHA to check out, takes precedence over all reference
		// fields.
		//
		// This can be combined with Branch to shallow clone the branch,
		// in which
		// the commit is expected to exist.
		commit?: string

		// Name of the reference to check out; takes precedence over
		// Branch, Tag and SemVer.
		//
		// It must be a valid Git reference:
		// https://git-scm.com/docs/git-check-ref-format#_description
		// Examples: "refs/heads/main", "refs/tags/v0.1.0",
		// "refs/pull/420/head", "refs/merge-requests/1/head"
		name?: string

		// SemVer tag expression to check out, takes precedence over Tag.
		semver?: string

		// Tag to check out, takes precedence over Branch.
		tag?: string
	}
	secretRef?: {
		// Name of the referent.
		name: string
	}

	// Suspend tells the controller to suspend the reconciliation of
	// this
	// GitRepository.
	suspend?: bool

	// Timeout for Git operations like cloning, defaults to 60s.
	timeout?: =~"^([0-9]+(\\.[0-9]+)?(ms|s|m))+$" | *"60s"

	// URL specifies the Git repository URL, it can be an HTTP/S or
	// SSH address.
	url: =~"^(http|https|ssh)://.*$"

	// Verification specifies the configuration to verify the Git
	// commit
	// signature(s).
	verify?: {
		// Mode specifies what Git object should be verified, currently
		// ('head').
		mode: "head"
		secretRef: {
			// Name of the referent.
			name: string
		}
	}
}
