cat <<EOT >> /etc/network/interfaces
auto enp0s8
iface enp0s8 inet static
  address 192.168.56.101
  netmask 255.255.255.0
  network 192.168.56.0
  broadcast 192.168.56.255
EOT
