SHELL := /usr/bin/env bash
export PATH := $(PWD)/bin:$(PATH)

PLATFORM := $(shell uname -s)
CLUSTERS := $(wildcard clusters/*)
COMPONENTS := $(foreach cluster, $(CLUSTERS), $(wildcard $(cluster)/*))
RENDERED := $(foreach cluster, $(CLUSTERS), $(wildcard $(subst clusters/,,rendered/$(cluster)/*)))

# Enable secondary expansion
.SECONDEXPANSION:

## Render kustomize for a given cell cluster
$(CLUSTERS): $$(wildcard $$@/*)

## Render kustomize for a given component
$(COMPONENTS):
ifdef OUT
	@echo "==> Rendering $@"
	@mkdir -p $(OUT)/$(subst clusters/,,$$(dirname $@))
	@kubectl kustomize $@ --enable-helm -o $(OUT)/$(subst clusters/,,$@.yaml)
else
	@kubectl kustomize --enable-helm $@
endif

## Remove stale rendered components/crds
cleanup:
	$(eval LIST1 := $(shell mktemp))
	$(eval LIST2 := $(shell mktemp))
	@printf '%s\n' $(sort $(subst .yaml,,$(RENDERED))) >$(LIST1)
	@printf '%s\n' $(sort $(subst clusters,rendered,$(COMPONENTS))) >$(LIST2)
	@comm -23 $(LIST1) $(LIST2) | xargs -I % -n1 rm -vf %.yaml
	@rm -f $(LIST1) $(LIST2)

.PHONY: $(CLUSTERS) $(COMPONENTS)
