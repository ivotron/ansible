FROM python:3.7-slim-stretch

ARG DEBIAN_FRONTEND=noninteractive

ENV PYTHONUNBUFFERED=on

RUN apt update && \
    apt install -y --no-install-recommends git-core && \
    apt autoclean && \
    rm -rf /var/lib/apt/lists/* && \
    pip install --no-cache-dir cryptography==2.4.2 ansible && \
    mkdir /etc/ansible && \
    bash -c 'echo "ansible_python_interpreter=/usr/bin/env python3" > /etc/ansible/ansible.cfg'

# NOTES:
# - install cryptography explicitly due to paramiko/paramiko/pull/1379 not being merged yet
# - configure ansible_python_interpreter due to ansible/ansible/issues/43286 and 37941

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
