workflow "connect" {
  on = "push"
  resolves = "use mazer"
}

action "use ansible-galaxy" {
  uses = "./"
  args = "-i .ci/hosts.ini .ci/playbook.yml"
  env = {
    ANSIBLE_GALAXY_FILE = ".ci/requirements.yml"
    ANSIBLE_HOST_KEY_CHECKING = "False"
  }
  secrets = ["ANSIBLE_SSH_KEY_DATA"]
}

# filter and continue only if master branch, as collections
# are only supported by ansible>=2.8
action "master branch" {
  needs = "use ansible-galaxy"
  uses = "actions/bin/filter@master"
  args = "branch master"
}

action "use mazer" {
  needs = "use ansible-galaxy"
  args = "-i .ci/hosts.ini .ci/playbook-with-collections.yml"
  uses = "./"
  env = {
    ANSIBLE_MAZER_LOCKFILE = ".ci/lockfile.yml"
    ANSIBLE_HOST_KEY_CHECKING = "False"
  }
  secrets = ["ANSIBLE_SSH_KEY_DATA"]
}
