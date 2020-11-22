# Local Kubernetes Cluster Ansible Playbook

## To Do

- [ ] Label storage nodes `role=fileserver` or `role=dbserver`
- [ ] Configure Email Reports / Alerts?
- [ ] Ensure that blocked domains do not resolve.
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

## Steps to Reproduce

1. Install Ubuntu Server for Raspberry Pi (64-bit).
2. SSH in and change password.
3. Change hostname by running `sudo hostnamectl set-hostname <hostname>`.
4. Update all packages.
5. Install Ansible.
6. Git clone this repository.
7. Run `ansible-playbook`, targeting the hosts.

Run locally with:

```bash
sudo ansible-playbook --connection=local --inventory=127.0.0.1, --limit=127.0.0.1 ./playbook.yml
```

## Steps to Format Thumb Drives as XFS and Install GlusterFS

1. `lsblk` to find the device.
2. `sudo parted <device>`.
3. `rm 1` to remove the first and only partition.
4. `unit s` to set the units to sectors.
5. `mkpart primary xfs 2048s 100%`.
6. `print` to double-check your configuration.
7. `quit` to quit `parted`.
8. `sudo mkfs.xfs <device>1` to format the first and only partition as XFS.
9. `sudo mkdir -p /data/<device base name>1/gv0` (such as `/data/sda1`) to create a folder for Gluster FS to mount.
10. `echo '/dev/<device base name>1 /data/<device base name>1 xfs defaults 1 2' | sudo tee -a /etc/fstab`
11. `sudo mount -a`
12. `sudo mount`
13. `sudo gluster volume create <arbitrary volume name> <hostname>:/data/<device base name>1`

## Configure Heketi

It does not seem to be stated explicitly in the documentation, but Heketi is
apparently required for GlusterFS dynamic volume provisioning.

1. Download the binary:

```bash
curl -s https://api.github.com/repos/heketi/heketi/releases/latest \
  | grep browser_download_url \
  | grep linux.arm64 \
  | cut -d '"' -f 4 \
  | wget -qi -
```

2. Extract the binary

```bash
for i in `ls | grep heketi | grep .tar.gz`; do tar xvf $i; done`
```

sudo cp heketi/{heketi,heketi-cli} /usr/local/bin

`sudo mkdir -p /var/lib/heketi`
`sudo mkdir -p /etc/heketi`
`sudo mkdir -p /var/log/heketi`
`sudo cp heketi/heketi.json /etc/heketi`
`sudo groupadd --system heketi`
`sudo useradd -s /sbin/nologin --system -g heketi heketi`
`sudo ssh-keygen -f /etc/heketi/heketi_key -t rsa -N ''`
`sudo chown heketi:heketi /etc/heketi/heketi_key*`
sudo cp /etc/heketi/heketi_key.pub /home/heketi/.ssh/authorized_keys
sudo chown -R heketi:heketi /home/heketi
sudo chmod 700 /home/heketi
sudo chmod 700 /home/heketi/.ssh
sudo chmod 600 /home/heketi/.ssh/authorized_keys
`sudo chown -R heketi:heketi /var/lib/heketi /var/log/heketi /etc/heketi`

sudo wipefs -a /dev/sda
sudo wipefs -a /dev/sdb

sudo systemctl daemon-reload
sudo systemctl enable --now heketi

ssh-copy-id -i /etc/heketi/heketi_key.pub heketi@k8s-file1.home

```bash
PASSWORD=$(openssl rand 12 | base64) bash -c 'echo -e "$PASSWORD\n$PASSWORD"' | sudo passwd heketi
```

export HEKETI_CLI_SERVER=http://k8s-file1.home:8080
export HEKETI_CLI_USER=admin
export HEKETI_CLI_KEY="mAqo1A4R4qlEXgMY"

heketi-cli cluster list (To get the cluster ID)