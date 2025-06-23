# Visualizando as primeiras linhas do dataframe
head(dados)

# Filtrando os dados por região
Sul <- dados[dados$regiao == "Sul", ]
Sudeste <- dados[dados$regiao == "Sudeste", ]

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
