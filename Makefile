# Useful targets:
# - test: sanity checks
# - build: used only for generating development tarball to be used by
#   dot-super/ansible
# - publish: no longer in use, as we rely on GitHub Actions

##############################################################################
# Config

COLLECTION_NAME := huyz.general

# For Rancher Desktop
CONTAINER_HOST_CMD := rdctl shell
# For Podman
#CONTAINER_HOST_CMD := podman machine ssh podman-machine-default

##############################################################################
# Internal variables

TARBALL_PREFIX = $(subst .,-,$(COLLECTION_NAME))

# For extglob support
SHELL := /bin/bash -O extglob

##############################################################################
# Tasks

.DEFAULT_GOAL := test

.PHONY: all
all: test publish


# Skip shell scripts and/or executables in bin/
.PHONY: test
test:
	ansible-test sanity --docker default -v --exclude '.*\.sh$$'

	@echo
	@for i in roles/*; do \
		if [ -e "$$i/Makefile" ]; then \
			echo "Running tests in $$i" ; \
			make -C "$$i" test ; \
		fi ; \
	done


# Running `ansible-test sanity --docker default -v` may give this error:
#
# ERROR: Host DockerConfig(python=NativePythonConfig(version='3.11', path='/usr/bin/python3.11'), name='default', image='quay.io/ansible/default-test-container:6.13.0', memory=None, privileged=False, seccomp='default', cgroup=CGroupVersion.V1_V2, audit=AuditMode.REQUIRED) job failed:
# The container host provides cgroup v1, but does not appear to be running systemd.
# The systemd cgroup subsystem was not found.
#
# Run the following commands as root on the container host to resolve this issue:
#
#   mkdir /sys/fs/cgroup/systemd
#   mount cgroup -t cgroup /sys/fs/cgroup/systemd -o none,name=systemd,xattr
#   chown -R {user}:{group} /sys/fs/cgroup/systemd  # only when rootless
#
# NOTE: These changes must be applied each time the container host is rebooted.
# FATAL: Host job(s) failed. See previous error(s) for details.
.PHONY: test-prep
test-prep:
	$(CONTAINER_HOST_CMD) sudo mkdir -p /sys/fs/cgroup/systemd
	$(CONTAINER_HOST_CMD) sudo mount cgroup -t cgroup /sys/fs/cgroup/systemd -o none,name=systemd,xattr
#	$(CONTAINER_HOST_CMD) sudo chown -R "$$(id -u):$$(id -g)" /sys/fs/cgroup/systemd  # only when rootless


# The symlink is for easy local installation of this collection
.PHONY: default
build:
	ansible-galaxy collection build -v --force
	@ls -1 $(TARBALL_PREFIX)-!(latest).tar.gz | sort -V | tail -n 1 \
		| xargs -I '{}' ln -sf '{}' '$(TARBALL_PREFIX)-latest.tar.gz'


.PHONY: publish
publish: build
ifndef ANSIBLE_GALAXY_API_KEY
	$(error ANSIBLE_GALAXY_API_KEY is not set. Did you run `direnv allow`?)
else
	@ls -1 $(TARBALL_PREFIX)-!(latest).tar.gz | sort -V | tail -n 1 \
		| xargs ansible-galaxy collection publish -v --api-key "$$ANSIBLE_GALAXY_API_KEY"
endif
