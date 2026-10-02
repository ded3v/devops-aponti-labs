# Vagrant · Apache em Ubuntu

VM Ubuntu 22.04 provisionada com Shell para instalar e iniciar o Apache. Usa VirtualBox, 1 GB de RAM e uma CPU.

## Executar

Requisitos: Vagrant, VirtualBox e virtualização habilitada.

```bash
cd vagrant/apache
vagrant up
vagrant status
```

Acesse [http://localhost:8080](http://localhost:8080), onde a porta 80 da VM é encaminhada. O script instala o Apache; não cria uma página personalizada.

```bash
vagrant ssh
vagrant halt
```

Execute `vagrant up` para ligar novamente. `vagrant destroy` remove a VM do laboratório.

## O que foi praticado

Box, recursos de VM, encaminhamento de porta e provisionamento. Veja também [a documentação anterior](README-original.md).

## Origem

Importado de [ded3v/Vagrant_Test](https://github.com/ded3v/Vagrant_Test).
