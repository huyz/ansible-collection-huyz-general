TODO: test with multiple hosts

# Ansible role: huyz.general.password_prompt

Prompts for the `ansible_password` if not defined, with the option to also set the `ansible_become_password` if not defined.

This avoids the need to call `ansible-playbook` with `--ask-pass` and `--ask-become-pass`.

## Installation

This repo uses the FQCN convention.

Include the collection in the Ansible Galaxy `requirements.yml`:

```shell
---
collections:
  - name: huyz.general
```

You can then include the role `huyz.general.prompt_password`.

## Example

```yaml
- name: Prompt for ansible_password if needed
    ansible.builtin.include_role:
        name: huyz.generalprompt_password
    vars:
        copy_to_become_password: true
```
