# FLOOd Detection Integrating Spectral water Indices (FLOODISI)

Uma rotina para o mapeamento de inundações com integração de múltiplos índices espectrais de água.

## Overview:

- O FLOODISI é uma abordagem inovadora projetada para superar os desafios no mapeamento de inundações com índices espectrais da água. Ao integrar múltiplos índices espectrais de água utilizando limiares adaptativos dentro de um fluxo de trabalho automatizado em R e Python, o FLOODISI que resulta em um Integrated Water Map (IWM) que permite a detecção precisa de áreas inundadas e aprimora a resposta a emergências em regiões propensas a inundações.

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
- Forncecimento de mapas de inundações para aplicações operacionais no monitoramento de desastres e na gestão de riscos

## O conjunto de códigos inclui:

- O arquivo "floodisi.R" contém o código para o R.
- O arquivo "floodisi.ipynb" contém o código para o Colab/Jupyter para notebooks.

## Referências e Citações:

T Bazzan, CD Rennó, EW Reckziegel, LA Guasselli. FLOODISI: Flood Detection Integrating Spectral Water Índices. Geosciences.

## Como Contribuir

Sinta-se à vontade para contribuir! Se tiver sugestões, não hesite em abrir uma issue ou um pull request.

Para mais informações e discussões, entre em contato com: Thiago Bazzan tbazzan@gmail.com

## Licença

Este projeto está licenciado sob a **MIT License** - veja o arquivo [LICENSE](LICENSE) para mais detalhes.
