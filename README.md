# tcSVD: a tensor SVD built on the cosine transform

MATLAB (and some Python) code for **tc-SVD**, a singular value decomposition for third-order tensors built on a cosine-transform tensor product. The repository also has the classic FFT-based **t-SVD** and the classification, clustering and incremental-update methods from my M.Sc. thesis, *Big Data Learning with Tensor Representation*. I wrote the thesis at Tarbiat Modares University (2019), supervised by Dr. Mansoor Rezghi.

Explanations in plain language:
- [Tensor Notes](https://mahdimolavi.ir/tensor-decompose/7-Big-Data-Learning-with-Tensor-Representation.html) (English)
- [یادداشت‌های تانسوری](https://mahdimolavi.ir/fa-notes/) (Persian)

## The idea

t-SVD (Kilmer and Martin, 2011) multiplies tensors through block-circulant matrices. That assumes the third dimension wraps around, which is a periodic boundary. An FFT along mode 3 makes the product cheap, but the arithmetic is complex-valued.

tc-SVD replaces the periodic boundary with a reflective (mirror) one:
1. The structured matrix becomes Toeplitz-plus-Hankel.
2. A DCT along mode 3 block-diagonalizes it.
3. Every computation stays in real numbers.

Once transformed, each frontal slice gets an ordinary matrix SVD, and the factors are transformed back. A closely related cosine-transform product appears in Kernfeld, Kilmer and Aeron (2015).

## What is in the repository

| File or folder | What it does |
|---|---|
| `tcProdact.m`, `LProdact.m` | tc-product of two third-order tensors (DCT along mode 3) |
| `tcSVD.m` | tc-SVD; `tcSVD(A)` for the full decomposition, `tcSVD(A, k)` for rank k per slice |
| `tcTranspose.m`, `inversetcSVD.m` | transpose and reconstruction under the tc-product |
| `tProdact.m`, `tSVD.m`, `tTranspose.m`, `tQR.m`, `inversetSVD.m` | FFT-based t-product, t-SVD, t-transpose and t-QR, for comparison |
| `incrementalSVD.m`, `incrementalTSVD.m` | incremental (streaming) updates, generalizing Brand's incremental SVD |
| `classficistrategy.m` | classification with a truncated t-SVD or tc-SVD basis |
| `clusterstrategy.m` | clustering on the truncated V factor, including two-sided truncation; scored with NMI, accuracy and the Rand index |
| `HOSVD.m` | HOSVD baseline |
| `L_svd/`, `LSVD/` | Python versions of transform-based products and SVDs (FFT, DCT, DWT), with small tests and a video compression example |
| `kmeans/` | k-means helper by Mo Chen (see the header of each file) |
| `ClusteringMeasure/` | helper scripts for clustering metrics (NMI, accuracy, Rand index, Hungarian matching) |

## Requirements

- MATLAB with the [Tensor Toolbox for MATLAB](https://www.tensortoolbox.org/). Several files use `tensor` and `ttm` from it.
- NumPy and SciPy for the Python folders.

## Quick start (MATLAB)

```matlab
A = rand(32, 50, 32);                         % for example 50 images of 32x32, one lateral slice each
[U, S, V] = tcSVD(A, 10);                     % rank-10 tc-SVD
Ak = tcProdact(U, tcProdact(S, tcTranspose(V)));
relative_error = norm(A(:) - Ak(:)) / norm(A(:))
```

## Results reported in the thesis

**Classification (MNIST, CBCL faces):** accuracy on par with t-SVD, in about half the run time.

**Clustering, best NMI:**

| Data set | Best method | NMI |
|---|---|---|
| ORL | two-sided tc-SVD | 0.730 |
| Extended Yale B | two-sided tc-SVD | 0.799 |
| COIL-100 | HOSVD, then NMF (both ahead of t-SVD and tc-SVD) | — |

tc-SVD ran faster than t-SVD on every data set.

**Alzheimer's disease against early MCI** (ADNI resting-state fMRI, 72 subjects, leave-one-out): 86.5% accuracy for tc-SVD against 70.7% for t-SVD. It is a small sample, so treat this as a research result, not a diagnostic tool.

## Citation

If this code helps your work, please cite the thesis:

> Mahdi Molavi. *Big Data Learning with Tensor Representation*. M.Sc. thesis, Tarbiat Modares University, 2019. Supervisor: Mansoor Rezghi.

GitHub also shows a "Cite this repository" button from `CITATION.cff`.

## Contributing

Issues and pull requests are welcome.

## License

The code I wrote is released under the MIT License (see `LICENSE`). The helper folders `kmeans/` and `ClusteringMeasure/` come from other authors and keep their original terms.

## Author

Mahdi Molavi · [mahdimolavi.ir](https://mahdimolavi.ir/) · [LinkedIn](https://www.linkedin.com/in/mahdimolavi/) · [Work with me](https://mahdimolavi.ir/services.html)
