#!/bin/bash

cat > /ansible/host_vars/$IIS_SERVER.yml <<EOF
ansible_host: "{{ lookup('env','IIS_SERVER') }}"
ansible_winrm_scheme: http
ansible_port: 5985
ansible_connection: winrm
ansible_user: "{{ lookup('community.hashi_vault.hashi_vault', 'secret=iis/{{ ansible_host }}:username token=s.O6kDO74PBM4eiEm6TClmf9gX url=http://10.10.15.57:8200') }}"
ansible_password: "{{ lookup('community.hashi_vault.hashi_vault', 'secret=iis/{{ ansible_host }}:password token=s.O6kDO74PBM4eiEm6TClmf9gX url=http://10.10.15.57:8200') }}"
ansible_winrm_transport: ntlm
EOF

echo $IIS_SERVER >> /ansible/hosts

export SRC_APP_PATH="$SRC_PATH\\$CI_PROJECT_NAME"
