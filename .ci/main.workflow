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

action "use mazer" {
  needs = "use ansible-galaxy"
  uses = "./"
  args = "-i .ci/hosts.ini .ci/playbook.yml"
  env = {
    ANSIBLE_GALAXY_FILE = ".ci/requirements.yml"
    ANSIBLE_USE_MAZER = "true"
    ANSIBLE_HOST_KEY_CHECKING = "False"
  }
  secrets = ["ANSIBLE_SSH_KEY_DATA"]
}
