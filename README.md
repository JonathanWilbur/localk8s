# Local Kubernetes Cluster Ansible Playbook

## To Do

- [x] Install and configure mDNS
- [x] Install and configure SSH
  - [x] Install
  - [x] Prohibit SSH Password Authentication
  - [x] Copy SSH Key?
  - [ ] Create GPG Key
- [x] MicroK8s
- [x] DNSCrypt
- [x] ~~Automate encrypted backups~~ (No need for this until I see what my needs are.)
- [x] ~~Configure GPG~~ (No Ansible Modules for this!)
- [x] NordVPN
- [x] ~~Xi Editor~~ (Difficult to install.)
- [x] Storage
- [x] Turn off telemetry
- [x] ~~Ensure SELinux is enforcing~~ (Not applicable.)
- [x] Configure NTP
- [x] Configure Ubuntu Repository
- [x] Enable ExecShield?
- [x] Enable ASLR
- [x] Configure a telemetry hosts blacklists
- [x] Periodically delete command history
- [ ] Disable swap?
- [x] Configure TimeZone
- [x] Ensure that dnsmasq is NOT installed (It will interfere with DNSCrypt)
- [x] ~~Install the Azure CLI~~ (Not needed until I start making encrypted backups.)
- [x] Periodic secure deletion
- [ ] Configure Email Reports / Alerts?
- [x] Install Hexyl
- [x] Install mdadm
- [x] Configure Ethernet Jumbo Frames
- [x] ~~Large Pages~~ (Not necessary, because Kubernetes can configure this on a container-basis.)
- [x] Set auto-logout
- [ ] Ensure that blocked domains do not resolve.
- [x] Configure NFS Shares
- [x] Configure `kubectl` on the laptop.
- [ ] Test re-running Ansible after adding data to USB drives to ensure it persists.
- [ ] Deploy [Docker Image Registry](https://docs.docker.com/registry/deploying/)
- [ ] Deploy [Gitea](https://docs.gitea.io/en-us/install-with-docker/)
- [ ] Deploy Concourse or Jenkins X
- [ ] Deploy [Verdaccio](https://verdaccio.org/docs/en/installation)
- [ ] Deploy A Rust Crate Repo? (I can't seem to find one.)
- [ ] Deploy MongoDB
- [ ] Deploy RabbitMQ
- [ ] Deploy MariaDB?
- [ ] Deploy [WikiJS](https://docs.requarks.io/install/docker)
- [ ] Deploy [Apache Superset](https://superset.apache.org/docs/installation/installing-superset-using-docker-compose)

See: https://github.com/trimstray/linux-hardening-checklist
https://viktorvan.github.io/kubernetes/kubernetes-on-raspberry-pi/

https://www.chrisjhart.com/Windows-10-ssh-copy-id/:
type $env:USERPROFILE\.ssh\id_rsa.pub | ssh {IP-ADDRESS-OR-FQDN} "cat >> .ssh/authorized_keys"

Steps to reproduce:

1. Install Ubuntu Server for Raspberry Pi (64-bit).
2. SSH in and change password.
3. Change hostname by running `sudo hostnamectl set-hostname <hostname>`.
4. Update all packages.
5. Install Ansible.
6. Git clone this repository.
7. Run `ansible-playbook`, targeting the hosts.

Run locally with:
sudo ansible-playbook --connection=local --inventory=127.0.0.1, --limit=127.0.0.1 ./playbook.yml