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

# ---------- TESTE T DE STUDENT ----------
# Verificar se há diferença significativa entre as médias da taxa de alfabetização das regiões Sul e Sudeste

teste_t <- t.test(Sul$taxa_alfabetizacao, Sudeste$taxa_alfabetizacao,
                  alternative = "two.sided", # Teste bicaudal (médias diferentes)
                  var.equal = FALSE)         # Variância não assumida como igual (Welch)

print("Resultado do Teste t de Student entre Sul e Sudeste:")
print(teste_t)

# Filtrar apenas as regiões Sul e Sudeste
dados_anova <- dados[dados$regiao %in% c("Sul", "Sudeste"), ]

# Teste ANOVA: comparar a taxa de alfabetização entre os estados (sigla_uf)
modelo_aov <- aov(taxa_alfabetizacao ~ sigla_uf, data = dados_anova)

# Resumo dos resultados da ANOVA
summary(modelo_aov)


```

-----

## 5\. Figuras Geradas e Explicações

### 5.1. Boxplot da Taxa de Alfabetização – Sul vs Sudeste

 ![Boxplot da Taxa de Alfabetização – Sul vs Sudeste](https://github.com/pedrokson/trabalho-estatistica/blob/main/Rplot.png)

**Explicação:**  
No gráfico, observamos que a mediana da taxa de alfabetização é ligeiramente maior na região Sul em comparação à região Sudeste, diferente do que poderíamos esperar. A região Sul também apresenta uma menor dispersão (caixa menor), indicando que os municípios dessa região possuem taxas de alfabetização mais parecidas entre si. Já a região Sudeste apresenta maior variabilidade, com uma caixa mais larga e vários outliers abaixo da média, ou seja, existem municípios no Sudeste com taxas de alfabetização significativamente menores que os demais.

O uso do boxplot foi importante porque ele permite visualizar de forma clara a diferença entre as regiões, mostrando a média aproximada, a variação dos dados e também os municípios que estão fora do padrão esperado (outliers). Isso ajuda a entender melhor o comportamento dos dados e evita interpretações erradas em outras medidas, como a média e o desvio padrão.

### 5.2. Histograma em relação a taxa de alfabetização nos estados do sul

![Histograma em relação a taxa de alfabetização nos estados do sul](https://github.com/pedrokson/trabalho-estatistica/blob/main/Rplot01.png)

  * **Explicação:**   
  O histograma mostra a distribuição da taxa de alfabetização nos municípios dos três estados da região Sul (PR, RS e SC). É possível perceber que:

    O estado do Rio Grande do Sul (RS) (em verde) concentra a maior parte de seus municípios com taxas de alfabetização entre 0,94 e 0,97, indicando uma alta taxa média de alfabetização e baixa dispersão.

    O Paraná (PR) (em vermelho) apresenta uma distribuição mais espalhada, com uma quantidade considerável de municípios com taxas inferiores a 0,90, o que sugere maior variabilidade nos níveis de alfabetização.

    O estado de Santa Catarina (SC) (em azul) também tem boa concentração de municípios com taxas elevadas, próximas a 0,96 e 0,97, semelhante ao RS, mas com uma leve dispersão.

    De forma geral, percebe-se que RS e SC apresentam taxas de alfabetização mais altas e concentradas, enquanto o PR tem maior variação, incluindo municípios com taxas mais baixas de alfabetização.

  Por que esse gráfico foi usado?
    O histograma foi escolhido porque permite visualizar a distribuição das taxas de alfabetização em cada estado da região Sul, facilitando a comparação entre eles. Com ele, é possível identificar rapidamente quais estados possuem maior concentração de municípios com altas taxas de alfabetização e quais apresentam maior dispersão nos dados.
### 5.3. Histograma em relação a taxa de alfabetização nos estados do sudeste

![Histograma em relação a taxa de alfabetização nos estados do sudeste](https://github.com/pedrokson/trabalho-estatistica/blob/main/Rplot02.png)

  * **Explicação:** 
  O histograma apresenta a distribuição da taxa de alfabetização nos municípios dos estados que compõem a região Sudeste (ES, MG, RJ e SP). É possível observar que:

    O estado de Minas Gerais (MG) (em verde) concentra a maioria dos seus municípios com taxas de alfabetização entre 0,85 e 0,95, mas também possui uma quantidade razoável de municípios com taxas abaixo de 0,85, indicando maior variabilidade nos dados.

    O estado de São Paulo (SP) (em roxo) apresenta uma concentração alta de municípios com taxas de alfabetização próximas de 1,0, o que mostra que a maioria dos seus municípios tem taxas muito altas de alfabetização, com menor variabilidade.

    O Rio de Janeiro (RJ) (em azul) e o Espírito Santo (ES) (em vermelho) têm distribuições mais espalhadas, mas com menos municípios em comparação a MG e SP, aparecendo com barras de menor altura.

    Nota-se que em SP há menos municípios com taxas muito baixas, enquanto MG apresenta uma grande variedade de taxas, inclusive muitas mais baixas que as de SP.

  Por que esse gráfico foi usado?
    O histograma foi escolhido porque ele mostra de forma clara como as taxas de alfabetização estão distribuídas em cada estado da região Sudeste, permitindo comparar a frequência de diferentes faixas de alfabetização entre os estados. Ele também facilita a identificação de padrões, como estados com maior concentração de municípios altamente alfabetizados (SP) e estados com maior dispersão dos valores (MG).


-----

## 6\. Justificativa de Utilização de Cada Medida

### 6.1. Medidas de Tendência Central (Média, Mediana, Moda)

  * **Média:** Utilizada para fornecer uma visão geral da taxa média de alfabetização nas regiões analisadas. A média permite comparar os níveis gerais de alfabetização entre as regiões Sul e Sudeste, sendo adequada porque as distribuições são relativamente simétricas e não muito influenciadas por valores extremos.

  * **Mediana:** Empregada para representar o valor central das taxas de alfabetização, sendo útil caso existam outliers (municípios com taxas muito baixas, por exemplo). Assim, a mediana ajuda a evitar distorções que a média poderia sofrer com esses valores discrepantes.

  * **Moda:** Não foi utilizada nesta análise, pois a variável taxa de alfabetização é numérica contínua e não categórica, o que torna a identificação de uma moda pouco informativa neste contexto.

### 6.2. Medidas de Dispersão (Desvio Padrão, Amplitude, Intervalo Interquartil - IQR)

  * **Desvio Padrão:** Escolhido para medir a variabilidade das taxas de alfabetização em relação à média. Essa medida permite entender o quanto os municípios de cada região se afastam da média regional, sendo especialmente útil para comparar a homogeneidade entre Sul e Sudeste.

  * **Intervalo Interquartil (IQR):** Aplicado para avaliar a dispersão dos 50% centrais dos dados, sendo uma medida resistente a outliers. O IQR ajuda a entender a concentração da maioria dos municípios em torno da mediana, complementando a análise do desvio padrão.


### 6.3. Medidas de Posição (Quartis, Percentis)

  * **Quartis/Percentis:** Utilizados para dividir os dados em partes iguais, permitindo a análise detalhada da distribuição das taxas de alfabetização. Os quartis ajudam a identificar municípios com taxas muito baixas ou muito altas e facilitam a detecção de outliers, como observado no boxplot.



-----

## 7\. Testes Estatísticos Utilizados

### 7.1. Teste t de Student para duas amostras independentes
  * **Objetivo:** 
  Comparar as médias da taxa de alfabetização entre as regiões Sul e Sudeste do Brasil para verificar se existe uma diferença estatisticamente significativa entre elas.

  * **Hipóteses:**
      * **H0 (Hipótese Nula):** Não há diferença significativa entre as médias das taxas de alfabetização das regiões Sul e Sudeste (as médias são iguais).
      * **H1 (Hipótese Alternativa):**  Existe uma diferença significativa entre as médias das taxas de alfabetização das regiões Sul e Sudeste (as médias são diferentes).
  * **Resultado:**
    ```
    t.test(Sul$taxa_alfabetizacao, Sudeste$taxa_alfabetizacao,
       alternative = "two.sided", var.equal = FALSE)

    ```
      * **P-valor:** < 0,05
      * **Interpretação:** O p-valor encontrado foi menor que 0,05 (p < 2.2e-16), indicando que a hipótese nula pode ser rejeitada com um nível de confiança de 95%.
      Portanto, há evidências estatísticas suficientes para afirmar que existe uma diferença significativa entre as médias das taxas de alfabetização das regiões Sul e Sudeste.
      Observa-se que a média da região Sul (0.944) é superior à do Sudeste (0.924), sugerindo que, em geral, os municípios da região Sul possuem taxas de alfabetização ligeiramente mais altas.


### 7.2. Teste ANOVA (Análise de Variância)

  * **Objetivo:**
   Comparar as médias da taxa de alfabetização entre os diferentes estados (sigla_uf) das regiões Sul e Sudeste do Brasil para verificar se existe diferença estatisticamente significativa entre eles.
  * **Hipóteses:**
      * **H0:** As médias da taxa de alfabetização são iguais para todos os estados analisados.
      * **H1:** Pelo menos um dos estados apresenta média da taxa de alfabetização diferente dos demais.
  * **Resultado:**
    ```r
    # Código R do teste
    modelo_aov <- aov(VariávelResposta ~ Fator, data = dados)
    summary(modelo_aov)
    ```
      * **P-valor:** < 2e-16
      * **Interpretação:** Como o p-valor obtido é muito menor que 0.05, rejeitamos a hipótese nula. Isso indica que há diferença estatisticamente significativa nas médias da taxa de alfabetização entre pelo menos um dos estados das regiões Sul e Sudeste do Brasil. Portanto, as taxas de alfabetização não são homogêneas entre todos os estados dessas regiões.


-----

## 8\. Análise e Discussão dos Resultados Obtidos

Nesta seção, discuta os achados mais importantes da sua análise em relação às questões motivadoras. Não apenas reporte os números, mas interprete-os e conecte-os ao contexto do problema.

  * **Para a Questão 1 ([Existe diferença significativa entre as médias das taxas de alfabetização das regiões Sul e Sudeste?]):**

      * O teste t de Student aplicado indicou uma diferença estatisticamente significativa entre as médias das taxas de alfabetização das regiões Sul e Sudeste (p-valor < 0.05). A média da região Sul (94,41%) foi superior à média da região Sudeste (92,36%). Isso mostra que, de modo geral, os municípios da região Sul apresentam melhores índices de alfabetização comparados ao Sudeste.

      * Este resultado sugere que fatores socioeconômicos, históricos ou de políticas públicas regionais podem ter influenciado positivamente a taxa de alfabetização na região Sul, o que justifica essa diferença observada entre as médias regionais. Esse achado é importante para a formulação de políticas educacionais direcionadas.



  * **Para a Questão 2 (Existe diferença significativa entre as médias das taxas de alfabetização dos estados das regiões Sul e Sudeste?):**

      * A Análise de Variância (ANOVA) apontou um p-valor menor que 0.05, indicando que há diferença significativa nas médias das taxas de alfabetização entre os estados dessas regiões. Os resultados mostraram que no Sul os estados de Santa Catarina (95,6%) e Rio Grande do Sul (95,3%) possuem médias superiores, enquanto no Sudeste o destaque foi para São Paulo (94,9%) e Rio de Janeiro (94,3%), com Minas Gerais (90,4%) apresentando o menor valor.

      * A ANOVA confirma que os estados possuem desempenhos distintos em relação à taxa de alfabetização, mesmo pertencendo à mesma região geográfica. Isso pode ser explicado por diferentes investimentos em educação, condições socioeconômicas ou características demográficas específicas de cada estado.


  * **Para a Questão 3 (Como se distribuem os dados das taxas de alfabetização nas regiões analisadas? Há presença de outliers?):**

      * O boxplot elaborado revelou a presença de outliers principalmente no Sudeste, o que indica a existência de municípios com taxas de alfabetização bem abaixo da média regional. A região Sul apresentou menor variabilidade, com distribuição mais concentrada e poucos outliers.

      * Essa diferença na dispersão pode estar associada à heterogeneidade dos municípios do Sudeste, onde existem grandes centros urbanos ao lado de regiões mais carentes. No Sul, a distribuição mais homogênea sugere um padrão educacional mais equilibrado entre os municípios.



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