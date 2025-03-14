# Cargar la librería dplyr
library(dplyr)

# Leer el archivo CSV
data <- read.csv("C:/Python Scripts/aitana_edges.csv")  # Reemplaza "tu_archivo.csv" con la ruta de tu archivo

# Eliminar la columna 'track'
data <- data %>% select(-track)

# Contar las duplicaciones de combinaciones source-target y crear un nuevo dataset
new_data <- data %>%
  group_by(source, target) %>%
  summarise(count = n(), .groups = 'drop')

# Guardar el nuevo dataset en un archivo CSV (opcional)
write.csv(new_data, "aitana_edges_2.csv", row.names = FALSE)  # Reemplaza "nuevo_dataset.csv" con el nombre que desees

### Digital Humanities code ###
library(dplyr)
library(igraph)

# Leer el archivo de nodos
nodes <- read.csv("C:/Python Scripts/leony_nodes.csv", header=TRUE, encoding = "UTF-8")

# Eliminar la columna 'country' (si existe)
nodes <- nodes %>% select(-spotify_url)

# Leer el archivo de aristas (edges)
edges <- read.csv("C:/Python Scripts/edges_filtrado.csv", header=TRUE, encoding = "UTF-8")

# Verificar la longitud de los nombres de los nodos
node_names <- nodes$name
print(length(node_names))


# Crear el grafo a partir de las aristas, usando la columna 'count' como peso
graph <- graph_from_data_frame(d = edges, vertices = nodes, directed = FALSE)

# Asignar los pesos de las aristas basados en la columna 'count'
E(graph)$weight <- edges$count

# Verificar el grafo
print(graph)
summary(graph)

# Opcional: Visualizar el grafo (requiere el paquete 'igraph' o 'visNetwork')
plot(graph, edge.width = E(graph)$weight, vertex.label = node_names)

# Exportar el grafo en formato GraphML (compatible con Gephi)
write_graph(graph, file = "grafo.graphml", format = "graphml")
