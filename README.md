# FLOOd Detection Integrating Spectral water Indices (FLOODISI)

Uma rotina para o mapeamento de inundações com integração de múltiplos índices espectrais de água.

## Overview:

- O FLOODISI é uma abordagem inovadora projetada para superar os desafios no mapeamento de inundações com índices espectrais de água únicos. Ao integrar múltiplos índices espectrais de água utilizando limiares adaptativos dentro de um fluxo de trabalho automatizado em R e Python, o FLOODISI que resulta em um Integrated Water Map (IWM). Isso permite a detecção robusta de áreas inundadas e subsidia atividade operacionais de monitoramento e resposta em áreas propensas à inundações.

## Principais características:

- Importa imagem multiespectral.
- Fonece limiares adaptativos (default).
- Fonece limiares para remoção de ruídos (default).
- Calcula 11 índices espectrais da água com base nas bandas espectrais da imagem importada.
- Calcula e fornece as camadas para filtragem baseada nas bandas espectrais da imagem importada.
- Aplica a limiarização sobre cada índice espectral da água.
- Aplica a correção em cada mapa limiarizado derivados dos índices espectrais.
- Integra os mapas limiarizados em um único mapa de áreas inundadas, Integrated Water Map (IWM).
- Calcula a área inundadas de cada índice espectral da água limiarizado e do IWM.

## Aplicações:

- Mapeamento rápido e robusto de inundações
- Fornecimento de mapas de inundações para aplicações operacionais no monitoramento de desastres e na gestão de riscos

## O conjunto de códigos inclui:

- O arquivo "floodisi_l8_l9.R" contém o código para o R para dados do Landsat-8/OLI e Landsat-8/OLI-2.
- O arquivo "floodisi_l8_l9.ipynb" contém o código para o Colab/Jupyter para notebooks para dados do Landsat-8/OLI e Landsat-8/OLI-2.
- O arquivo "floodisi_s2.R" contém o código para o R para dados do Sentinel-2/MSI.
- O arquivo "floodisi_s2.ipynb" contém o código para o Colab/Jupyter para notebooks para dados do Sentinel-2/MSI.

## Referências e Citações:

T Bazzan, CD Rennó, EW Reckziegel, LA Guasselli. FLOODISI: Flood Detection Integrating Spectral Water Índices. Geosciences. 2026.

## Como Contribuir

Sinta-se à vontade para contribuir! Se tiver sugestões, não hesite em abrir uma issue ou um pull request.

Para mais informações e discussões, entre em contato com: Thiago Bazzan tbazzan@gmail.com

## Licença

Este projeto está licenciado sob a **MIT License** - veja o arquivo [LICENSE](LICENSE) para mais detalhes.
