[![Build Status](https://travis-ci.org/compbiocore/qckitalign.svg?branch=master)](https://travis-ci.org/compbiocore/qckitalign)

# qckitalign

QCKitalign, part of the QCKit suite by the Computational Biology Core at Brown, is a quality control package in R for reference genome read mapping alignment statistics in the SAM/BAM file format. SAM/BAM files are the de facto standard file format for storing NGS reads aligned to reference genomes. You can read more about them [here](http://samtools.github.io/hts-specs/SAMv1.pdf). This package provides the following metrics:

1. Chimeric reads, i.e. the proportion of sequencing reads that align to two distinct portions of the genome with less than x (by default 0) base pairs overlap.

# Installation

`qckitalign` has a lot of dependencies on Bioconductor packages. The commands to install them are below, and need to be run once before in order to properly install and run `qckitalign`.

```
source("https://bioconductor.org/biocLite.R")
biocLite("Rsamtools")
biocLite("GenomicRanges")
biocLite("IRanges")
```

Currently, qckitalign can be installed with `devtools` by running:

```
devtools::install_github("compbiocore/qckitalign",build_vignettes=TRUE)
library(qckitalign)
```

# Future Improvements

 * Use `RSeqAn` to include searching for the `0x800` flag in BAM files.
 * Read a BAM file with `RSeqAn` instead of `RSamtools` and evaluate performance through `rbenchmark`.