# Arquitetura Kubernetes

**DevOps — Turma 5**  
**Integrantes:** André Chagas Assis Costa e Pedro Delmiro

## Sobre a atividade

Nesta atividade montamos um desenho da arquitetura do Kubernetes no Draw.io e criamos dois arquivos YAML para colocar uma aplicação no ar: um Pod e um Service. Fizemos os testes usando Minikube e uma imagem nossa que já estava publicada no Docker Hub.

## Principais componentes

- **Cluster:** ambiente onde o Kubernetes gerencia os recursos e as aplicações.
- **Control Plane:** parte responsável por controlar e organizar o cluster.
- **API Server:** recebe os comandos enviados pelo `kubectl`.
- **Scheduler:** escolhe em qual Node um Pod vai executar.
- **Controller Manager:** acompanha os recursos e ajuda a manter o estado desejado.
- **etcd:** armazena os dados de configuração e o estado do cluster.
- **Worker Node:** máquina onde os Pods são executados.
- **kubelet:** verifica e acompanha a execução dos Pods no Node.
- **kube-proxy:** participa do encaminhamento do tráfego de rede dos Services.
- **Pod:** menor unidade de execução do Kubernetes; pode conter um ou mais containers.
- **Service:** fornece uma forma estável de acessar os Pods.
- **ReplicaSet:** mantém a quantidade desejada de réplicas de Pods.
- **Deployment:** gerencia atualizações e réplicas de uma aplicação, geralmente por meio de ReplicaSets.
- **kubectl:** ferramenta de linha de comando para interagir com o Kubernetes.
- **Minikube:** permite executar um cluster Kubernetes local para estudos e testes.

O desenho em `kubernetes.drawio` mostra como esses componentes se relacionam. O **ReplicaSet e o Deployment aparecem como parte da arquitetura estudada**, mas, na prática, criamos apenas um Pod e um Service.

## Arquivos do projeto

```text
arquitetura_kubernetes/
├── kubernetes.drawio
├── pod.yml
├── service.yml
└── README.md
```

- `kubernetes.drawio`: desenho da arquitetura Kubernetes.
- `pod.yml`: cria o Pod `meu-site-pod` com a imagem `ded3v/meu-site-apache:1.0`.
- `service.yml`: cria o Service `meu-site-service`, do tipo `NodePort`, usando a porta `30080`.

A imagem utilizada está no [nosso Docker Hub](https://hub.docker.com/r/ded3v/meu-site-apache).

## Como executamos

Com o Docker Desktop aberto, iniciamos o cluster:

```bash
minikube start --driver=docker
kubectl get nodes
```

Depois, dentro da pasta do projeto, criamos os recursos:

```bash
kubectl apply -f pod.yml
kubectl apply -f service.yml
kubectl get pods,services
```

Por fim, abrimos a aplicação no navegador:

```bash
minikube service meu-site-service
```

## Resultado

Nos testes, o Node ficou com status `Ready`, o Pod `meu-site-pod` ficou `Running` e o Service foi criado. Conseguimos abrir a página da aplicação Apache no navegador pelo endereço fornecido pelo Minikube.

Com a atividade, entendemos melhor a diferença entre Pod e Service e como o Kubernetes usa esses recursos para executar e disponibilizar uma aplicação.
