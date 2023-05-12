==========================
huyz.general Release Notes
==========================

.. contents:: Topics


v1.0.4
======

Release Summary
---------------

| Release Date: 2023-05-12
| Fix collection dependencies, ansible-lint, Makefile
| Upgrade Ansible version to 2.14.5 and other Python dependencies


Major Changes
-------------

- upgrade ansible version to 2.14.5 (since that's just what I'm testing)
- upgrade dependencies in `poetry.lock`

Minor Changes
-------------

- prompt_password - improved UI output

Bugfixes
--------

- Makefile - fix `test` target
- ansible-lint - fix dependency on distlib in pre-commit config
- ansible-lint - fix handling of `manifest` in galaxy.yml
- sudo_by_ssh_agent - fix this collection's dependency on `ansible.posix`

v1.0.3
======

Release Summary
---------------

| Release Date: 2023-03-09
| Initial release of the password_prompt role
| Initial release of the sudo_by_ssh_agent role


Major Changes
-------------

- prompt_password - initial commit
- sudo_by_ssh_agent - initial commit

v1.0.2
======

Release Summary
---------------

| Release Date: 2023-02-25
| Initial release, containing the add_to_config_file role


Major Changes
-------------

- add_to_config_file - initial commit
