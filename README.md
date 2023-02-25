# Ansible Collection: huyz.general

[![MIT licensed][badge-license]][link-license]
[![Galaxy Collection][badge-collection]][link-galaxy]
[![CI][badge-gh-actions]][link-gh-actions]

This Ansible collection contains roles for general use.

Look at the individual role's README for details:

- `huyz.general.add_to_config_file` ([documentation](https://github.com/huyz/ansible-collection-huyz-general/blob/master/roles/add_to_config_file/README.md))

## Development (of this repo)

1. Set `ANSIBLE_GALAXY_API_KEY` in `.env`

1. Run

    ```shell
    direnv allow
    ```

### Changelog9

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

### Lint

Stage your changes

```shell
pre-commit run -v
```

## GitHub Actions

- `lint.yml`
    - Triggered by push to master and pull requests
    - Runs pre-commit
- `release.yml`
    - Triggered by new tags
    - Builds collection and releases to Ansible Galaxy

## License

MIT

[badge-license]: https://img.shields.io/github/license/huyz/ansible-collection-huyz-general
[link-license]: https://github.com/huyz/ansible-collection-huyz-general/blob/master/LICENSE
[badge-collection]: https://img.shields.io/badge/collection-huyz.general-blue
[link-galaxy]: https://galaxy.ansible.com/huyz/general
[badge-gh-actions]: https://github.com/huyz/ansible-collection-huyz-general/workflows/CI/badge.svg?event=push
[link-gh-actions]: https://github.com/huyz/ansible-collection-huyz-general/actions?query=workflow%3ACI
