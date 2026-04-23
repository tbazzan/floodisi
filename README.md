# FLOOd Detection Integrating Spetral water Indices (FLOODISI)

Uma rotina para o mapeamento de inundações com integração de múltiplos índices espectrais de água.

## Overview

- O FLOODISI é uma abordagem inovadora projetada para superar os desafios no mapeamento de inundações com índices espectrais da água. Ao integrar múltiplos índices espectrais de água utilizando limiares adaptativos dentro de um fluxo de trabalho automatizado em R e Python, o FLOODISI que resulta em um Integrated Water Map (IWM) que permite a detecção precisa de áreas inundadas e aprimora a resposta a emergências em regiões propensas a inundações.

## Principais características

- Importa imagem multiespectral
- Fonece limiares adaptativos (default)
- Fonece limiares para remoção de ruídos (default)
- Calcula 11 índices espectrais da água com base nas bandas espectrais da imagem importada
- Calcula e fornece as camadas para filtragem baseada nas bandas espectrais da imagem importada
- Aplica a limiarização sobre cada índice espectral da água
- Aplica a correção em cada mapa limiarizado derivados dos índices espectrais
- Integra os mapas limiarizados em um único mapa de áreas inundadas

## 🚀 Tecnologias Utilizadas

- **[Linguagem/Framework 1](https://link-da-documentacao.com)**
- **[Linguagem/Framework 2](https://link-da-documentacao.com)**
- **[Ferramenta/Plataforma 3](https://link-da-documentacao.com)**

## 📷 Capturas de Tela

![Screenshot 1](https://via.placeholder.com/800x400.png?text=Screenshot+1)
![Screenshot 2](https://via.placeholder.com/800x400.png?text=Screenshot+2)

## 📦 Instalação

```bash
# Clone este repositório
git clone https://github.com/usuario/repositorio.git

# Entre no diretório
cd repositorio

# Instale as dependências
npm install

# Inicie o projeto
npm start
```

## 🛠 Como Contribuir

1. Faça um _fork_ do projeto.
2. Crie uma nova _branch_: `git checkout -b minha-branch`
3. Faça suas alterações e _commit_: `git commit -m 'Minha contribuição'`
4. Envie para o repositório remoto: `git push origin minha-branch`
5. Abra um **Pull Request**

## 📜 Licença

Este projeto está licenciado sob a **MIT License** - veja o arquivo [LICENSE](LICENSE) para mais detalhes.

---

_Mantenedor: [Seu Nome](https://github.com/tbazzan)_ 🚀
