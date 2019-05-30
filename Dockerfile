FROM python:3.7-slim-stretch

ARG DEBIAN_FRONTEND=noninteractive

ENV PYTHONUNBUFFERED=on

RUN apt update && \
    apt install -y --no-install-recommends git-core openssh-client && \
    apt autoclean && \
    rm -rf /var/lib/apt/lists/* && \
    pip install --no-cache-dir cryptography==2.4.2 ansible

ADD ansible.cfg /etc/ansible/

# NOTES:
# - install cryptography explicitly due to paramiko/paramiko/pull/1379 not being merged yet

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
