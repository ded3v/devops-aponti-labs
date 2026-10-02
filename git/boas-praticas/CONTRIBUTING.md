# Como contribuir

## 1. Escolha uma tarefa

Antes de começar, verifique qual seção do README ficou sob sua responsabilidade.

## 2. Atualize a branch main

```bash
git checkout main
git pull origin main
```

## 3. Crie uma branch para sua tarefa

```bash
git checkout -b docs/nome-da-tarefa
```

Exemplos:

```text
docs/introducao-repositorio
docs/issues-branches
docs/pull-requests-code-review
docs/commits-conflitos
```

## 4. Faça suas alterações

Edite somente a seção que ficou sob sua responsabilidade.

## 5. Faça um commit claro

```bash
git add README.md
git commit -m "docs: descreve a alteração realizada"
```

## 6. Envie sua branch

```bash
git push -u origin docs/nome-da-tarefa
```

## 7. Abra um Pull Request

Explique o que foi alterado e solicite a revisão de outro integrante.

## 8. Aguarde o Code Review

O Pull Request deverá ser revisado antes de ser incorporado à branch `main`.
