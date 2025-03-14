# -*- coding: utf-8 -*-
"""
Created on Tue Mar 11 21:44:17 2025

@author: Alex
"""

import spotipy
from spotipy.oauth2 import SpotifyClientCredentials
import pandas as pd

# 🔹 Configurar autenticación con Spotify API
SPOTIPY_CLIENT_ID = "c2a7e119b7a44085ada6c52b40f2ca95"
SPOTIPY_CLIENT_SECRET = "044b9c637f874f48906e960c0e6de16a"

sp = spotipy.Spotify(auth_manager=SpotifyClientCredentials(client_id=SPOTIPY_CLIENT_ID,
                                                           client_secret=SPOTIPY_CLIENT_SECRET))

# 🔹 ARTISTA INICIAL (Cambia este ID por el del artista que quieras analizar)
ARTIST_ID = "2NpPlwwDVYR5dIj0F31EcC"  # Ejemplo: 

# 🔹 Obtener información del artista inicial
def get_artist_info(artist_id):
    artist = sp.artist(artist_id)
    return {
        "artist_id": artist["id"],
        "name": artist["name"],
        "popularity": artist["popularity"],
        "followers": artist["followers"]["total"],
        "genres": ", ".join(artist["genres"]),
        "country": artist["external_urls"]["spotify"]
    }

# 🔹 Obtener colaboraciones de un artista (artistas en canciones donde participa)
def get_collaborations(artist_id):
    collaborations = []
    results = sp.artist_albums(artist_id, album_type="album,single", limit=50)
    
    for album in results["items"]:
        album_tracks = sp.album_tracks(album["id"])
        for track in album_tracks["items"]:
            artist_ids = [artist["id"] for artist in track["artists"]]
            if artist_id in artist_ids and len(artist_ids) > 1:
                for collab_id in artist_ids:
                    if collab_id != artist_id:
                        collaborations.append({"source": artist_id, "target": collab_id, "track": track["name"]})
    
    return collaborations

# 🔹 Paso 1: Obtener información del artista inicial
artists_data = {}
edges_data = []
artist_info = get_artist_info(ARTIST_ID)
artists_data[ARTIST_ID] = artist_info

# 🔹 Paso 2: Obtener sus colaboraciones
collaborations = get_collaborations(ARTIST_ID)
print(collaborations)
edges_data.extend(collaborations)

# #🔹 Paso 3: Obtener información de los artistas con los que ha colaborado
for collab in collaborations:
    collab_id = collab["target"]
    if collab_id not in artists_data:
        artists_data[collab_id] = get_artist_info(collab_id)

# Nombre del archivo CSV
filename = 'edges.csv'
csv = collaborations
# Nombre del archivo CSV
filename = "dataset.csv"


# 🔹 Paso 4: Obtener colaboraciones entre los artistas con los que el inicial colaboró
for collab in collaborations:
    collab_id = collab["target"]
    collab_collabs = get_collaborations(collab_id)
    for c in collab_collabs:
        if c["target"] in artists_data:  # Solo agregamos si ya conocemos al artista
            edges_data.append(c)

# 🔹 Guardar los datos en CSV
df_nodes = pd.DataFrame.from_dict(artists_data, orient="index")
df_edges = pd.DataFrame(edges_data)

df_nodes.to_csv("Leony_nodes.csv", index=False)
df_edges.to_csv("Leony_edges.csv", index=False)

print("✅ Dataset generado con éxito.")
