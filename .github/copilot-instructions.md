# Ansible Homelab Setup

This repo manages a personal homelab using Ansible. Hosts are a mix of Proxmox LXC containers, VMs, and bare-metal running Debian or RHEL-family systems.

## Running Playbooks

```bash
# Standard run (vault password auto-loaded via configfile/.ansible.cfg)
ansible-playbook -i inventory.ini playbooks/<playbook>.yml

# Playbooks requiring a target host at runtime
ansible-playbook -i inventory.ini playbooks/upgrade_debian_12-13.yml -e 'target=<hostname_or_group>'
ansible-playbook -i inventory.ini playbooks/deploy_newserver.yml -e 'target_host=<IP_ADDRESS>'
```

## Inventory Groups

- `speical` – Proxmox host and Semaphore server (dangerous: can reboot the hypervisor)
- `vm` – VMs (Minecraft servers, etc.)
- `container` – LXC containers (Docker, Nextcloud, webservers, services, etc.)

## Secrets & Vault

- Secrets live in `passwords/secrets.yml` (ansible-vault AES256 encrypted)
- Vault password file: `passwords/pass.txt` — referenced automatically by `configfile/.ansible.cfg`
- Playbooks pull in secrets via `vars_files: - /root/ansible-setup/passwords/secrets.yml`
- Key vars from vault: `full_gotify_token_ansible` (full URL with token), `full_sema_token_ansible`
- `passwords/test_inv.ini` is a secondary inventory used for testing against a subset of hosts

## Semaphore Variants (`_sema` suffix)

Playbooks ending in `_sema` (e.g., `update_all_sema.yml`, `ping_sema.yml`) are designed to run from the Semaphore UI. They omit `vars_files` vault references and instead rely on Semaphore's own secret/variable injection.

## Notifications

Gotify is used for push notifications. Playbooks post to `{{ full_gotify_token_ansible }}` (a full URL including the token) via the `uri` module with `run_once: true` to avoid duplicate messages.

## Multi-distro Pattern

Update playbooks support both Debian and RHEL hosts in the same play using `when: ansible_facts['os_family']` guards:

```yaml
- name: Update (APT)
  apt: ...
  when: ansible_facts['os_family'] == "Debian"

- name: Update (DNF)
  dnf: ...
  when: ansible_facts['os_family'] == "RedHat"
```

## Gather / Logging

`playbooks/gather.yml` collects host facts (hostname, kernel, distro, disk usage, IP) and writes them to `logfile.json` at the repo root. This file is the inventory of current host state.

## Scripts

- `scripts/sharesshkey.sh` – copies SSH keys to all IPs found in `inventory.ini` (run from repo root)
- `scripts/send_telegram.sh <message>` – sends a Telegram message; requires `telegram_token.txt` and `chat_id.txt` alongside the script
- `scripts/update-inv.sh` – updates the inventory file
