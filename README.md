# Ansible Collection: huyz.general

[![MIT licensed][badge-license]][link-license]
[![Galaxy Collection][badge-galaxy]][link-galaxy]

[![Run Molecule][badge-molecule]][link-molecule]
[![Run Linting](https://github.com/huyz/ansible-collection-huyz-general/actions/workflows/lint.yml/badge.svg)](https://github.com/huyz/ansible-collection-huyz-general/actions/workflows/lint.yml)
[![pre-commit.ci status](https://results.pre-commit.ci/badge/github/huyz/ansible-collection-huyz-general/master.svg)](https://results.pre-commit.ci/latest/github/huyz/ansible-collection-huyz-general/master)

[![Bandit](https://github.com/huyz/ansible-collection-huyz-general/actions/workflows/bandit.yml/badge.svg)](https://github.com/huyz/ansible-collection-huyz-general/actions/workflows/bandit.yml)
[![CodeQL](https://github.com/huyz/ansible-collection-huyz-general/actions/workflows/github-code-scanning/codeql/badge.svg)](https://github.com/huyz/ansible-collection-huyz-general/actions/workflows/github-code-scanning/codeql)
[![DevSkim](https://github.com/huyz/ansible-collection-huyz-general/actions/workflows/devskim.yml/badge.svg)](https://github.com/huyz/ansible-collection-huyz-general/actions/workflows/devskim.yml)
[![Snyk Python](https://github.com/huyz/ansible-collection-huyz-general/actions/workflows/snyk-python.yml/badge.svg)](https://github.com/huyz/ansible-collection-huyz-general/actions/workflows/snyk-python.yml)
[![SonarCloud](https://github.com/huyz/ansible-collection-huyz-general/actions/workflows/sonarcloud.yml/badge.svg)](https://github.com/huyz/ansible-collection-huyz-general/actions/workflows/sonarcloud.yml)
[![Dependency Review](https://github.com/huyz/ansible-collection-huyz-general/actions/workflows/dependency-review.yml/badge.svg)](https://github.com/huyz/ansible-collection-huyz-general/actions/workflows/dependency-review.yml)
[![Dependabot Updates](https://github.com/huyz/ansible-collection-huyz-general/actions/workflows/dependabot/dependabot-updates/badge.svg)](https://github.com/huyz/ansible-collection-huyz-general/actions/workflows/dependabot/dependabot-updates)

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

### Initializing

1. Set `ANSIBLE_GALAXY_API_KEY` in `.env`

1. Run

    ```shell
    direnv allow
    ```

### Testing

```shell
make test
```

### Linting

First, stage your changes, then:

```shell
pre-commit run -v
```

### Updating the Changelog

#### First time setup

One time, to initialize:

```shell
antsibull-changelog init .
```

Update the `title` and set `keep_fragments: true`.

#### After each change

First, create a manual fragments in `changeslogs/fragments`.

Then, to lint the fragments:

```shell
antsibull-changelog lint
```

#### To test out in dot-super/general

```shell
make build
```

In `dot-super/general`, have `requirements.yml` contain:

```yaml
collections:
  # my own collection (the development version)
  - name: ../../ansible-collection-huyz-general/huyz-general-latest.tar.gz
```

```shell
# Add -f to force the update
install.sh
```

#### For a new release

Update `version` field in `galaxy.yml`.

If you haven't already, create a manual fragment in `changeslogs/fragments` named `DATE_vVERSION_summary.yml` with `release_summary` property.

Then, generate the changelog for the release:

```shell
antsibull-changelog release --refresh-fragments --update-existing
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

### Publishing on Ansible Galaxy

Typically:

1. Draft a new "GitHub release":
    1. Choose tag: create new tag of the form `vX.Y.Z`.
    1. Title: `vX.Y.Z`
    1. Description: paste in the entry from the auto-generated `CHANGELOG.rst`
    1. Check `Set as a pre-release`
1. The `publish.yml` GitHub Workflow should automatically publish a "Galaxy release".
1. Check the action results. If successful, edit the GitHub release:
    1. Uncheck `Set as a pre-release`
    1. Check `Set as the latest release`

Note that the "Publish on Galaxy" action can be triggered manually on github.com

To manually trigger a "Galaxy release" at the command line:

```shell
make publish
```

---

## License

MIT

[badge-license]: https://img.shields.io/github/license/huyz/ansible-collection-huyz-general
[link-license]: https://github.com/huyz/ansible-collection-huyz-general/blob/master/LICENSE
[badge-galaxy]: https://img.shields.io/badge/collection-huyz.general-blue
[link-galaxy]: https://galaxy.ansible.com/ui/repo/published/huyz/general/
[badge-molecule]: https://github.com/huyz/ansible-collection-huyz-general/actions/workflows/ansible-molecule.yml/badge.svg?event=push
[link-molecule]: https://github.com/huyz/ansible-collection-huyz-general/actions/workflows/ansible-molecule.yml
