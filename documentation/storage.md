# Storage

I will not be using FDE, because somebody with physical access to my home could
just steal the entire Kubernetes cluster.

I will not be using RAID for right now, because I will not be storing very much
and I have little need for extreme availability.

I will not be using LVM for right now because I only have 512 GB, but I may be
interested in this in the future when I have more storage. I don't really think
LVM snapshots are going to fulfill my needs. I think simply unmounting drives
and using `dd` to pipe the raw contents to `gzip`, then encrypting with `gpg`,
then uploading to the cloud will be fine.
