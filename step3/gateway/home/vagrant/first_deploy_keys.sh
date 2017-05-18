#! /bin/bash
user="vagrant"
ssh_dir="$HOME/.ssh"
keys_dir="$HOME/.ssh/keys"
dt=$(date '+%Y%m%d_%H%M')

mkdir -p $keys_dir
ssh-keygen -t rsa -N '' -f ${keys_dir}/key_${dt} -q
key=$(ln -s -f ${keys_dir}/key_${dt} ${ssh_dir}/id_rsa)
pub_key=$(ln -s -f ${keys_dir}/key_${dt}.pub ${ssh_dir}/id_rsa.pub)

ips="$(grep -E -o "(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)" /var/lib/dhcp/dhcpd.leases)"
no_dub_ips=$(echo $ips | tr ' ' '\n' | sort -nu)
nodes=($no_dub_ips)
for host in "${nodes[@]}"; do
  ssh-copy-id $user@$host
  echo "Public key was pushed to $host"
done
