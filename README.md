# BarcodeDenoiser
Statistical denoising of barcode data.

<figure>
    <img src = 'identity-paradox.jpg' width = '750'>
    <figcaption>
    When there is no way to tell which barcodes are real ...
    </figcaption>
</figure>
<br></br>
This package offers a way to statistically measure and remove noise from sequencing data of fixed-length barcodes.

## Contents
1. [Theory](notebooks/theory.ipynb) - The mathematics of diversity framed in a set theoeretic perspective.
2. [Algorithm](notebooks/algorithm.pdf) - Indexing barcode diversity by decomposition.
3. [Implementation](src/BarcodeDenoiser.jl) - Written in Julia.