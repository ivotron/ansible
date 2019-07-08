FROM python:3.7-slim-stretch

ARG DEBIAN_FRONTEND=noninteractive
ARG ANSIBLE_VERSION=2.6

ENV PYTHONUNBUFFERED=on

RUN apt update && \
    apt install -y --no-install-recommends \
      git-core openssh-client && \
    rm -rf /var/lib/apt/lists/* && \
    pip install --no-cache-dir \
      cryptography==2.4.2 netaddr ansible=="$ANSIBLE_VERSION" mazer

ADD ansible.cfg /etc/ansible/

# NOTES:
# - install cryptography explicitly due to paramiko/paramiko/pull/1379 not being merged yet

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
