# -*- coding: utf-8 -*-
"""
Created on Thu Mar 13 23:15:42 2025

@author: Alex
"""
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

def compare_followers_distribution(df1, df2, name1='Dataset 1', name2='Dataset 2'):
    """
    Compara la distribución de seguidores entre dos datasets de artistas.
    
    Args:
        df1 (pd.DataFrame): Primer dataset con una columna 'followers'.
        df2 (pd.DataFrame): Segundo dataset con una columna 'followers'.
        name1 (str): Nombre del primer dataset (para etiquetas del gráfico).
        name2 (str): Nombre del segundo dataset (para etiquetas del gráfico).
    """
    df1['Source'] = name1
    df2['Source'] = name2
    
    # Combinar los datasets
    combined_df = pd.concat([df1[['followers', 'Source']], df2[['followers', 'Source']]])
    
    # Configurar la figura
    plt.figure(figsize=(6, 6))
    
    # Boxplot para comparar la distribución de seguidores
    sns.boxplot(x='Source', y='followers', data=combined_df)
    plt.yscale('log')  # Escala logarítmica si hay diferencias grandes
    plt.title('Followers comparison (Boxplot)')
    
    plt.show()

# Cargar datos desde CSV
df_spain = pd.read_csv("C:/Python Scripts/aitana_nodes.csv")
df_germany = pd.read_csv("C:/Python Scripts/leony_nodes.csv")

compare_followers_distribution(df_spain, df_germany, name1='Spain', name2='Germany')
