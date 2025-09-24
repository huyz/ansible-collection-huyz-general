==========================
huyz.general Release Notes
==========================

.. contents:: Topics

v1.1.4
======

Release Summary
---------------

| Release Date: 2025-09-23
| prompt_password - fix to handle `omit` placeholder

Bugfixes
--------

- prompt_password - handle `__omit_place_holder_` leaky abstraction

v1.1.3
======

Release Summary
---------------

| Release Date: 2025-06-13
| Update dependencies and pre-commit hooks
| Simplify testing

Minor Changes
-------------

- Add more pre-commit hooks
- In top-level Makefile, `make test` invokes `make test` in `roles/`
- Update README.md to mention testing

Bugfixes
--------

- Bump up all dependencies

v1.1.2
======

Release Summary
---------------

| Release Date: 2024-12-27
| prompt_password - specify Powershell executable for win_shell

Bugfixes
--------

- prompt_password - specify Powershell executable for win_shell

v1.1.1
======

Release Summary
---------------

| Release Date: 2024-08-05
| prompt_password - fix for non-Windows

Major Changes
-------------

- prompt_password - fix for non-Windows

v1.1.0
======

Release Summary
---------------

| Release Date: 2024-08-04
| prompt_password - support Windows

Major Changes
-------------

- prompt_password - support Windows

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
