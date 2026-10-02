# Instalação e Teste do Vagrant

## 1. Instalação

Para utilizar o Vagrant, é necessário instalar:

* **Oracle VirtualBox** — responsável por criar e executar a máquina virtual
* **Vagrant** — responsável por automatizar a criação e configuração da VM

Após a instalação, é possível verificar o Vagrant com:

```bash
vagrant --version
```

---

## 2. Criando o projeto

Foi criada uma pasta para o projeto e, dentro dela, executado:

```bash
vagrant init ubuntu/jammy64
```

Esse comando cria automaticamente o arquivo:

```text
Vagrantfile
```

O `Vagrantfile` contém as configurações da máquina virtual.

---

## 3. Configuração do Vagrantfile

Foi configurada uma máquina Ubuntu utilizando o VirtualBox:

```ruby
Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/jammy64"

  config.vm.network "forwarded_port", guest: 80, host: 8080

  config.vm.provision "shell", path: "provision.sh"

end
```

A porta `8080` do computador foi direcionada para a porta `80` da máquina virtual, utilizada pelo Apache.

---

## 4. Provisionamento

Também foi criado o arquivo:

```text
provision.sh
```

Com o seguinte conteúdo:

```bash
#!/bin/bash

apt-get update
apt-get install -y apache2

systemctl enable apache2
systemctl start apache2
```

Esse script:

* Atualiza a lista de pacotes
* Instala o Apache
* Configura o Apache para iniciar automaticamente
* Inicia o serviço Apache

O Vagrant executa esse script automaticamente durante o provisionamento da máquina.

---

## 5. Iniciando a máquina virtual

Para criar e iniciar a VM:

```bash
vagrant up
```

O Vagrant utiliza o VirtualBox como provedor e cria a máquina automaticamente.

Para verificar o estado:

```bash
vagrant status
```

Para acessar a máquina:

```bash
vagrant ssh
```

---

## 6. Testando o Apache

Com a máquina ligada, o servidor foi acessado pelo navegador através do endereço:

```text
http://localhost:8080
```

Isso funciona porque o Vagrant encaminha:

```text
localhost:8080
       ↓
porta 80 da VM
       ↓
Apache
```

Também é possível verificar o serviço dentro da VM:

```bash
systemctl status apache2
```

---

## 7. Comandos básicos utilizados

```bash
vagrant up
```

Cria ou inicia a máquina virtual.

```bash
vagrant status
```

Mostra o estado da VM.

```bash
vagrant ssh
```

Acessa o terminal da máquina virtual.

```bash
vagrant halt
```

Desliga a VM.

```bash
vagrant provision
```

Executa novamente o provisionamento.

```bash
vagrant destroy
```

Remove a máquina virtual criada pelo Vagrant.
