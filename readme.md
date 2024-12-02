# tcSVD: A Novel Tensor Decomposition Approach

This repository introduces **tcSVD**, a new method for tensor decomposition.

## Overview

**tcSVD** offers an innovative approach to tensor decomposition, aiming to enhance data analysis and dimensionality reduction in multi-dimensional datasets.

## Features

- **Tensor Decomposition Methods**: Implements various tensor decomposition techniques, including:
  - **tSVD**: Traditional tensor Singular Value Decomposition.
  - **LSVD**: A variant of SVD tailored for specific applications.
  - **HOSVD**: Higher-Order Singular Value Decomposition.

- **Clustering and Classification**: Provides methods for clustering and classification, facilitating data analysis tasks.

## Repository Structure

- **ClusteringMeasure/**: Contains functions to evaluate clustering performance.
- **LSVD/**: Includes implementations related to the LSVD method.
- **L_svd/**: Houses code pertinent to the L_svd approach.
- **kmeans/**: Implements the k-means clustering algorithm.
- **HOSVD.m**: Script for Higher-Order Singular Value Decomposition.
- **LProdact.m**: Function for specific tensor product operations.
- **LSVD.m**: Script for the LSVD method.
- **README.md**: This document.
- **RandIndex.m**: Computes the Rand Index for clustering evaluation.
- **classficistrategy.m**: Defines strategies for classification tasks.
- **clusterstrategy.m**: Outlines strategies for clustering processes.
- **factorpairs.m**: Manages factor pair operations in decompositions.
- **incrementalSVD.m**: Implements incremental SVD updates.
- **incrementalTSVD.m**: Handles incremental tensor SVD.
- **inversetSVD.m**: Computes the inverse of tSVD.
- **inversetcSVD.m**: Calculates the inverse of tcSVD.
- **meanImage.m**: Processes mean image computations.
- **struct2csv.m**: Converts structures to CSV format.
- **tProdact.m**: Performs tensor product operations.
- **tQR.m**: Executes tensor QR decomposition.
- **tSVD.m**: Main script for tensor SVD.
- **tTranspose.m**: Computes tensor transposition.
- **tcProdact.m**: Handles tcSVD-specific product operations.
- **tcSVD.m**: Core script for the tcSVD method.
- **tcTranspose.m**: Manages transposition in tcSVD.
- **test-tensor.m**: Contains test cases for tensor operations.

## Getting Started

1. **Clone the Repository**:

   ```bash
   git clone https://github.com/mahdipc/tcSVD.git
   ```

2. **Navigate to the Directory**:

   ```bash
   cd tcSVD
   ```

3. **Explore the Code**: Review the scripts and functions to understand the implementations.

## Future Work

Plans include integrating advanced classification and clustering methods to enhance the utility of tcSVD in various data analysis scenarios.

## Contributions

Contributions are welcome. Feel free to fork the repository, make improvements, and submit pull requests.

## License

This project is licensed under the MIT License. 
