##############################################################################
# Config

# Custom images are pulled from https://hub.docker.com/u/huyz

#DEFAULT_MOL_DISTRO := ubuntu-22.04
DEFAULT_MOL_DISTRO := python-3
#DEFAULT_MOL_IMAGE := huyz/ansible-molecule-$(subst -,:,$(DEFAULT_MOL_DISTRO))
DEFAULT_MOL_IMAGE := $(subst -,:,$(DEFAULT_MOL_DISTRO))
DEFAULT_MOL_INSTANCE_NAME := ansible-add_to_config_file-$(DEFAULT_MOL_DISTRO)

#MOL_DISTROS := $(DEFAULT_MOL_DISTRO) ubuntu-20.04 ubuntu-18.04 debian-11
MOL_DISTROS := $(DEFAULT_MOL_DISTRO)


MOL_DRIVER := docker
VENV_NAME := venv
INSTALL_TIMESTAMP := $(VENV_NAME)/.timestamp

##############################################################################
# Init

# Default envvars referenced by molecule.yml, overridden below
export MOL_DISTRO := $(DEFAULT_MOL_DISTRO)
export MOL_IMAGE := $(DEFAULT_MOL_IMAGE)
export MOL_INSTANCE_NAME := $(DEFAULT_MOL_INSTANCE_NAME)

# Default is to run the default scenario for the default distro
.DEFAULT_GOAL := test-default

.PHONY: all
all: lint test

##############################################################################
# Install targets

# Install Python 3.11 first
.PHONY: install
install:
	poetry install
	poetry run pre-commit install --install-hooks

.PHONY: clean
clean:
	poetry env remove

.PHONY: update
update:
	poetry update
	poetry run pre-commit autoupdate


##############################################################################
# Development targets

.PHONY: lint
lint:
	poetry run ansible-lint --profile=production

##############################################################################
# Molecule targets (all for the default distro)

.PHONY: create
create:
	@echo "Running for distro: $(MOL_DISTRO)"
	poetry run molecule create

.PHONY: converge
converge:
	@echo "Running for distro: $(MOL_DISTRO)"
	poetry run molecule converge

.PHONY: verify
verify:
	@echo "Running for distro: $(MOL_DISTRO)"
	poetry run molecule verify

.PHONY: login
login:
	@echo "Running for distro: $(MOL_DISTRO)"
	poetry run molecule login

.PHONY: destroy
destroy:
	@echo "Running for distro: $(MOL_DISTRO)"
	poetry run molecule destroy

##############################################################################
# Test targets

# Default Makefile target
#.PHONY: test
test: test-default

## Run all tests against all distros
TEST_TARGETS := $(addprefix .test-distro-,$(MOL_DISTROS))
.PHONY: test-matrix
test-matrix: $(TEST_TARGETS)

## Run all tests against a specified distro
# E.g.: `make .test-distro-ubuntu-22.04`
$(TEST_TARGETS): export MOL_DISTRO = $(subst .test-distro-,,$@)
#$(TEST_TARGETS): export MOL_IMAGE = huyz/ansible-molecule-$(subst -,:,$(MOL_DISTRO))
$(TEST_TARGETS): export MOL_IMAGE = $(subst -,:,$(MOL_DISTRO))
$(TEST_TARGETS): export MOL_INSTANCE_NAME = ansible-add_to_config_file-$(MOL_DISTRO)
$(TEST_TARGETS):
	@env | fgrep MOL_
	@echo "Running for distro: $(MOL_DISTRO)"
	poetry run molecule test --all
# During development, prevent the container from being destroyed up on test failure
#	poetry run molecule destroy; \
#		poetry run molecule test --all --destroy=never

## Run all tests against the default distro
# If local, make sure TAILSCALE_CI_KEY env var is set.
# This is automatically populated in a GitHub Codespace.
.PHONY: test-all
test-all:
	poetry run molecule test --all

## Run the default test scenario against the default distro
.PHONY: test-default
test-default:
	poetry run molecule test --scenario-name default
