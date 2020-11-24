# Local Kubernetes Cluster Ansible Playbook

## To Do

- [ ] Configure Email Reports / Alerts?
- [x] Ensure that blocked domains do not resolve.
- [ ] Test re-running Ansible after adding data to USB drives to ensure it persists.
- [x] Deploy [Docker Image Registry](https://docs.docker.com/registry/deploying/)
- [x] Deploy [Gitea](https://docs.gitea.io/en-us/install-with-docker/)
- [ ] Deploy Concourse or Jenkins X
- [ ] Deploy [Verdaccio](https://verdaccio.org/docs/en/installation) **Blocked on Docker Image being only AMD64**
- [ ] Deploy A Rust Crate Repo? (I can't seem to find one.)
- [ ] Deploy MongoDB
- [x] Deploy RabbitMQ
- [ ] Deploy [WikiJS](https://docs.requarks.io/install/docker)
- [ ] Deploy [Apache Superset](https://superset.apache.org/docs/installation/installing-superset-using-docker-compose)
- [ ] Add `download` tag
- [ ] Taint the master node

See: https://github.com/trimstray/linux-hardening-checklist
https://viktorvan.github.io/kubernetes/kubernetes-on-raspberry-pi/

https://www.chrisjhart.com/Windows-10-ssh-copy-id/:
type $env:USERPROFILE\.ssh\id_rsa.pub | ssh {IP-ADDRESS-OR-FQDN} "cat >> .ssh/authorized_keys"

## Steps to Reproduce

1. Install Ubuntu Server for Raspberry Pi (64-bit).
2. SSH in and change password.
3. Change hostname by running `sudo hostnamectl set-hostname <hostname>`.
4. Update all packages.
5. Install Ansible.
6. Git clone this repository.
7. Run `ansible-playbook`, only targeting the databases, so that storage can get set up.
8. Run `ansible-playbook`, targeting the hosts.

Run locally with:

```bash
sudo ansible-playbook --connection=local --inventory=127.0.0.1, --limit=127.0.0.1 ./playbook.yml
```

## Notes

`configuration/topology.json` MUST take IP addresses for this to work with
Kubernetes. I don't know why.