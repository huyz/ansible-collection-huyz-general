import re

SENTINEL = 'BEGIN ANSIBLE MANAGED BLOCK: pyenv'

# These are the files that we expect to remain unchanged
UNCHANGED_CONFIG_FILES_RE = re.compile(r'.*(common_pyenv_init|unmarked_block).*')


def test_blockinfile(host, subtests):
    v = host.ansible.get_variables()
    home = v['ansible_user_dir']['__ansible_unsafe']

    for filename in v['config_files']:
        with subtests.test(key=filename):
            # Expand tilde
            filename = filename.replace('~/', f'{home}/')

            f = host.file(filename)
            assert f.exists
            assert f.is_file
            assert f.mode == 0o644

            assert f.contains(SENTINEL) != bool(UNCHANGED_CONFIG_FILES_RE.match(filename))
