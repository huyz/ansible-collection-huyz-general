# Role: huyz.general.add_to_config_file

Safely insert a block into one or more shell config files:

- Handles dereferencing symlinks
- Adds empty line before ansible-managed block for easier reading
- Optionally, can check for existence of similar code to skip update

## Installation

This repo uses the FQCN convention.

Include the collection in the Ansible Galaxy `requirements.yml`:

```shell
---
collections:
  - name: huyz.general
```

You can then include the role `huyz.general.add_to_config_file`, in a loop if necessary.

## Usage

Here's an example task which installs system Python and pyenv.

```yaml
- name: Add .pyenv-init.sh to shell init file(s)
  ansible.builtin.include_role:
    name: huyz.general.add_to_config_file
  vars:
    path: "{{ item }}"
    block_id: pyenv
    block_content: |
      if [ -f ~/.pyenv-init.sh ]; then
          source ~/.pyenv-init.sh
      fi
    skip_if_match: '^\s*eval "\$\(pyenv init\b|^\s*source .*\.pyenv-init\.sh'
  loop:
    - ~/.bashrc
    - ~/.zshrc
```

### Required vars

- `path`: shell config file
- `block_id`: unique ID to be used for ansible-managed block
- `block_content`: block to be inserted into the config file

### Optional vars

- `skip_if_match`: Perl regex to search for in config file.
  If found, the block will not be inserted (but none will be removed either).
  Remember to escape backslashes (`\\`) and slashes (`\/`).
  E.g.:

  ```yaml
  skip_if_match: '^\s*eval "\$\(pyenv init\b'
  ```


## Development (of this repo)

### Running tests

To run the primary test suite:

```shell
make
```

To run all tests for all supported distros:

```shell
make .test-all-distros
```

### Writing tests

To develop tests (without destroying container):

```shell
make destroy converge verify
```

To peek inside container:

```shell
podman exec -it ansible-add_to_config_file bash
```
