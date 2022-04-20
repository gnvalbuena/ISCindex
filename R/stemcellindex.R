#' Calculate the Intestinal Stem Cell Index
#'
#' This function calculates the Intestinal Stem Cell Index and single-sample
#' Regenerative Stem Cell (RSC) and Crypt Base Columnar (CBC) Stem Cell scores.
#'
#' @param gextable Table of gene expression data, with genes in rows and samples in columns.
#' @param organism Organism of source data, either "mouse" or "human"
#' @param geneid Type of gene ID in row names, either "ensembl" for Ensembl Gene IDs or "genename" for Gene Names
#' @param parallel.cores Number of processors to use when doing the calculations in parallel. Will load the *parallel* library if `parallel.cores` is > 1. Default value is 1.
#' @return A data frame containing RSC scores, CBC scores, and Stem Cell Index
#'
#' @export
stemcellindex <- function(gextable, organism, geneid, kcdf = "Gaussian", parallel.cores = 1){

  if(organism == "mouse"){
      if(geneid == "ensembl"){
        genelist.sci <- list(RSC = unique(RSCgenetable$ensembl_gene_id[RSCgenetable$ensembl_gene_id != ""]),
                             CBC = unique(CBCgenetable$ensembl_gene_id[CBCgenetable$ensembl_gene_id != ""]))
      } else if(geneid == "genename"){
        genelist.sci <- list(RSC = unique(RSCgenetable$external_gene_name[RSCgenetable$external_gene_name != ""]),
                             CBC = unique(CBCgenetable$external_gene_name[CBCgenetable$external_gene_name != ""]))
      }
  } else if(organism == "human"){
      if(geneid == "ensembl"){
        genelist.sci <- list(RSC = unique(RSCgenetable$hsapiens_homolog_ensembl_gene[RSCgenetable$hsapiens_homolog_ensembl_gene != ""]),
                             CBC = unique(CBCgenetable$hsapiens_homolog_ensembl_gene[CBCgenetable$hsapiens_homolog_ensembl_gene != ""]))
      } else if(geneid == "genename"){
        genelist.sci <- list(RSC = unique(RSCgenetable$hsapiens_homolog_associated_gene_name[RSCgenetable$hsapiens_homolog_associated_gene_name != ""]),
                             CBC = unique(CBCgenetable$hsapiens_homolog_associated_gene_name[CBCgenetable$hsapiens_homolog_associated_gene_name != ""]))
      }
  }

  if(parallel.cores > 1){library(parallel)}

  scorestable <- as.data.frame(t(GSVA::gsva(as.matrix(gextable), genelist.sci, kcdf = kcdf, mx.diff=TRUE, verbose=FALSE, parallel.sz=parallel.cores)))

  scorestable$stemcellindex <- scorestable$RSC - scorestable$CBC

  return(scorestable)

}
