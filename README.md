📘 README.md – Automação de Ambiente Dev com Ansible
🔧 Visão Geral
Este repositório contém um conjunto de roles Ansible que automatizam a instalação e configuração de um ambiente completo para desenvolvimento com:

Virtualização (KVM)

Containers (Podman)

Kubernetes local (Minikube)

Terminal aprimorado (Zsh + Oh My Zsh)

Pós-instalação e personalização do Ubuntu

📦 Roles incluídas

Role	Descrição
post_install	Ações pós-instalação do Ubuntu 22.04 (atualizações, timezone, utilitários).
kvm_setup	Instala e configura o KVM, libvirt e virt-manager.
podman_setup	Instala Podman, cockpit-podman e configura porta customizada.
minikube_setup	Instala Minikube, kubectl, Helm, configura driver Podman e cria serviço systemd.
zsh_setup	Instala Zsh, Oh My Zsh, plugins, tema e autocompletes para ferramentas Kubernetes.
📋 Pré-requisitos
Ubuntu 22.04 instalado

Execução local com permissões de sudo

Conectividade com a Internet

🚀 Inicialização
Execute o script post-install.sh para:

Criar o usuário ansible com acesso via chave SSH

Conceder sudo sem senha

Instalar o Ansible via PPA oficial

Criar inventário local com localhost

Gerar ~/.ansible.cfg com caminho customizado das roles

Executar automaticamente o playbook principal config-ubuntu.yaml

bash
Copiar
Editar
chmod +x post-install.sh
./post-install.sh
O post-install.sh executa ao final o comando:

bash
Copiar
Editar
ansible-playbook config-ubuntu.yaml
🧪 Inventário gerado (./hosts)
ini
Copiar
Editar
[local]
localhost ansible_connection=local
📄 Exemplo de playbook (config-ubuntu.yaml)
yaml
Copiar
Editar
- hosts: local
  become: true
  roles:
    - post_install
    - kvm_setup
    - podman_setup
    - minikube_setup
    - zsh_setup
🧠 Recursos configurados
Cockpit escutando na porta 9095

Minikube utilizando Podman como driver, com serviço systemd

Zsh como shell padrão com:

Oh My Zsh (tema agnoster)

Plugins: zsh-autosuggestions, zsh-syntax-highlighting

Autocompletes: kubectl, minikube, helm

📂 Estrutura esperada
arduino
Copiar
Editar
.
├── post-install.sh
├── config-ubuntu.yaml
├── hosts
├── roles/
│   ├── post_install/
│   ├── kvm_setup/
│   ├── podman_setup/
│   ├── minikube_setup/
│   └── zsh_setup/
└── README.md
