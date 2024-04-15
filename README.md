# Sum Calculator | Intensivão Devops

## Overview

Este projeto é dedicado ao aprendizado de práticas de DevOps. Consiste em um app simples em React + Python da soma de dois números, usado como base para a construção de uma infra na Azure.

## Features

- Calculadora com adição
- Teste de integração com Newman
- Infra para deploy em VM
- Pipelines de CI
- Pipeline de CD
- Pipeline de testes de carga

# Máquinas Virtuais

Para a implantação da aplicação na máquina virtual, há alguns arquivos de referência na pasta `vm-infra`.

# Pipelines

## Integração Contínua (CI)

### PR Pipeline

[Arquivo](.github/workflows/pr-pipeline.yml)

A pipeline possui três etapas principais:

- **semgrep**: Essa etapa utiliza a ferramenta semgrep para análise estática do código, verificando a qualidade e possíveis problemas de segurança.

- **backend**: Nessa etapa, o código do backend é testado. Ela configura o ambiente necessário, instala as dependências e, em seguida, executa os testes usando o Newman em uma coleção do Postman.

- **frontend**: Essa etapa configura o ambiente, instala as dependências e executa testes e linting no código do frontend.

As etapas rodam em paralelo, para agilidade do processo.

### Build Artifacts

[Arquivo](.github/workflows/build-pipeline.yml)

Essa pipeline é projetada para construir e implantar artefatos da a aplicação, incluindo o backend e o frontend, quando houver push para a branch principal (main).

Suas etapas são:

- **build-backend**: Esta etapa é responsável pela construção e teste do backend da aplicação. Ela configura o ambiente, instala as dependências necessárias, executa os testes usando Newman, gera uma versão semântica para o backend com base no número de execução do GitHub, realiza login no Docker Hub usando credenciais armazenadas nos segredos do GitHub, constrói e envia a imagem Docker do backend para o Azure Container Registry (ACR), além de arquivar o número de execução em um arquivo para referência futura.

- **build-frontend**: Essa etapa configura o ambiente, instala as dependências do frontend, executa os testes do frontend, gera uma versão semântica para o frontend com base no número de execução do GitHub, constrói o frontend e carrega o artefato resultante (os arquivos de build) para o GitHub Packages.

## Deploy Contínuo (CD)

### Deploy Backend and Frontend

[Arquivo](.github/workflows/release-pipeline.yml)

Esta é uma pipeline de implantação (deploy) para o backend e frontend da sua aplicação, ativada após a conclusão bem-sucedida da pipeline de buiild de artefatos.

- **get_artifacts**: Esta etapa faz o download dos artefatos gerados pela pipeline de construção de artefatos. Ela baixa o número de execução (run_number) e os artefatos de construção do frontend, preparando-os para uso nas etapas de implantação subsequentes.

- **deploy-backend**: Esta etapa implanta o backend da aplicação. Ela baixa o número de execução (run_number) para gerar a versão do backend, e então usa o Azure Web App Service para implantar a imagem Docker do backend associada a essa versão.

- **deploy-frontend**: Esta etapa implanta o frontend da aplicação. Ela baixa os artefatos de construção do frontend, em seguida, usa o Azure Static Web Apps para implantar esses artefatos.

- **rollback**: Esta é uma etapa de rollback que é executada caso uma das etapas de implantação falhe. Ela reverte a implantação para a versão anteriormente implantada da aplicação.

Há também uma seção comentada chamada "notify", que poderia ser usada para enviar notificações para um canal do Slack informando sobre o sucesso ou falha da implantação.

Tanto o deploy do frontend quanto do backend ocorrem em paralelo.

Essa pipeline automatiza o processo de implantação do backend e frontend da sua aplicação, garantindo que as versões mais recentes sejam implantadas em produção após uma conclusão bem-sucedida da pipeline de construção. Além disso, inclui um mecanismo de rollback para lidar com falhas de implantação.

## Monitoramento

### Stress Test

[Arquivo](.github/workflows/stress-test-pipeline.yml)

Essa pipeline é responsável por simular o uso de 10 usuários durante 3 minutos. É esperado que pelo menos 95% das requests sejam bem sucedidas.