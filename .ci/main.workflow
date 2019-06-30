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
  runs = ["sh", "-c", "ansible localhost -m newswangerd.collection_demo.real_facts"]
  env = {
    ANSIBLE_MAZER_LOCKFILE = ".ci/lockfile.yml"
    ANSIBLE_HOST_KEY_CHECKING = "False"
  }
  secrets = ["ANSIBLE_SSH_KEY_DATA"]
}
