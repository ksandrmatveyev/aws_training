#! /bin/bash
user="vagrant"
ssh_dir="$HOME/.ssh"
keys_dir="$HOME/.ssh/keys"
dt=$(date '+%Y%m%d_%H%M')
real_key="${keys_dir}/key_${dt}"
real_pub_key="${real_key}.pub"
key_link="${ssh_dir}/id_rsa"

# get all IPs from dhcp leases
ips="$(grep -E -o "(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)" /var/lib/dhcp/dhcpd.leases)"
no_dub_ips=$(echo $ips | tr ' ' '\n' | sort -nu)
nodes=($no_dub_ips)

any_conns="$(lsof -i | grep -o ":ssh (ESTABLISHED)")"
if  [[ -z $any_conns ]]; then
  # create key pairs on client
  mkdir -p $keys_dir
  ssh-keygen -t rsa -N '' -f $real_key -q
  # deploy public key
  for host in "${nodes[@]}"; do
    cat ${real_pub_key} | ssh $user@$host "mkdir -p ~/.ssh && cat >  ~/.ssh/authorized_keys"
    echo "Public key was pushed to $host"
  done
  #update sylinks
  ln -s -f ${real_key} ${key_link}
  ln -s -f ${real_pub_key} ${key_link}.pub
else
  echo "Some outcoming ssh connections are established"
fi
