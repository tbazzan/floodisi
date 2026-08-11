![FLOODISI Logo](floodisi_logo.png)

## FLOODISI — Flood Detection Integrating Spectral Water Indices An R and Python framework for open floodwater mapping from Landsat 8/9 and Sentinel-2 multispectral imagery.

## Overview:

- The FLOODISI (Flood Detection Integrating Spectral Water Indices) is an innovative approach designed to overcome the challenges of flood mapping using individual spectral water indices. By integrating multiple spectral water indices using adaptive thresholds within an automated workflow in R and Python, FLOODISI produces an Integrated Water Map (IWM). This enables robust detection of flooded areas and supports operational monitoring and response activities in flood-prone areas.

## Key Features:

- Imports multispectral images.
- Provides adaptive thresholds (default).
- Provides thresholds for noise removal (default).
- Calculates 12 spectral water indices based on the spectral bands of the imported image.
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

## The following sample datasets are provided for testing the FLOODISI workflow:

- The file image_l8_l9.tif contains the spectral bands from Landsat 8/OLI data.
- The file image_s2.tif contains the spectral bands from Sentinel-2/MSI data.

## Quick Start

1. Clone or download the repository.
2. Select the appropriate workflow:
   - Landsat 8/9: floodisi_l8_l9_v1.R or floodisi_l8_l9_v1.ipynb
   - Sentinel-2: floodisi_s2_v1.R or floodisi_s2_v1.ipynb
3. Use the corresponding sample image in /data.
4. Define the input/output directories.
5. Run the workflow.

## References and Citations:

If you use FLOODISI in your research, please cite:

Bazzan, T.; Rennó, C.D.; Reckziegel, E.W.; Guasselli, L.A.; Korb, C.C. Flood Detection Integrating Spectral Indices (FLOODISI): A Novel Approach to Open-Water Mapping. Geosciences 2026, 16, 325. https://doi.org/10.3390/geosciences16080325

## How to Contribute:

- Feel free to contribute! If you have any suggestions, don’t hesitate to open an issue or submit a pull request.

- For more information and discussions, please contact: Thiago Bazzan tbazzan@gmail.com

## License

This project is licensed under the **MIT License**—see the [LICENSE](LICENSE) file for more details.
