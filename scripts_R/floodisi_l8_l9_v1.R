# ============================================================
# FLOOD DETECTION INTEGRATING SPECTRAL INDICES (FLOODISI):
#             A TOOL FOR OPEN-WATER MAPPING
# ============================================================

# Any reference to the code and the work can be made by citing:

# Bazzan, T.; Rennó, C.D.; Reckziegel, E.W.; Guasselli, L.A.; Korb, C.C. Flood Detection Integrating Spectral Indices (FLOODISI): A Novel Approach to Open-Water Mapping. Geosciences 2026, 16, 325.

# https://doi.org/10.3390/geosciences16080325

# Script and updates available at: http://github.com/tbazzan/floodisi

# For more information, contact: Thiago Bazzan <tbazzan@gmail.com>

# ============================================================
# STEP 1 - INSTALL AND LOAD NECESSARY LIBRARIE
# ============================================================

if (!"terra" %in% installed.packages()[, "Package"]) {
  install.packages("terra")
}

library(terra)

# ============================================================
# STEP 2 - IMAGE LOAD (FOR LANDSAT-8/OLI AND LANDSAT-9/OLI-2
# ============================================================

# Select image

image <- rast("D:/image_l8_l9.tif")
names(image) <- c("band1", "band2", "band3", "band4", "band5", "band6", "band7")
image
plot(image)

# Rename bands

names(image) <- c("coastal", "blue", "green", "red", "nir", "swir1", "swir2")
image
plot(image)

# Plot image composite

plotRGB(image, r = "swir1", g = "nir", b = "red", stretch = "lin")

# ============================================================
# STEP 3 - THRESHOLDS
# ============================================================

# Adaptative Thresholds (Below, use the reference values or adjust the values to match local thresholds)

threshold <- list(
  ndwi1 = 0.012,
  ndwi2 = 0.055,
  ndwi3 = 0.231,
  mndwi = 0.109,
  wri = 0.979,
  ndfi1 = 0.094,
  ndfi2 = 0.276,
  aweish = -0.132,
  aweinsh = -0.092,
  wi2015 = 1.515,
  mbwi = -0.124,
  wi2020 = 0.037
)

# Filter Noise (Below, modify the values or enter 1000 for sum567 and -1000 for red_, in these cases, noise will not be removed)

filter <- list(
  sum567_ndwi1 = 0.373,
  sum567_ndwi2 = 0.373,
  sum567_ndwi3 = 0.353,
  sum567_mndwi = 0.369,
  sum567_wri = 0.373,
  sum567_ndfi1 = 0.369,
  sum567_ndfi2 = 0.369,
  red_aweish = 0.039,
  red_aweinsh = 0.039,
  sum567_wi2015 = 0.373,
  red_mbwi = 0.039,
  sum567_wi2020 = 0.353
)

# ============================================================
# STEP 4 - CALCULATE AND THRESHOLD SPECTRAL WATER INDEX
# ============================================================

# ============================================================
# NDWI (Normalized Difference Water Index) - McFeeters (1996)
# ============================================================

# Calculate index

ndwi1_index <- (image$green - image$nir) / (image$green + image$nir)
names(ndwi1_index) <- "ndwi1"
ndwi1_index
plot(ndwi1_index)

# Export index

writeRaster(ndwi1_index, "D:/ndwi1_index.tif", overwrite = TRUE)

# Create a matrix of values that represent the threshold for classification

class_matrix <- c(-Inf, threshold$ndwi1, 0, threshold$ndwi1, Inf, 1)
reclass_matrix <- matrix(class_matrix, ncol=3, byrow=TRUE)

# Reclassify the index using the reclass object

ndwi1_water_map <- classify(ndwi1_index, reclass_matrix)
color_map <- c("white", "blue")
plot(ndwi1_water_map, col=color_map, legend=FALSE, main = "NDWI-1 Water Map", cex.main = 1.0, cex.axis = 1.0, cex = 1.0)

# Export map

writeRaster(ndwi1_water_map, "D:/ndwi1_water_map.tif", overwrite = TRUE)

# Filter Noise

sum567_index <- (image$nir + image$swir1 + image$swir2)

# Create a matrix of values that represent the classification ranges

class_matrix <- c(-Inf, filter$sum567_ndwi1, 0, filter$sum567_ndwi1, Inf, 1) # these values can be change according yo the characteristics of de area
reclass_matrix <- matrix(class_matrix, ncol=3, byrow=TRUE)

# Reclassify the raster using the reclass object

sum567_map <- classify(sum567_index, reclass_matrix)

# Correction

ndwi1_water_map_filter <- ndwi1_water_map - sum567_map
ndwi1_water_map_filter

# Create a matrix of values that represent the classification ranges

class_matrix <- c(-Inf, 0, 0, 0, Inf, 1)
reclass_matrix <- matrix(class_matrix, ncol=3, byrow=TRUE)

# Reclassify the raster using the reclass object

ndwi1_water_map_corrected <- classify(ndwi1_water_map_filter, reclass_matrix)
color_map <- c("white", "blue")
plot(ndwi1_water_map_corrected, col=color_map, legend=FALSE, main = "NDWI-1 Water Map Correted", cex.main = 1.0, cex.axis = 1.0, cex = 1.0)

# Export Map

writeRaster(ndwi1_water_map_corrected, "D:/ndwi1_water_map_corrected.tif", overwrite = TRUE)

# ============================================================================
# NDWI2 (Modified Normalized Difference Water Index) - Rogers & Kearney (2004)
# ============================================================================

# Calculate Index

ndwi2_index <- (image$red - image$nir) / (image$red + image$nir)
names(ndwi2_index) <- "ndwi2"
ndwi2_index
plot(ndwi2_index)

# Export index

writeRaster(ndwi2_index, "D:/ndwi2_index.tif", overwrite = TRUE)

# Create a matrix of values that represent the threshold for classification

class_matrix <- c(-Inf, threshold$ndwi2, 0, threshold$ndwi2, Inf, 1)
reclass_matrix <- matrix(class_matrix, ncol=3, byrow=TRUE)

# Reclassify the index using the reclass object

ndwi2_water_map <- classify(ndwi2_index, reclass_matrix)
plot(ndwi2_water_map, col=color_map, legend=FALSE, main = "NDWI-2 Water Map", cex.main = 1.0, cex.axis = 1.0, cex = 1.0)

# Export map

writeRaster(ndwi2_water_map, "D:/ndwi2_water_map.tif", overwrite = TRUE)

# Filter Noise

sum567_index <- (image$nir + image$swir1 + image$swir2)

# Create a matrix of values that represent the classification ranges

class_matrix <- c(-Inf, filter$sum567_ndwi2, 0, filter$sum567_ndwi2, Inf, 1) # these values can be change according yo the characteristics of de area
reclass_matrix <- matrix(class_matrix, ncol=3, byrow=TRUE)

# Reclassify the raster using the reclass object

sum567_map <- classify(sum567_index, reclass_matrix)

# Correction

ndwi2_water_map_filtered <- ndwi2_water_map - sum567_map
ndwi2_water_map_filtered

# Create a matrix of values that represent the classification ranges

class_matrix <- c(-Inf, 0, 0, 0, Inf, 1)
reclass_matrix <- matrix(class_matrix, ncol=3, byrow=TRUE)

# Reclassify the raster using the reclass object

ndwi2_water_map_corrected <- classify(ndwi2_water_map_filtered, reclass_matrix)
color_map <- c("white", "blue")
plot(ndwi2_water_map_corrected, col=color_map, legend=FALSE, main = "NDWI-2 Water Map Correted", cex.main = 1.0, cex.axis = 1.0, cex = 1.0)

# Export Map

writeRaster(ndwi2_water_map_corrected, "D:/ndwi2_water_map_corrected.tif", overwrite = TRUE)

# ============================================================================
# NDWI-3 (Modified Normalized Difference Water Index) - Ouma & Tateishi (2006) 
# ============================================================================

# Calculate Index

ndwi3_index <- (image$green - image$swir2) / (image$green + image$swir2)
names(ndwi3_index) <- "ndwi3"
ndwi3_index
plot(ndwi3_index)

# Export index

writeRaster(ndwi3_index, "D:/ndwi3_index.tif", overwrite = TRUE)

# Create a matrix of values that represent the threshold for classification

class_matrix <- c(-Inf, threshold$ndwi3, 0, threshold$ndwi3, Inf, 1)
reclass_matrix <- matrix(class_matrix, ncol=3, byrow=TRUE)

# Reclassify the index using the reclass object

ndwi3_water_map <- classify(ndwi3_index, reclass_matrix)
plot(ndwi3_water_map, col=color_map, legend=FALSE, main = "NDWI-3 Water Map", cex.main = 1.0, cex.axis = 1.0, cex = 1.0)

# Export map

writeRaster(ndwi3_water_map, "D:/ndwi3_water_map.tif", overwrite = TRUE)

# Filter Noise

sum567_index <- (image$nir + image$swir1 + image$swir2)

# Create a matrix of values that represent the classification ranges

class_matrix <- c(-Inf, filter$sum567_ndwi3, 0, filter$sum567_ndwi3, Inf, 1) # these values can be change according yo the characteristics of de area
reclass_matrix <- matrix(class_matrix, ncol=3, byrow=TRUE)

# Reclassify the raster using the reclass object

sum567_map <- classify(sum567_index, reclass_matrix)

# Correction

ndwi3_water_map_filtered <- ndwi3_water_map - sum567_map
ndwi3_water_map_filtered

# Create a matrix of values that represent the classification ranges

class_matrix <- c(-Inf, 0, 0, 0, Inf, 1)
reclass_matrix <- matrix(class_matrix, ncol=3, byrow=TRUE)

# Reclassify the raster using the reclass object

ndwi3_water_map_corrected <- classify(ndwi3_water_map_filtered, reclass_matrix)
color_map <- c("white", "blue")
plot(ndwi3_water_map_corrected, col=color_map, legend=FALSE, main = "NDWI-3 Water Map Correted", cex.main = 1.0, cex.axis = 1.0, cex = 1.0)

# Export Map

writeRaster(ndwi3_water_map_corrected, "D:/ndwi3_water_map_corrected.tif", overwrite = TRUE)

# ================================================================
# MNDWI (Modified Normalized Difference Water Index) - Xu (2006)
# ================================================================

# Calculate Index

mndwi_index <- (image$green - image$swir1) / (image$green + image$swir1)
names(mndwi_index) <- "mndwi"
mndwi_index
plot(mndwi_index)

# Export index

writeRaster(mndwi_index, "D:/mndwi_index.tif", overwrite = TRUE)

# Create a matrix of values that represent the threshold for classification

class_matrix <- c(-Inf, threshold$mndwi, 0, threshold$mndwi, Inf, 1)
reclass_matrix <- matrix(class_matrix, ncol=3, byrow=TRUE)

# Reclassify the index using the reclass object

mndwi_water_map <- classify(mndwi_index, reclass_matrix)
plot(mndwi_water_map, col=color_map, legend=FALSE, main = "MNDWI Water Map", cex.main = 1.0, cex.axis = 1.0, cex = 1.0)

# Export map

writeRaster(mndwi_water_map, "D:/mndwi_water_map.tif", overwrite = TRUE)

# Filter Noise

sum567_index <- (image$nir + image$swir1 + image$swir2)

# Create a matrix of values that represent the classification ranges

class_matrix <- c(-Inf, filter$sum567_mndwi, 0, filter$sum567_mndwi, Inf, 1) # these values can be change according yo the characteristics of de area
reclass_matrix <- matrix(class_matrix, ncol=3, byrow=TRUE)

# Reclassify the raster using the reclass object

sum567_map <- classify(sum567_index, reclass_matrix)

# Correction

mndwi_water_map_filtered <- mndwi_water_map - sum567_map
mndwi_water_map_filtered

# Create a matrix of values that represent the classification ranges

class_matrix <- c(-Inf, 0, 0, 0, Inf, 1)
reclass_matrix <- matrix(class_matrix, ncol=3, byrow=TRUE)

# Reclassify the raster using the reclass object

mndwi_water_map_corrected <- classify(mndwi_water_map_filtered, reclass_matrix)
color_map <- c("white", "blue")
plot(mndwi_water_map_corrected, col=color_map, legend=FALSE, main = "MNDWI Water Map Correted", cex.main = 1.0, cex.axis = 1.0, cex = 1.0)

# Export Map

writeRaster(mndwi_water_map_corrected, "D:/mndwi_water_map_corrected.tif", overwrite = TRUE)

# ===================================
# WRI (Water Ratio Index) - Li (2010)
# ===================================

# Calculate Index

wri_index <- (image$green + image$red) / (image$nir + image$swir1)
names(wri_index) <- "wri"
wri_index
plot(wri_index)

# Export index

writeRaster(wri_index, "D:/wri_index.tif", overwrite = TRUE)

# Create a matrix of values that represent the threshold for classification

class_matrix <- c(-Inf, threshold$wri, 0, threshold$wri, Inf, 1)
reclass_matrix <- matrix(class_matrix, ncol=3, byrow=TRUE)

# Reclassify the index using the reclass object

wri_water_map <- classify(wri_index, reclass_matrix)
plot(wri_water_map, col=color_map, legend=FALSE, main = "WRI Water Map", cex.main = 1.0, cex.axis = 1.0, cex = 1.0)

# Export map

writeRaster(wri_water_map, "D:/wri_water_map.tif", overwrite = TRUE)

# Filter Noise

sum567_index <- (image$nir + image$swir1 + image$swir2)

# Create a matrix of values that represent the classification ranges

class_matrix <- c(-Inf, filter$sum567_wri, 0, filter$sum567_wri, Inf, 1) # these values can be change according yo the characteristics of de area
reclass_matrix <- matrix(class_matrix, ncol=3, byrow=TRUE)

# Reclassify the raster using the reclass object

sum567_map <- classify(sum567_index, reclass_matrix)

# Correction

wri_water_map_filtered <- wri_water_map - sum567_map
wri_water_map_filtered

# Create a matrix of values that represent the classification ranges

class_matrix <- c(-Inf, 0, 0, 0, Inf, 1)
reclass_matrix <- matrix(class_matrix, ncol=3, byrow=TRUE)

# Reclassify the raster using the reclass object

wri_water_map_corrected <- classify(wri_water_map_filtered, reclass_matrix)
color_map <- c("white", "blue")
plot(wri_water_map_corrected, col=color_map, legend=FALSE, main = "WRI Water Map Correted", cex.main = 1.0, cex.axis = 1.0, cex = 1.0)

# Export Map

writeRaster(wri_water_map_corrected, "D:/wri_water_map_corrected.tif", overwrite = TRUE)

# ====================================================================
# NDFI-1 (Normalized Difference Flood Index) - Boschetti et al. (2014)
# ====================================================================

# Calculate Index

ndfi1_index <- (image$red - image$swir1) / (image$red + image$swir1)
names(ndfi1_index) <- "ndfi1"
ndfi1_index
plot(ndfi1_index)

# Export index

writeRaster(ndfi1_index, "D:/ndfi1_index.tif", overwrite = TRUE)

# Create a matrix of values that represent the threshold for classification

class_matrix <- c(-Inf, threshold$ndfi1, 0, threshold$ndfi1, Inf, 1)
reclass_matrix <- matrix(class_matrix, ncol=3, byrow=TRUE)

# Reclassify the index using the reclass object

ndfi1_water_map <- classify(ndfi1_index, reclass_matrix)
plot(ndfi1_water_map, col=color_map, legend=FALSE, main = "NDFI-1 Water Map", cex.main = 1.0, cex.axis = 1.0, cex = 1.0)

# Export map

writeRaster(ndfi1_water_map, "D:/ndfi1_water_map.tif", overwrite = TRUE)

# Filter Noise

sum567_index <- (image$nir + image$swir1 + image$swir2)

# Create a matrix of values that represent the classification ranges

class_matrix <- c(-Inf, filter$sum567_ndfi1, 0, filter$sum567_ndfi1, Inf, 1) # these values can be change according yo the characteristics of de area
reclass_matrix <- matrix(class_matrix, ncol=3, byrow=TRUE)

# Reclassify the raster using the reclass object

sum567_map <- classify(sum567_index, reclass_matrix)

# Correction

ndfi1_water_map_filtered <- ndfi1_water_map - sum567_map
ndfi1_water_map_filtered

# Create a matrix of values that represent the classification ranges

class_matrix <- c(-Inf, 0, 0, 0, Inf, 1)
reclass_matrix <- matrix(class_matrix, ncol=3, byrow=TRUE)

# Reclassify the raster using the reclass object

ndfi1_water_map_corrected <- classify(ndfi1_water_map_filtered, reclass_matrix)
color_map <- c("white", "blue")
plot(ndfi1_water_map_corrected, col=color_map, legend=FALSE, main = "NDFI-1 Water Map Correted", cex.main = 1.0, cex.axis = 1.0, cex = 1.0)

# Export Map

writeRaster(ndfi1_water_map_corrected, "D:/ndfi1_water_map_corrected.tif", overwrite = TRUE)

# ====================================================================
# NDFI-2 (Normalized Difference Flood Index) - Boschetti et al. (2014)
# ====================================================================

# Calculate Index

ndfi2_index <- (image$red - image$swir2) / (image$red + image$swir2)
names(ndfi2_index) <- "ndfi2"
ndfi2_index
plot(ndfi2_index)

# Export index

writeRaster(ndfi2_index, "D:/ndfi2_index.tif", overwrite = TRUE)

# Create a matrix of values that represent the threshold for classification

class_matrix <- c(-Inf, threshold$ndfi2, 0, threshold$ndfi2, Inf, 1)
reclass_matrix <- matrix(class_matrix, ncol=3, byrow=TRUE)

# Reclassify the index using the reclass object

ndfi2_water_map <- classify(ndfi2_index, reclass_matrix)
plot(ndfi2_water_map, col=color_map, legend=FALSE, main = "NDFI-2 Water Map", cex.main = 1.0, cex.axis = 1.0, cex = 1.0)

# Export map

writeRaster(ndfi2_water_map, "D:/ndfi2_water_map.tif", overwrite = TRUE)

# Filter Noise

sum567_index <- (image$nir + image$swir1 + image$swir2)

# Create a matrix of values that represent the classification ranges

class_matrix <- c(-Inf, filter$sum567_ndfi2, 0, filter$sum567_ndfi2, Inf, 1) # these values can be change according yo the characteristics of de area
reclass_matrix <- matrix(class_matrix, ncol=3, byrow=TRUE)

# Reclassify the raster using the reclass object

sum567_map <- classify(sum567_index, reclass_matrix)

# Correction

ndfi2_water_map_filtered <- ndfi2_water_map - sum567_map
ndfi2_water_map_filtered

# Create a matrix of values that represent the classification ranges

class_matrix <- c(-Inf, 0, 0, 0, Inf, 1)
reclass_matrix <- matrix(class_matrix, ncol=3, byrow=TRUE)

# Reclassify the raster using the reclass object

ndfi2_water_map_corrected <- classify(ndfi2_water_map_filtered, reclass_matrix)
color_map <- c("white", "blue")
plot(ndfi2_water_map_corrected, col=color_map, legend=FALSE, main = "NDFI-2 Water Map Correted", cex.main = 1.0, cex.axis = 1.0, cex = 1.0)

# Export Map

writeRaster(ndfi2_water_map_corrected, "D:/ndfi2_water_map_corrected.tif", overwrite = TRUE)

# ================================================================
# AWEISH (Automated Water Extraction Index) - Feyisa et al. (2014)
# ================================================================

# Calculate Index

aweish_index <- image$blue + 0.25 * image$green - 1.5 * (image$nir + image$swir1) -0.25 * image$swir2
names(aweish_index) <- "aweish"
aweish_index
plot(aweish_index)

# Export index

writeRaster(aweish_index, "D:/aweish_index.tif", overwrite = TRUE)

# Create a matrix of values that represent the threshold for classification

class_matrix <- c(-Inf, threshold$aweish, 0, threshold$aweish, Inf, 1)
reclass_matrix <- matrix(class_matrix, ncol=3, byrow=TRUE)

# Reclassify the index using the reclass object

aweish_water_map <- classify(aweish_index, reclass_matrix)
plot(aweish_water_map, col=color_map, legend=FALSE, main = "AWEISH Water Map", cex.main = 1.0, cex.axis = 1.0, cex = 1.0)

# Export map

writeRaster(aweish_water_map, "D:/aweish_water_map.tif", overwrite = TRUE)

# Filter Noise

# Create a matrix of values that represent the classification ranges

class_matrix <- c(-Inf, filter$red_aweish, 1, filter$red_aweish, Inf, 0) # these values can be change according yo the characteristics of de area
reclass_matrix <- matrix(class_matrix, ncol=3, byrow=TRUE)

# Reclassify the raster using the reclass object

red_aweish_map <- classify(image$red, reclass_matrix)

# Correction

aweish_water_map_filtered <- aweish_water_map - red_aweish_map
aweish_water_map_filtered

# Create a matrix of values that represent the classification ranges

class_matrix <- c(-Inf, 0, 0, 0, Inf, 1)
reclass_matrix <- matrix(class_matrix, ncol=3, byrow=TRUE)

# Reclassify the raster using the reclass object

aweish_water_map_corrected <- classify(aweish_water_map_filtered, reclass_matrix)
color_map <- c("white", "blue")
plot(aweish_water_map_corrected, col=color_map, legend=FALSE, main = "AWEISH Water Map Correted", cex.main = 1.0, cex.axis = 1.0, cex = 1.0)

# Export Map

writeRaster(aweish_water_map_corrected, "D:/aweish_water_map_corrected.tif", overwrite = TRUE)

# =================================================================
# AWEINSH (Automated Water Extraction Index) - Feyisa et al. (2014)
# =================================================================

# Calculate Index

aweinsh_index <- 4 * (image$green - image$swir1) - (0.25 * image$nir + 2.75 * image$swir2)
names(aweinsh_index) <- "aweinsh"
aweinsh_index
plot(aweinsh_index)

# Export index

writeRaster(aweinsh_index, "D:/aweinsh_index.tif", overwrite = TRUE)

# Create a matrix of values that represent the threshold for classification

class_matrix <- c(-Inf, threshold$aweinsh, 0, threshold$aweinsh, Inf, 1)
reclass_matrix <- matrix(class_matrix, ncol=3, byrow=TRUE)

# Reclassify the index using the reclass object

aweinsh_water_map <- classify(aweinsh_index, reclass_matrix)
plot(aweinsh_water_map, col=color_map, legend=FALSE, main = "AWEINSH Water Map", cex.main = 1.0, cex.axis = 1.0, cex = 1.0)

# Export map

writeRaster(aweinsh_water_map, "D:/aweinsh_water_map.tif", overwrite = TRUE)

# Filter Noise

# Create a matrix of values that represent the classification ranges

class_matrix <- c(-Inf, filter$red_aweinsh, 1, filter$red_aweinsh, Inf, 0) # these values can be change according yo the characteristics of de area
reclass_matrix <- matrix(class_matrix, ncol=3, byrow=TRUE)

# Reclassify the raster using the reclass object

red_aweinsh_map <- classify(image$red, reclass_matrix)

# Correction

aweinsh_water_map_filtered <- aweinsh_water_map - red_aweinsh_map
aweinsh_water_map_filtered

# Create a matrix of values that represent the classification ranges

class_matrix <- c(-Inf, 0, 0, 0, Inf, 1)
reclass_matrix <- matrix(class_matrix, ncol=3, byrow=TRUE)

# Reclassify the raster using the reclass object

aweinsh_water_map_corrected <- classify(aweinsh_water_map_filtered, reclass_matrix)
color_map <- c("white", "blue")
plot(aweinsh_water_map_corrected, col=color_map, legend=FALSE, main = "AWEINSH Water Map Correted", cex.main = 1.0, cex.axis = 1.0, cex = 1.0)

# Export Map

writeRaster(aweinsh_water_map_corrected, "D:/aweinsh_water_map_corrected.tif", overwrite = TRUE)

# ================================================
# WI2015 (Water Index 2015) - Fisher et al. (2016)
# ================================================

# Calculate Index

wi2015_index <- 1.7204 + 171 * image$green + 3 * image$red - 70 * image$nir - 45 * image$swir1 - 71 * image$swir2
names(wi2015_index) <- "wi2015"
wi2015_index
plot(wi2015_index)

# Export index

writeRaster(wi2015_index, "D:/wi2015_index.tif", overwrite = TRUE)

# Create a matrix of values that represent the threshold for classification

class_matrix <- c(-Inf, threshold$wi2015, 0, threshold$wi2015, Inf, 1)
reclass_matrix <- matrix(class_matrix, ncol=3, byrow=TRUE)

# Reclassify the index using the reclass object

wi2015_water_map <- classify(wi2015_index, reclass_matrix)
plot(wi2015_water_map, col=color_map, legend=FALSE, main = "WI2015 Water Map", cex.main = 1.0, cex.axis = 1.0, cex = 1.0)

# Export map

writeRaster(wi2015_water_map, "D:/wi2015_water_map.tif", overwrite = TRUE)

# Filter Noise

sum567_index <- (image$nir + image$swir1 + image$swir2)

# Create a matrix of values that represent the classification ranges

class_matrix <- c(-Inf, filter$sum567_wi2015, 0, filter$sum567_wi2015, Inf, 1) # these values can be change according yo the characteristics of de area
reclass_matrix <- matrix(class_matrix, ncol=3, byrow=TRUE)

# Reclassify the raster using the reclass object

sum567_map <- classify(sum567_index, reclass_matrix)

# Correction

wi2015_water_map_filtered <- wi2015_water_map - sum567_map
wi2015_water_map_filtered

# Create a matrix of values that represent the classification ranges

class_matrix <- c(-Inf, 0, 0, 0, Inf, 1)
reclass_matrix <- matrix(class_matrix, ncol=3, byrow=TRUE)

# Reclassify the raster using the reclass object

wi2015_water_map_corrected <- classify(wi2015_water_map_filtered, reclass_matrix)
color_map <- c("white", "blue")
plot(wi2015_water_map_corrected, col=color_map, legend=FALSE, main = "WI2015 Water Map Correted", cex.main = 1.0, cex.axis = 1.0, cex = 1.0)

# Export Map

writeRaster(wi2015_water_map_corrected, "D:/wi2015_water_map_corrected.tif", overwrite = TRUE)

# ==================================================
# MBWI (Multi-Band Water Index) - Wang et al. (2018)
# ==================================================

# Calculate Index

mbwi_index <- 2 * image$green - image$red - image$nir - image$swir1 - image$swir2
names(mbwi_index) <- "mbwi"
mbwi_index
plot(mbwi_index)

# Export index

writeRaster(mbwi_index, "D:/mbwi_index.tif", overwrite = TRUE)

# Create a matrix of values that represent the threshold for classification

class_matrix <- c(-Inf, threshold$mbwi, 0, threshold$mbwi, Inf, 1)
reclass_matrix <- matrix(class_matrix, ncol=3, byrow=TRUE)

# Reclassify the index using the reclass object

mbwi_water_map <- classify(mbwi_index, reclass_matrix)
plot(mbwi_water_map, col=color_map, legend=FALSE, main = "MBWI Water Map", cex.main = 1.0, cex.axis = 1.0, cex = 1.0)

# Export map

writeRaster(mbwi_water_map, "D:/mbwi_water_map.tif", overwrite = TRUE)

# Filter Noise

# Create a matrix of values that represent the classification ranges

class_matrix <- c(-Inf, filter$red_mbwi, 1, filter$red_mbwi, Inf, 0) # these values can be change according yo the characteristics of de area
reclass_matrix <- matrix(class_matrix, ncol=3, byrow=TRUE)

# Reclassify the raster using the reclass object

red_mbwi_map <- classify(image$red, reclass_matrix)

# Correction

mbwi_water_map_filtered <- mbwi_water_map - red_mbwi_map
mbwi_water_map_filtered

# Create a matrix of values that represent the classification ranges

class_matrix <- c(-Inf, 0, 0, 0, Inf, 1)
reclass_matrix <- matrix(class_matrix, ncol=3, byrow=TRUE)

# Reclassify the raster using the reclass object

mbwi_water_map_corrected <- classify(mbwi_water_map_filtered, reclass_matrix)
color_map <- c("white", "blue")
plot(mbwi_water_map_corrected, col=color_map, legend=FALSE, main = "MBWI Water Map Correted", cex.main = 1.0, cex.axis = 1.0, cex = 1.0)

# Export Map

writeRaster(mbwi_water_map_corrected, "D:/mbwi_water_map_corrected.tif", overwrite = TRUE)

# =================================================
# WI2020 (Water Index 2020) - Mishra & Pant (2021)
# =================================================

# Calculate Index

wi2020_index <- (image$blue - image$swir2) / ((image$nir + image$swir1 + image$swir2) / 3)
names(wi2020_index) <- "wi2020"
wi2020_index
plot(wi2020_index)

# Export index

writeRaster(wi2020_index, "D:/wi2020_index.tif", overwrite = TRUE)

# Create a matrix of values that represent the threshold for classification

class_matrix <- c(-Inf, threshold$wi2020, 0, threshold$wi2020, Inf, 1)
reclass_matrix <- matrix(class_matrix, ncol=3, byrow=TRUE)

# Reclassify the index using the reclass object

wi2020_water_map <- classify(wi2020_index, reclass_matrix)
plot(wi2020_water_map, col=color_map, legend=FALSE, main = "WI2020 Water Map", cex.main = 1.0, cex.axis = 1.0, cex = 1.0)

# Export map

writeRaster(wi2020_water_map, "D:/wi2020_water_map.tif", overwrite = TRUE)

# Filter Noise

sum567_index <- (image$nir + image$swir1 + image$swir2)

# Create a matrix of values that represent the classification ranges

class_matrix <- c(-Inf, filter$sum567_wi2020, 0, filter$sum567_wi2020, Inf, 1) # these values can be change according yo the characteristics of de area
reclass_matrix <- matrix(class_matrix, ncol=3, byrow=TRUE)

# Reclassify the raster using the reclass object

sum567_map <- classify(sum567_index, reclass_matrix)

# Correction

wi2020_water_map_filtered <- wi2020_water_map - sum567_map
wi2020_water_map_filtered

# Create a matrix of values that represent the classification ranges

class_matrix <- c(-Inf, 0, 0, 0, Inf, 1)
reclass_matrix <- matrix(class_matrix, ncol=3, byrow=TRUE)

# Reclassify the raster using the reclass object

wi2020_water_map_corrected <- classify(wi2020_water_map_filtered, reclass_matrix)
color_map <- c("white", "blue")
plot(wi2020_water_map_corrected, col=color_map, legend=FALSE, main = "WI2020 Water Map Correted", cex.main = 1.0, cex.axis = 1.0, cex = 1.0)

# Export Map

writeRaster(wi2020_water_map_corrected, "D:/wi2020_water_map_corrected.tif", overwrite = TRUE)

# ============================================================
# STEP 5 - INTEGRATE WATER MAPS
# ============================================================

# Integrated Water Maps

water_frequency_map <- ndwi1_water_map_corrected + ndwi2_water_map_corrected + 
  ndwi3_water_map_corrected + mndwi_water_map_corrected +
  wri_water_map_corrected + ndfi1_water_map_corrected + 
  ndfi2_water_map_corrected + aweish_water_map_corrected +
  aweinsh_water_map_corrected + wi2015_water_map_corrected + 
  mbwi_water_map_corrected + wi2020_water_map_corrected
names(water_frequency_map) <- "water_frequency_map"
water_frequency_map

# Plot

plot(water_frequency_map, legend=TRUE, main = "Water Frenquency Map ", cex.main = 1.0, cex.axis = 1.0, cex = 1.0)

# Export

writeRaster(water_frequency_map, "D:/integrated_water_frequency_map.tif", overwrite = TRUE)

# Create a matrix of values that represent the classification ranges

class_matrix <- c(-Inf, 0, 0, 0, Inf, 1)
reclass_matrix <- matrix(class_matrix, ncol=3, byrow=TRUE)

# Reclassify the raster using the reclass object

integrated_water_map <- classify(water_frequency_map, reclass_matrix)

# Plot

color_map <- c("white", "blue")
plot(integrated_water_map, col=color_map, legend=FALSE, main = "Integrated Water Map", cex.main = 1.0, cex.axis = 1.0, cex = 1.0)

# Export Map

writeRaster(integrated_water_map, "D:/integrated_water_binary_map.tif", overwrite = TRUE)

# ============================================================
# STEP 6 - CALCULATE WATER AREA FROM THRESHOLDED WATER INDICES
# ============================================================

# Calculate area (unit in km2)

ndwi1_water_area_km2 <- global(ndwi1_water_map_corrected == 1, "sum", na.rm = TRUE)[1,1] *
  (prod(res(ndwi1_water_map_corrected)) / 1e6)

ndwi2_water_area_km2 <- global(ndwi2_water_map_corrected == 1, "sum", na.rm = TRUE)[1,1] *
  (prod(res(ndwi2_water_map_corrected)) / 1e6)

ndwi3_water_area_km2 <- global(ndwi3_water_map_corrected == 1, "sum", na.rm = TRUE)[1,1] *
  (prod(res(ndwi3_water_map_corrected)) / 1e6)

mndwi_water_area_km2 <- global(mndwi_water_map_corrected == 1, "sum", na.rm = TRUE)[1,1] *
  (prod(res(mndwi_water_map_corrected)) / 1e6)

wri_water_area_km2 <- global(wri_water_map_corrected == 1, "sum", na.rm = TRUE)[1,1] *
  (prod(res(wri_water_map_corrected)) / 1e6)

ndfi1_water_area_km2 <- global(ndfi1_water_map_corrected == 1, "sum", na.rm = TRUE)[1,1] *
  (prod(res(ndfi1_water_map_corrected)) / 1e6)

ndfi2_water_area_km2 <- global(ndfi2_water_map_corrected == 1, "sum", na.rm = TRUE)[1,1] *
  (prod(res(ndfi2_water_map_corrected)) / 1e6)

aweish_water_area_km2 <- global(aweish_water_map_corrected == 1, "sum", na.rm = TRUE)[1,1] *
  (prod(res(aweish_water_map_corrected)) / 1e6)

aweinsh_water_area_km2 <- global(aweinsh_water_map_corrected == 1, "sum", na.rm = TRUE)[1,1] *
  (prod(res(aweinsh_water_map_corrected)) / 1e6)

wi2015_water_area_km2 <- global(wi2015_water_map_corrected == 1, "sum", na.rm = TRUE)[1,1] *
  (prod(res(wi2015_water_map_corrected)) / 1e6)

mbwi_water_area_km2 <- global(mbwi_water_map_corrected == 1, "sum", na.rm = TRUE)[1,1] *
  (prod(res(mbwi_water_map_corrected)) / 1e6)

wi2020_water_area_km2 <- global(wi2020_water_map_corrected == 1, "sum", na.rm = TRUE)[1,1] *
  (prod(res(wi2020_water_map_corrected)) / 1e6)

integrated_water_map_water_area_km2 <- global(integrated_water_map == 1, "sum", na.rm = TRUE)[1,1] *
  (prod(res(integrated_water_map)) / 1e6)

# List union

list_area <- list(name = c("NDWI-1", "NDWI-2", "NDWI-3", "MNDWI", 
                           "WRI", "NDFI-1", "NDFI-2", "AWEISH", 
                           "AWEINSH", "WI2015", "MBWI", "WI2020",
                           "IWM"),
                  area = c(ndwi1_water_area_km2, ndwi2_water_area_km2, 
                           ndwi3_water_area_km2, mndwi_water_area_km2, 
                           wri_water_area_km2, ndfi1_water_area_km2, 
                           ndfi2_water_area_km2, aweish_water_area_km2, 
                           aweinsh_water_area_km2, wi2015_water_area_km2, 
                           mbwi_water_area_km2, wi2020_water_area_km2, 
                           integrated_water_map_water_area_km2))

# Dataframe

area_df <- as.data.frame(list_area)
area_df <- area_df[order(area_df$area, decreasing = TRUE),]
area_df

# ============================================================
# REFERENCES
# ============================================================

# BAZZAN, T.; RENNÓ, C.D.; RECZIEGEL, E.W.; GUASSELLI, L.A.; KORB, C.C. Flood Detection Integrating Spectral Indices (FLOODISI): A Novel Approach to Open-Water Mapping. Geosciences 2026, 16, 325. https://doi.org/10.3390/geosciences16080325

# BOSCHETTI, M.; NUTINI, F.; MANFRON, G.; BRIVIO, P.A.; NELSON, A. Comparative Analysis of Normalised Difference Spectral Indices Derived from MODIS for Detecting Surface Water in Flooded Rice Cropping Systems. PLoS ONE, 9, 2014.

# FEYISA, G.L.; MEILBY, H.; FENSHOLT, R.; PROUD, S.R. Automated Water Extraction Index: a new technique for surface water mapping using Landsat imagery. Remote Sensing of Environment, v. 140, 23-35, 2014.

# FISHER, A.; FLOOD, N.; DANAHER, T. Comparing Landsat water index methods for automated water classification in eastern Australia. Remote Sensing of Environment, v. 175. 167-182, 2016.

# McFEETERS, S.K. The use of the Normalized Difference Water Index (NDWI) in the delineation of open water features. International Journal of Remote Sensing, v. 17, 1425-1432, 1996. 

# MISHRA, V.K., PANT, T. Change analysis of water area and flood mapping using a novel water index 2020 (WI2020) for Landsat imagery, Geocarto International, 2021.

# OUMA, Y.O.; TATEISHI, R. A Water Index for Rapid Mapping of Shoreline Changes of Five East African Rift Valley Lakes: An Empirical Analysis Using Landsat TM and ETM+ Data. Int. J. Remote Sens. 27, 3153–3181, 2006.

# ROGERS, A.S.; KEARNEY, M.S. Reducing Signature Variability in Unmixing Coastal Marsh Thematic Mapper Scenes Using Spectral Indices. Int. J. Remote Sens., 25, 2317–2335, 2004.

# WANG, X.; XIE, S.; ZHANG, X.; CHEN, C.; GUO, H.; DU, J.; DUAN, Z. A robust Multi-Band Water Index (MBWI) for automated extraction of surface water from Landsat 8 OLI imagery. International Journal of Applied Earth Observation and Geoinformation, v. 68, 73-91, 2018.
