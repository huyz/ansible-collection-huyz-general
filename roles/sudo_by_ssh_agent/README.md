# Ansible role: huyz.general.sudo_by_ssh_agent

Configures sudo to use the `libpam-ssh-agent-auth` package and authorize the
provided ssh key.

## Installation

This repo uses the FQCN convention.

Include the collection in the Ansible Galaxy `requirements.yml`:

```shell
---
collections:
  - name: huyz.general
```

You can then include the role `huyz.general.sudo_by_ssh_agent`.

## Example

```yaml
    - name: Authorize sudo by ssh agent
      ansible.builtin.include_role:
        name: huyz.general.sudo_by_ssh_agent
      vars:
        pub_files_for_sudo: ['~/.ssh/id_ed25519-vip.pub']
```
