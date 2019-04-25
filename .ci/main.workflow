workflow "connect" {
  on = "push"
  resolves = "one"
}

action "one" {
  uses = "./"
  args = "-i .ci/hosts.ini .ci/playbook.yml"
  env = {
    ANSIBLE_GALAXY_FILE = ".ci/requirements.yml"
    ANSIBLE_HOST_KEY_CHECKING = "False"
  }
  secrets = ["ANSIBLE_SSH_KEY_DATA"]
}
