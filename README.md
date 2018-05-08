# archlinux-install
script Archlinux installation in Bash and Ansible, designing for making VM or PXE environments

## Intro to Docker

`docker run --network=host -v <host/folder>:<container/folder> plex` host network so all ports are forwarded

`docker exec -i plex /bin/bash` to get a shell in the container

`docker ps` see running containers, -a for stopped as well

`docker images` local container images

## Intro virsh

`virsh capabilities` make sure the host can even do the compute

`virsh net-list|pool-list` networks and storage pools

`virsh list` running domains, --all for stopped domains

`virsh destroy <name>` stops a domain

`virsh undefine <name>` actually deletes the domain, then delete the disk

`virsh console <name>` tries to connect to domain's console

`virsh ttyconsole <name>` just prints the tty the domain is on, may be able to switch to that on the local monitor?
