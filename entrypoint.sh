#!/bin/bash
set -e

if [ -z "$ANSIBLE_SSH_KEY_DATA" ]; then
  echo "Expecting ANSIBLE_SSH_KEY_DATA"
  exit 1
fi

echo "$ANSIBLE_SSH_KEY_DATA" | base64 --decode > /tmp/ssh.key
chmod 400 /tmp/ssh.key

if [ -n "$ANSIBLE_GALAXY_FILE" ] ; then
  echo "Installing dependencies via ansible-galaxy from $ANSIBLE_GALAXY_FILE"
  ansible-galaxy install -r "$ANSIBLE_GALAXY_FILE"
fi

bash -c "ansible-playbook --private-key=/tmp/ssh.key $*"
