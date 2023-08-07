# BarcodeDenoiser
Statistical denoising of barcode data.

<figure>
    <img src = 'identity-paradox.jpg' width = '750'>
    <figcaption>
    <b>'Double Identity' - Episode 19b of Spider-Man 1969</b>
    <i>When there is no way to tell which barcodes are real ...</i>
    </figcaption>
</figure>
<br></br>
This package offers a way to statistically measure and remove noise from sequencing data of fixed-length barcodes.

## Contents
1. [Theory](notebooks/theory.ipynb) - A set theoretic perspective on barcode diversity.
2. [Algorithm](notebooks/algorithm.pdf) - Indexing barcode diversity by decomposition.
3. [BarcodeDenoiser.jl](src/BarcodeDenoiser.jl) - Implemented in Julia.