# Github Action for Ansible

Wrapper around [Ansible](https://ansible.com).

## Usage

The action checks for a `ANSIBLE_GALAXY_FILE` variable and, if exists, 
passes its content to `ansible-galaxy` to install dependencies. 
Dependencies are installed to `$HOME/.ansible`. The entrypoint to the 
action is the [`ansible-playbook`][playbook] command.

### Example workflow

```hcl
workflow "Run Ansible playbook" {
  on = "push"
  resolves = "run ansible"
}

action "run ansible" {
  uses = "popperized/ansible@master"
  args = "-i mystuff/hosts.ini mystuff/playbook.yml"
  env = {
    ANSIBLE_GALAXY_FILE = "mystuff/requirements.yml"
  }
  secrets = ["ANSIBLE_SSH_KEY_DATA"]
}
```

> **TIP**: to disable host key checking, the workflow can define the 
> `env` varaible:
>
>     ANSIBLE_HOST_KEY_CHECKING = "False"
>
> This variable is **not** used by the action, but it's read by 
> Ansible instead. See the [official documentation][docs] to obtain a 
> list of environment variables that Ansible can read.

### Environment

  * `ANSIBLE_GALAXY_FILE`. **Optional** Path to file containing an 
    [`ansible-galaxy` requirements file][galaxy].

### Secrets

  * `ANSIBLE_SSH_KEY_DATA`. **Required** A base64-encoded string 
    containing the private key used to authenticate with hosts 
    referenced in the ansible inventory. Example encoding from a 
    terminal: `cat ~/.ssh/id_rsa | base64`

## License

[MIT](LICENSE). Please see additional information in each 
subdirectory.

[playbook]: https://docs.ansible.com/ansible/2.4/ansible-playbook.html
[docs]: https://docs.ansible.com/ansible/latest/reference_appendices/config.html#environment-variables
[galaxy]: https://github.com/ansible/ansible/blob/3b29b50/docs/docsite/rst/reference_appendices/galaxy.rst#installing-multiple-roles-from-a-file
