![FLOODISI Logo](floodisi_logo.png)

## Overview:

- The FLOODISI (Flood Detection Integrating Spectral Water Indices) is an innovative approach designed to overcome the challenges of flood mapping using unique spectral water indices. By integrating multiple spectral water indices using adaptive thresholds within an automated workflow in R and Python, FLOODISI produces an Integrated Water Map (IWM). This enables robust detection of flooded areas and supports operational monitoring and response activities in flood-prone areas.

## Key Features:

- Imports multispectral images.
- Provides adaptive thresholds (default).
- Provides thresholds for noise removal (default).
- Calculates 11 spectral water indices based on the spectral bands of the imported image.
- Calculates and provides layers for filtering based on the spectral bands of the imported image.
- Applies thresholding to each water spectral index.
- Applies correction to each thresholded map derived from the spectral indices.
- Integrates the thresholded maps into a single map of flooded areas, the Integrated Water Map (IWM).
- Calculates the flooded area for each thresholded water spectral index and the IWM.

## Applications:

- Fast and robust flood mapping.
- Provision of flood maps for operational applications in disaster monitoring and risk management.

## The code package includes:

- The file “floodisi_l8_l9.R” contains R code for Landsat-8/OLI and Landsat-8/OLI-2 data.
- The file “floodisi_l8_l9.ipynb” contains the code for Colab/Jupyter notebooks for Landsat-8/OLI and Landsat-8/OLI-2 data.
- The file “floodisi_s2.R” contains the R code for Sentinel-2/MSI data.
- The file “floodisi_s2.ipynb” contains the code for Colab/Jupyter notebooks for Sentinel-2/MSI data.

## References and Citations:

T Bazzan, CD Rennó, EW Reckziegel, LA Guasselli, CC Korb. FLOODISI: Flood Detection Integrating Spectral Water Índices. Manuscript under review. 2026.

## How to Contribute:

- Feel free to contribute! If you have any suggestions, don’t hesitate to open an issue or submit a pull request.

- For more information and discussions, please contact: Thiago Bazzan tbazzan@gmail.com

## Licença

This project is licensed under the **MIT License**—see the [LICENSE](LICENSE) file for more details.
