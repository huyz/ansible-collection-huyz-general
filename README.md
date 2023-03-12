# Ansible Collection: huyz.general

[![MIT licensed][badge-license]][link-license]
[![Galaxy Collection][badge-collection]][link-galaxy]
[![CI][badge-gh-actions]][link-gh-actions]

This Ansible collection contains roles for general use.

## Usage

Roles:

- `huyz.general.add_to_config_file` ([README](https://github.com/huyz/ansible-collection-huyz-general/blob/master/roles/add_to_config_file/README.md))
    - Function: Safely insert a block into one or more shell config files.
    - Use case: Mainly intended to be re-used by other roles.
- `huyz.general.prompt_password` ([README](https://github.com/huyz/ansible-collection-huyz-general/blob/master/roles/prompt_password/README.md))
    - Function: Prompts for the `ansible_password` if not defined.
    - Use case: Avoid the need to call `ansible-playbook` with `--ask-pass` and `--ask-become-pass`.
- `huyz.general.sudo_by_ssh_agent` ([README](https://github.com/huyz/ansible-collection-huyz-general/blob/master/roles/sudo_by_ssh_agent/README.md))
    - Function: Configures sudo to use the `libpam-ssh-agent-auth` package and
      authorize the provided ssh key.
    - Use case: Avoid the need to authenticate with a password to run privileged commands.

---

## Development (of this repo)

1. Set `ANSIBLE_GALAXY_API_KEY` in `.env`

1. Run

    ```shell
    direnv allow
    ```

### How to update the Changelog

#### First time setup

One time, to initialize:

```shell
antsibull-changelog init .
```

Update the `title` and set `keep_fragments: true`.

#### After each change

Create a manual fragments in `changeslogs/fragments`.

To lint the fragments:

```shell
antsibull-changelog lint
```

#### For a new release

Create a manual fragments in `changeslogs/fragments` named `DATE_vVERSION_summary.yml` with `release_summary` property.

Generate the changelog for the release:

```shell
antsibull-changelog release --refresh-fragments --update-existing
```

### How to lint

First, stage your changes, then:

```shell
pre-commit run -v
```

### Overview of GitHub Actions

- `lint.yml`
    - Triggered by: push to master and pull requests; weekly
    - Runs pre-commit
- `ansible-molecule.yml`
    - Triggered by: push to master and pull requests; weekly
    - Runs Ansible Molecule on all the roles defined by the collection
- `publish.yml`
    - Triggered by new tags
    - Builds collection and publishes it to Ansible Galaxy

### How to publish on Ansible Galaxy

Typically:

1. Create a "GitHub release", while creating a new tag of the form `vX.Y.Z`.
1. The `publish.yml` GitHub Workflow should automatically publish a "Galaxy release".

Sometimes, the `release` GitHub Workflow fails.
(For example, on 2023-03-12, the `artis3n/ansible_galaxy_collection@v2` GitHub Action  ansible-galaxy, which failed with `ERROR! Use of "manifest" requires the python "distlib" library`.)

To manually trigger a "Galaxy release":

```shell
make publish
```

---

## License

MIT

[badge-license]: https://img.shields.io/github/license/huyz/ansible-collection-huyz-general
[link-license]: https://github.com/huyz/ansible-collection-huyz-general/blob/master/LICENSE
[badge-collection]: https://img.shields.io/badge/collection-huyz.general-blue
[link-galaxy]: https://galaxy.ansible.com/huyz/general
[badge-gh-actions]: https://github.com/huyz/ansible-collection-huyz-general/actions/workflows/ansible-molecule.yml/badge.svg?event=push
[link-gh-actions]: https://github.com/huyz/ansible-collection-huyz-general/actions/workflows/ansible-molecule.yml
