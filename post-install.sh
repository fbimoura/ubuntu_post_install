#!/bin/bash

# Variáveis
USER_NAME="ansible"
SSH_DIR="/home/$USER_NAME/.ssh"
KEY_NAME="$HOME/.ssh/ansible_automation"
ANSIBLE_CFG="$HOME/.ansible.cfg"

# Criação do usuário
if ! id "$USER_NAME" &>/dev/null; then
  echo "[+] Criando usuário $USER_NAME..."
  sudo useradd -m -s /usr/sbin/nologin -c "Usuário para automações Ansible" "$USER_NAME"
else
  echo "[*] Usuário $USER_NAME já existe."
fi

# Adiciona ao grupo sudo (opcional)
sudo usermod -aG sudo "$USER_NAME"

# Criação de chave SSH local
if [ ! -f "${KEY_NAME}" ]; then
  echo "[+] Gerando chave SSH local em ${KEY_NAME}..."
  ssh-keygen -t ed25519 -N "" -f "${KEY_NAME}"
else
  echo "[*] Chave SSH já existe em ${KEY_NAME}."
fi

# Copia a chave pública para o servidor (localhost ou remoto)
echo "[+] Configurando chave pública no servidor..."
sudo mkdir -p "$SSH_DIR"
sudo cp "${KEY_NAME}.pub" "$SSH_DIR/authorized_keys"
sudo chown -R "$USER_NAME:$USER_NAME" "$SSH_DIR"
sudo chmod 700 "$SSH_DIR"
sudo chmod 600 "$SSH_DIR/authorized_keys"

# Permite sudo sem senha (opcional)
echo "[+] Permitindo sudo sem senha para o usuário $USER_NAME..."
echo "$USER_NAME ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/ansible > /dev/null
sudo chmod 0440 /etc/sudoers.d/ansible

# Instala o Ansible
echo "[+] Instalando Ansible via APT..."
sudo apt update
sudo apt install -y software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install -y ansible

# Configura o usuário padrão no Ansible
echo "[+] Definindo o usuário padrão do Ansible como 'ansible' em ~/.ansible.cfg..."
cat > "$ANSIBLE_CFG" <<EOF
[defaults]
remote_user = ansible
private_key_file = ${KEY_NAME}
host_key_checking = False
inventory = ./hosts
roles_path = $HOME/Documentos/Ansible/roles
EOF

# Criação do arquivo de inventário com localhost
echo "[+] Criando arquivo de inventário padrão com localhost..."
cat > "${INVENTORY_PATH}" <<EOF
[local]
localhost ansible_connection=local
EOF

echo "[✓] Usuário $USER_NAME configurado com sucesso."
echo ""
ansible-playbook config-ubuntu.yaml
