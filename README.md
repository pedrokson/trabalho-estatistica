# Relatório de Análise Estatística

**Tema**: *\[Comparação Estatística da Taxa de Alfabetização entre as Regiões Sul e Sudeste do Brasil]*  
**Autores**: *\[Pedro Henrique Sutil]*  
**Data**: *\[27/06/2025]*
/

## 1\. Introdução

Este relatório apresenta uma análise estatística da taxa de alfabetização nas regiões Sul e Sudeste do Brasil, com base em dados municipais. O objetivo principal é explorar as características da distribuição da taxa de alfabetização em cada região, comparar as médias, dispersões e identificar diferenças entre os estados que compõem essas regiões.


-----

## 2\. Descrição do Conjunto de Dados

* Fonte dos dados: [A base original veio deste link do IBGE:](https://sidra.ibge.gov.br/pesquisa/censo-demografico/demografico-2022/inicial)
* Fonte dos dados: [E a base tratada veio do link da base dos dados:](https://basedosdados.org/dataset/08a1546e-251f-4546-9fe0-b1e6ab2b203d?table=cf9537b5-6198-455f-a8b0-7c762e94d79c)
* Número de observações (linhas): `5571`
* Número de variáveis (colunas): `13`

### 2.1. O que representam os dados?

Este conjunto de dados contém informações sobre municípios brasileiros e suas taxas de alfabetização. Cada linha representa um município. Os dados foram obtidos a partir do arquivo ibgecd.csv, que provavelmente foi extraído de bases públicas do IBGE ou órgãos oficiais relacionados a estatísticas educacionais.

| Coluna               | Descrição                                                   | Tipo de Dado           | Exemplo            |
|---|---|---|---|
| `sigla_uf`           | Sigla do estado onde o município está localizado            | Categórico             | "SP", "PR", "RS"   |
| `id_municipio`       | Identificador numérico único do município                    | Numérico (inteiro)     | 4106902, 4314902    |
| `taxa_alfabetizacao` | Percentual da população alfabetizada no município           | Numérico (porcentagem) | 95.4, 88.7         |
| `regiao`             | Região geográfica do município (criada na análise, Sul/Sudeste) | Categórico           | "Sul", "Sudeste"   |
|---|---|---|---|


### 2.2. Como os dados foram obtidos?

Os dados foram extraídos de um arquivo em formato Excel (ibgecd.xlsx) contendo informações sobre os municípios brasileiros e suas respectivas taxas de alfabetização, com base em fontes oficiais, como o Instituto Brasileiro de Geografia e Estatística (IBGE). Para a análise, o arquivo foi importado para o software R, onde foram realizadas etapas de pré-processamento, como a criação de uma nova variável categórica denominada "região", que classificou cada município nas regiões Sul ou Sudeste de acordo com a sua sigla de Unidade Federativa (UF). Além disso, foram tratados eventuais valores ausentes na variável "taxa_alfabetizacao", garantindo a correta execução dos cálculos estatísticos.

-----

## 3\. Questões Motivadoras

Nesta análise, buscamos responder às seguintes questões/problemas:

  * **Questão 1:** Qual a média da taxa de alfabetização nas regiões Sul e Sudeste?
  * **Questão 2:** Como se comporta a dispersão dos dados dentro e entre os estados que compõem cada região?
  * **Questão 3:** As diferenças entre Sul e Sudeste são visíveis nos gráficos de boxplot e histogramas?
  

-----

## 4\. Códigos Utilizados

Todos os códigos para esta análise foram desenvolvidos em **R**.

Todos os códigos em R usados na análise estão incluídos abaixo.
Para formatar blocos de código em Markdown no GitHub, use três crases (\`\`\`) seguidas da linguagem (`r` para R):

```r
# Visualizando as primeiras linhas do dataframe
head(dados)

# Filtrando os dados por região
Sul <- dados[dados$regiao == "Sul", ]
Sudeste <- dados[dados$regiao == "Sudeste", ]
```

```r
# ---------- MÉDIA GERAL DA TAXA DE ALFABETIZAÇÃO POR REGIÃO ----------
mean_sudeste <- mean(Sudeste$taxa_alfabetizacao, na.rm = TRUE)
print(paste("Média Geral da Taxa de Alfabetização - Sudeste:", mean_sudeste))

mean_sul <- mean(Sul$taxa_alfabetizacao, na.rm = TRUE)
print(paste("Média Geral da Taxa de Alfabetização - Sul:", mean_sul))

# ---------- MÉDIA DA TAXA DE ALFABETIZAÇÃO POR ESTADO ----------
mediasudeste <- tapply(Sudeste$taxa_alfabetizacao, Sudeste$sigla_uf, mean, na.rm = TRUE)
print("Média da Taxa de Alfabetização por Estado - Sudeste:")
print(mediasudeste)

mediasul <- tapply(Sul$taxa_alfabetizacao, Sul$sigla_uf, mean, na.rm = TRUE)
print("Média da Taxa de Alfabetização por Estado - Sul:")
print(mediasul)

# ---------- DESVIO PADRÃO DA TAXA DE ALFABETIZAÇÃO POR ESTADO ----------
sdsudeste <- tapply(Sudeste$taxa_alfabetizacao, Sudeste$sigla_uf, sd, na.rm = TRUE)
print("Desvio Padrão da Taxa de Alfabetização por Estado - Sudeste:")
print(sdsudeste)

sdsul <- tapply(Sul$taxa_alfabetizacao, Sul$sigla_uf, sd, na.rm = TRUE)
print("Desvio Padrão da Taxa de Alfabetização por Estado - Sul:")
print(sdsul)

# ---------- DESVIO PADRÃO GERAL DA TAXA DE ALFABETIZAÇÃO POR REGIÃO ----------
sd_sudeste <- sd(Sudeste$taxa_alfabetizacao, na.rm = TRUE)
print(paste("Desvio Padrão Geral da Taxa de Alfabetização - Sudeste:", sd_sudeste))

sd_sul <- sd(Sul$taxa_alfabetizacao, na.rm = TRUE)
print(paste("Desvio Padrão Geral da Taxa de Alfabetização - Sul:", sd_sul))

# ---------- VARIÂNCIA GERAL DA TAXA DE ALFABETIZAÇÃO POR REGIÃO ----------
var_sudeste <- var(Sudeste$taxa_alfabetizacao, na.rm = TRUE)
print(paste("Variância Geral da Taxa de Alfabetização - Sudeste:", var_sudeste))

var_sul <- var(Sul$taxa_alfabetizacao, na.rm = TRUE)
print(paste("Variância Geral da Taxa de Alfabetização - Sul:", var_sul))

# ---------- VARIÂNCIA POR ESTADO ----------
varsudeste <- tapply(Sudeste$taxa_alfabetizacao, Sudeste$sigla_uf, var, na.rm = TRUE)
print("Variância da Taxa de Alfabetização por Estado - Sudeste:")
print(varsudeste)

varsul <- tapply(Sul$taxa_alfabetizacao, Sul$sigla_uf, var, na.rm = TRUE)
print("Variância da Taxa de Alfabetização por Estado - Sul:")
print(varsul)

# ---------- COEFICIENTE DE VARIAÇÃO GERAL POR REGIÃO ----------
cv_sudeste <- (sd_sudeste / mean_sudeste) * 100
print(paste("Coeficiente de Variação Geral (%) - Sudeste:", cv_sudeste))

cv_sul <- (sd_sul / mean_sul) * 100
print(paste("Coeficiente de Variação Geral (%) - Sul:", cv_sul))

# ---------- COEFICIENTE DE VARIAÇÃO POR ESTADO ----------
cvsudeste <- (sdsudeste / mediasudeste) * 100
print("Coeficiente de Variação (%) da Taxa de Alfabetização por Estado - Sudeste:")
print(cvsudeste)

cvsul <- (sdsul / mediasul) * 100
print("Coeficiente de Variação (%) da Taxa de Alfabetização por Estado - Sul:")
print(cvsul)

# ---------- QUARTIS DA TAXA DE ALFABETIZAÇÃO POR REGIÃO ----------
quartis_sudeste <- quantile(Sudeste$taxa_alfabetizacao, probs = c(0.25, 0.5, 0.75), na.rm = TRUE)
print("Quartis da Taxa de Alfabetização - Sudeste:")
print(quartis_sudeste)

quartis_sul <- quantile(Sul$taxa_alfabetizacao, probs = c(0.25, 0.5, 0.75), na.rm = TRUE)
print("Quartis da Taxa de Alfabetização - Sul:")
print(quartis_sul)

# ---------- BOXPLOT COMPARATIVO ENTRE SUL E SUDESTE ----------
boxplot(taxa_alfabetizacao ~ regiao, data = dados[dados$regiao %in% c("Sul", "Sudeste"),],
        main = "Boxplot da Taxa de Alfabetização - Sul vs Sudeste",
        xlab = "Região",
        ylab = "Taxa de Alfabetização",
        col = c("lightblue", "lightgreen"))

# Instala e carrega o ggplot2 (se ainda não instalado)
if (!require(ggplot2)) {
  install.packages("ggplot2")
  library(ggplot2)
} else {
  library(ggplot2)
}

# Filtrando apenas dados do Sul
dados_sul <- dados[dados$regiao == "Sul", ]

# Histograma com ggplot2 para Sul
ggplot(dados_sul, aes(x = taxa_alfabetizacao, fill = sigla_uf)) +
  geom_histogram(position = "dodge", bins = 10, color = "black") +
  labs(title = "Histograma da Taxa de Alfabetização - Região Sul (por Estado)",
       x = "Taxa de Alfabetização", y = "Frequência") +
  theme_minimal()

# Filtrando apenas dados do Sudeste
dados_sudeste <- dados[dados$regiao == "Sudeste", ]

# Histograma com ggplot2 para Sudeste
ggplot(dados_sudeste, aes(x = taxa_alfabetizacao, fill = sigla_uf)) +
  geom_histogram(position = "dodge", bins = 10, color = "black") +
  labs(title = "Histograma da Taxa de Alfabetização - Região Sudeste (por Estado)",
       x = "Taxa de Alfabetização", y = "Frequência") +
  theme_minimal()


```

-----

## 5\. Figuras Geradas e Explicações

Insira aqui gráficos com breve explicação. Para adicionar imagens no Markdown do GitHub:

```markdown
![Boxplot da Taxa de Alfabetização – Sul vs Sudeste](https://github.com/pedrokson/trabalho-estatistica/blob/main/Rplot.png)
```

### 5.1. Histograma da Variável [Nome da Variável]

  * **Explicação:** Este histograma mostra a distribuição da variável `Idade`. Observa-se que [descreva as principais características da distribuição, ex: a maioria dos indivíduos está na faixa de 30-40 anos, a distribuição é levemente assimétrica à direita, etc.]. Isso é importante para entender [justifique a relevância da visualização, ex: a composição etária da nossa amostra, a presença de outliers, etc.].

### 5.2. Gráfico de Dispersão entre [Variável X] e [Variável Y]

  * **Explicação:** O gráfico de dispersão acima ilustra a relação entre as variáveis `Variável X` e `Variável Y`. É possível observar [descreva a tendência, ex: uma correlação positiva, negativa, ausência de correlação, agrupamentos, etc.]. Esta visualização auxilia na [justifique a relevância, ex: identificação de padrões, detecção de relações lineares ou não lineares, etc.].

### 5.3. Gráfico de Barras da Variável Categórica [Nome da Variável]

  * **Explicação:** Este gráfico de barras apresenta a frequência de cada categoria da variável `Região`. [Descreva o que o gráfico mostra, ex: a maioria dos dados pertence à "Região Sul", enquanto a "Região Norte" possui a menor representatividade]. Essa visualização é crucial para [justifique a relevância, ex: entender a distribuição das categorias, identificar desequilíbrios na amostra, etc.].

-----

## 6\. Justificativa de Utilização de Cada Medida

### 6.1. Medidas de Tendência Central (Média, Mediana, Moda)

  * **Média:** Utilizada para [justifique a escolha, ex: fornecer uma visão geral do valor "típico" em distribuições aproximadamente simétricas, pois é sensível a valores extremos].
  * **Mediana:** Empregada para [justifique a escolha, ex: representar o valor central em distribuições assimétricas ou com outliers, pois não é afetada por valores extremos].
  * **Moda:** Aplicada para [justifique a escolha, ex: identificar o valor mais frequente em variáveis categóricas ou discretas, sendo útil para entender a categoria mais comum].

### 6.2. Medidas de Dispersão (Desvio Padrão, Amplitude, Intervalo Interquartil - IQR)

  * **Desvio Padrão:** Escolhido para [justifique a escolha, ex: quantificar a dispersão dos dados em relação à média, sendo útil em distribuições normais ou aproximadamente normais].
  * **Amplitude:** Utilizada para [justifique a escolha, ex: fornecer uma medida rápida da variação total dos dados, indicando a diferença entre o valor máximo e mínimo].
  * **Intervalo Interquartil (IQR):** Aplicado para [justifique a escolha, ex: medir a dispersão dos 50% centrais dos dados, sendo robusto a outliers e útil em distribuições assimétricas].

### 6.3. Medidas de Posição (Quartis, Percentis)

  * **Quartis/Percentis:** Empregados para [justifique a escolha, ex: dividir os dados em partes iguais, permitindo analisar a distribuição e identificar a posição relativa de valores, útil para identificar outliers e entender a cauda da distribuição].

### 6.4. Medidas de Associação (Coeficiente de Correlação de Pearson/Spearman)

  * **Coeficiente de Correlação de Pearson:** Utilizado para [justifique a escolha, ex: medir a força e direção de uma relação linear entre duas variáveis numéricas, assumindo normalidade].
  * **Coeficiente de Correlação de Spearman:** Empregado para [justifique a escolha, ex: medir a força e direção de uma relação monotônica entre duas variáveis, sem assumir normalidade, sendo robusto a outliers e útil para dados ordinais].

-----

## 7\. Testes Estatísticos Utilizados

### 7.1. Teste [Nome do Teste, ex: Teste t de Student para duas amostras independentes]

  * **Objetivo:** [Descreva o objetivo do teste, ex: Comparar as médias de duas amostras independentes para determinar se há uma diferença estatisticamente significativa entre elas.]
  * **Hipóteses:**
      * **H0 (Hipótese Nula):** [Descreva a hipótese nula, ex: Não há diferença significativa entre as médias dos grupos.]
      * **H1 (Hipótese Alternativa):** [Descreva a hipótese alternativa, ex: Há uma diferença significativa entre as médias dos grupos.]
  * **Resultado:**
    ```
    # Código R do teste
    t.test(dados$VariávelNumérica ~ dados$VariávelCategórica, data = dados)
    ```
      * **P-valor:** [Valor do p-valor]
      * **Interpretação:** [Com base no p-valor e nível de significância, ex: Com um p-valor de [X] e um nível de significância de 0.05, rejeitamos/não rejeitamos a hipótese nula. Isso indica que há/não há evidências suficientes para afirmar uma diferença significativa entre as médias dos grupos.]

### 7.2. Teste [Nome do Teste, ex: Análise de Variância (ANOVA)]

  * **Objetivo:** [Descreva o objetivo do teste, ex: Comparar as médias de três ou mais grupos para determinar se há uma diferença estatisticamente significativa entre elas.]
  * **Hipóteses:**
      * **H0:** [Descreva a hipótese nula, ex: As médias de todos os grupos são iguais.]
      * **H1:** [Descreva a hipótese alternativa, ex: Pelo menos uma média de grupo é diferente das outras.]
  * **Resultado:**
    ```r
    # Código R do teste
    modelo_aov <- aov(VariávelResposta ~ Fator, data = dados)
    summary(modelo_aov)
    ```
      * **P-valor:** [Valor do p-valor]
      * **Interpretação:** [Com base no p-valor, ex: Dado o p-valor de [X], menor que 0.05, rejeitamos a hipótese nula, indicando que existe uma diferença significativa entre as médias de pelo menos um grupo.]

-----

## 8\. Análise e Discussão dos Resultados Obtidos

Nesta seção, discuta os achados mais importantes da sua análise em relação às questões motivadoras. Não apenas reporte os números, mas interprete-os e conecte-os ao contexto do problema.

  * **Para a Questão 1 ([Reformule a questão]):**

      * [Apresente os principais achados relacionados a essa questão. Ex: Os resultados do teste t indicaram uma diferença estatisticamente significativa na média de [Variável Resposta] entre os grupos A e B (p \< 0.05). O Grupo A apresentou uma média [maior/menor] de [Valor] em comparação com o Grupo B, que teve uma média de [Valor].]
      * [Discuta as implicações desses achados. Ex: Isso sugere que [implicação prática, ex: a intervenção X realmente teve um impacto positivo/negativo].]

  * **Para a Questão 2 ([Reformule a questão]):**

      * [Apresente os resultados dos modelos ou análises. Ex: O modelo de regressão linear múltipla revelou que [Variável Preditiva X] é um preditor significativo de [Variável Resposta] (coeficiente = [Valor], p \< 0.01), enquanto [Variável Preditiva Y] não se mostrou significativa.]
      * [Discuta o significado prático e teórico desses achados. Ex: Este achado confirma que [ideia central] e pode ser usado para [aplicação prática].]

  * **Para a Questão 3 ([Reformule a questão]):**

      * [Descreva os padrões ou agrupamentos encontrados. Ex: A análise exploratória de dados, como o gráfico de dispersão, sugeriu a existência de dois grupos distintos de dados, com diferentes comportamentos em relação às variáveis X e Y. Isso foi corroborado por [mencione outro teste ou análise se aplicável].]
      * [Analise as possíveis razões para esses padrões. Ex: Acreditamos que esses grupos possam representar [explicação, ex: diferentes segmentos de clientes, condições experimentais distintas, etc.].]

-----

## 9\. Conclusão

Este relatório explorou o conjunto de dados [Nome do Conjunto de Dados] com o objetivo de [reafirme o objetivo geral]. As principais descobertas incluem:

  * [Resumo do principal achado 1, ex: Houve uma diferença significativa em [Variável] entre os grupos A e B.]
  * [Resumo do principal achado 2, ex: [Variável X] foi um preditor significativo de [Variável Y].]
  * [Resumo do principal achado 3, ex: Foram identificados dois padrões distintos nos dados, sugerindo a presença de subgrupos.]

Esses resultados têm implicações para [mencione as implicações práticas ou teóricas, ex: a tomada de decisão em marketing, o desenvolvimento de novas políticas, a compreensão de um fenômeno, etc.].

### Limitações e Trabalhos Futuros

É importante notar que [mencione quaisquer limitações da análise, ex: o tamanho da amostra, a ausência de algumas variáveis importantes, vieses nos dados, etc.].

Para trabalhos futuros, sugerimos:

  * [Sugestão de pesquisa futura 1, ex: Coletar mais dados para aumentar a robustez das análises.]
  * [Sugestão de pesquisa futura 2, ex: Explorar modelos mais complexos, como machine learning, para previsões mais precisas.]
  * [Sugestão de pesquisa futura 3, ex: Realizar análises de sensibilidade para avaliar a robustez dos resultados a diferentes suposições.]

-----

## Referências / Links Úteis

  * [Conjunto de Dados Original](https://www.google.com/search?q=https://example.com/link_para_dados)
  * [Documentação do Pacote ggplot2](https://ggplot2.tidyverse.org/)
  * [Guia de Markdown para GitHub](https://docs.github.com/pt/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax)

-----

### Dicas de Formatação Markdown para GitHub:

  * **Títulos:** Use `#` para o título principal, `##` para subtítulos, `###` para sub-subtítulos, e assim por diante.
  * **Texto em negrito:** Use `**texto**` ou `__texto__`.
  * **Texto em itálico:** Use `*texto*` ou `_texto_`.
  * **Listas não ordenadas:** Use `*` ou `-` seguido de um espaço.
    ```markdown
    * Item 1
    * Item 2
        * Subitem 2.1
    ```
  * **Listas ordenadas:** Use números seguidos de um ponto e um espaço.
    ```markdown
    1. Primeiro item
    2. Segundo item
    ```
  * **Blocos de código:** Use três crases (\`\`\`\`\`) antes e depois do seu bloco de código e especifique a linguagem para destaque de sintaxe.
    ````markdown
    ```R
    # Seu código R aqui
    print("Olá Mundo!")
    ```
    ````
  * **Código inline:** Use uma crase (`` ` ``) ao redor do texto. Exemplo: `print("Olá")`.
  * **Links:** Use `[Texto do link](URL do link)`. Exemplo: `[Google](https://www.google.com)`.
  * **Imagens:** Use `![Texto alternativo da imagem](URL da imagem)`. Para imagens locais no seu repositório GitHub, use caminhos relativos: `![Gráfico](img/grafico1.png)`.
  * **Tabelas:** Use `|` para separar colunas e `-` para a linha de cabeçalho.
    ```markdown
    | Cabeçalho 1 | Cabeçalho 2 |
    |---|---|
    | Linha 1 Coluna 1 | Linha 1 Coluna 2 |
    | Linha 2 Coluna 1 | Linha 2 Coluna 2 |
    ```
  * **Linhas horizontais:** Use três ou mais hifens (`---`), asteriscos (`***`) ou underscores (`___`) em uma linha separada.