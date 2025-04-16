# 🚀 Ambiente Dev Automático com Ansible (Ubuntu 22.04)

Este projeto automatiza a configuração de um ambiente de desenvolvimento completo usando Ansible no Ubuntu 22.04. Ele inclui:

- Virtualização com KVM
- Containerização com Podman
- Kubernetes local com Minikube
- Shell Zsh com Oh My Zsh
- Pós-instalação com otimizações

---

## 📦 Roles incluídas

| Role             | Descrição                                                                 |
|------------------|---------------------------------------------------------------------------|
| `post_install`   | Ações pós-instalação: atualizações, timezone, repositórios e utilitários. |
| `kvm_setup`      | Instala e configura o KVM, libvirt e virt-manager.                        |
| `podman_setup`   | Instala Podman, cockpit-podman e configura o serviço na porta 9095.       |
| `minikube_setup` | Instala Minikube, Helm, kubectl, configura driver Podman e cria serviço. |
| `zsh_setup`      | Instala Zsh, Oh My Zsh, plugins e autocompletes para ferramentas K8s.     |

---

## 🖥️ Pré-requisitos

- Ubuntu 22.04 com acesso root
- Conexão com a Internet
- Permissões para executar `sudo`

---

## ⚙️ Inicialização do ambiente

### 1. Torne o script `post-install.sh` executável

```bash
chmod +x post-install.sh
sh post-install.sh
```
Esse script realiza:

- Criação do usuário ansible
- Geração da chave SSH
- Configuração de sudo sem senha
- Instalação do Ansible via PPA
- Criação de ~/.ansible.cfg
- Geração do inventário local (hosts)
- Execução automática do playbook config-ubuntu.yaml

---

## 📁 Estrutura esperada do projeto
```text 
  .
  ├── post-install.sh
  ├── config-ubuntu.yaml \
  ├── hosts
  ├── roles/
  │ ├── post_install/
  │ ├── kvm_setup/
  │ ├── podman_setup/
  │ ├── minikube_setup/
  │ └── zsh_setup/
  └── README.md
```

---

## 🧾 Inventário (hosts)
```ini
[local]
localhost ansible_connection=local
