# GiST_SQL

## 1. Objetivo

Este repositório contém os artefatos e a análise de um estudo prático sobre a otimização de consultas geoespaciais em PostgreSQL utilizando a extensão PostGIS e índices GiST. O objetivo é demonstrar de forma clara e reproduzível o impacto drástico na performance ao aplicar a estrutura de indexação correta em um grande volume de dados de coordenadas.

Este trabalho foi desenvolvido para a disciplina de Programação e Administração de Banco de Dados, por Jeferson Queiroga Pereira.

## 2. Tecnologias Utilizadas

* **Banco de Dados:** PostgreSQL
* **Extensão:** PostGIS
* **Linguagem:** SQL

## 3. Estrutura do Repositório

* `01_schema.sql`: Script para criar a tabela `entregadores` e habilitar a extensão PostGIS.
* `02_data_generation.sql`: Script para popular a tabela com 5 milhões de coordenadas geográficas aleatórias no Brasil.
* `03_demonstration.sql`: Script contendo as consultas `EXPLAIN ANALYZE` para demonstrar a performance antes e depois da criação do índice.

## 4. Passo a Passo para Reprodução

### Pré-requisitos
Certifique-se de ter o PostgreSQL com a extensão PostGIS instalada em seu ambiente.

### Passo 1: Preparação do Banco de Dados
Conecte-se ao seu servidor PostgreSQL e crie um novo banco de dados. Em seguida, execute o conteúdo do arquivo `01_schema.sql` para habilitar o PostGIS e criar a tabela `entregadores`.

### Passo 2: Geração da Massa de Dados
Execute o script `02_data_generation.sql`.

### Passo 3: Demonstração e Análise
Execute o script `03_demonstration.sql` para testemunhar a diferença de performance. O script contém as consultas de análise e o comando de criação do índice.

## 5. Análise dos Resultados

A eficácia do índice GiST é comprovada pela comparação direta dos planos de execução.

### Antes do Índice: Força Bruta (`Seq Scan`)

A primeira consulta força o PostgreSQL a varrer a tabela inteira.

**Plano de Execução:**
```
Parallel Seq Scan on entregadores
Execution Time: 442.285 ms
```

O sistema inspecionou **5 milhões de linhas**, uma operação de força bruta que não escala com o aumento dos dados.

### Depois do Índice: Precisão Cirúrgica (`Bitmap Index Scan`)

Após criar o índice GiST, o planejador de consultas adota uma estratégia imensamente mais eficiente.

**Comando de Criação:**
```sql
CREATE INDEX idx_entregadores_localizacao_gist ON entregadores USING GIST (localizacao);
```

**Plano de Execução:**
```
Bitmap Heap Scan on entregadores
  ->  Bitmap Index Scan on idx_entregadores_localizacao_gist
Execution Time: 7.053 ms
```
O `Bitmap Index Scan` utilizou a estrutura do índice para identificar os registros relevantes em uma fração de milissegundo, e o `Bitmap Heap Scan` visitou apenas esses registros na tabela.

### Conclusão Quantitativa

* **Tempo sem índice:** ~442 ms
* **Tempo com índice:** ~7 ms
* **Ganho de Performance:** A consulta tornou-se aproximadamente **63 vezes mais rápida**.

## 6. Conclusão Final

A escolha da estrutura de indexação correta não é uma otimização trivial, mas um pilar do design de sistemas de software robustos e escaláveis. Para dados geoespaciais, o índice GiST atua para garantir que as operações de proximidade permaneçam performáticas à medida que a base de dados cresce.

---
**Autores:**
* Antônio Marcos Fernandes Queiroz
* Ézio de Araújo Alves
* Joel de Farias Mendonça Junior
