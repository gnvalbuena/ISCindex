# **ISCindex**

***An R package to calculate an intestinal stem cell index from gene expression profiling data***

The **ISCindex** R package provides a function to calculate an intestinal stem cell index describing stem cell phenotype along a continuum from a more conventional Crypt Base Columnar stem cell (CBC) to a Regenerative Stem Cell (RSC) phenotype. 

## Installation

The package can be installed in R by entering the following commands:

```r
if (!requireNamespace("devtools", quietly = TRUE))
    install.packages("devtools")
devtools::install_github("gnvalbuena/ISCindex")
```

## Usage

To calculate the stem cell index, use

```r
stemcellindex(geneexpressiondata, organism, geneid)
```
where
 * `geneexpressiondata` is a table of gene expression data (microarray or RNAseq), with genes in rows and samples in columns
 * `organism` is either `"mouse"` or `"human"`
 * `geneid` is the type of gene identifiers in the rownames of `geneexpreessiondata`, either `"ensembl"` or `"genename"`

The function will return a data frame containing
 * `RSC` - single sample Regenerative Stem Cell scores
 * `CBC` - single sample Crypt Base Columnar Stem Cell scores
 * `stemcellindex` - stem cell index

Access the manual for the `stemcellindex` function by entering `?stemcellindex`


