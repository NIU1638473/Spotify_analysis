# Cargar las librerías necesarias
library(dplyr)
library(tidyr)
library(ggplot2)

# Leer los datasets
dataset1 <- read.csv("C:/Python Scripts/aitana_nodes.csv")
dataset2 <- read.csv("C:/Python Scripts/leony_nodes.csv")

# Calcular la media de seguidores y popularidad para cada dataset
mean_followers_ds1 <- mean(dataset1$followers, na.rm = TRUE)
mean_followers_ds2 <- mean(dataset2$followers, na.rm = TRUE)

mean_popularity_ds1 <- mean(dataset1$popularity, na.rm = TRUE)
mean_popularity_ds2 <- mean(dataset2$popularity, na.rm = TRUE)

cat("Media de seguidores - Dataset 1:", mean_followers_ds1, "\n")
cat("Media de seguidores - Dataset 2:", mean_followers_ds2, "\n")
cat("Media de popularidad - Dataset 1:", mean_popularity_ds1, "\n")
cat("Media de popularidad - Dataset 2:", mean_popularity_ds2, "\n")

# Función para obtener el top 3 de géneros
get_top_genres <- function(genres_column) {
  genres_list <- unlist(strsplit(as.character(genres_column), ","))
  genres_list <- trimws(genres_list)  # Eliminar espacios en blanco
  genres_freq <- table(genres_list)
  genres_freq <- sort(genres_freq, decreasing = TRUE)
  return(head(genres_freq, 3))
}

# Obtener el top 3 de géneros para cada dataset
top_genres_ds1 <- get_top_genres(dataset1$genres)
top_genres_ds2 <- get_top_genres(dataset2$genres)

cat("Top 3 géneros - Dataset 1:\n")
print(top_genres_ds1)

cat("Top 3 géneros - Dataset 2:\n")
print(top_genres_ds2)
