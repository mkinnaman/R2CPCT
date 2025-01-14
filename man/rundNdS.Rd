% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/analysisWGS_rundNdS.R
\name{rundNdS}
\alias{rundNdS}
\title{Perform dN/dS analysis on a set of mutations from multiple CPCT-02 samples.}
\usage{
rundNdS(dataMuts)
}
\arguments{
\item{dataMuts}{(VRanges): VRanges containing the mutations which will be inputted into dN/dS.}
}
\value{
(tibble) Returns a tibble of the dNdS results.
}
\description{
Perform dN/dS analysis on a set of mutations from multiple CPCT-02 samples.
}
\details{
The dNdS database was made from ENSEMBL v104 (GENCODE v38) using the following code and following the dN/dS buildref vignette:

 # Remove non-standard chromosomes, clone-based genes and CDS which cannot be divided by 3.
 ENSEMBLv104 <- readr::read_tsv('~/test/mart_export.txt') %>%
  dplyr::filter(!grepl('_', `Chromosome/scaffold name`)) %>%
  dplyr::filter(`CDS Length` %% 3 == 0) %>%
  dplyr::filter(!is.na(`Genomic coding start`)) %>%
  dplyr::filter(!grepl('^AC[0-9]', `Gene name`)) %>%
  dplyr::filter(!grepl('^AP00|^RP11-', `Gene name`)) %>%
  dplyr::filter(!grepl('\\.', `Gene name`)) %>%
  dplyr::select(
      'gene.id' = `Gene stable ID`,
       'gene.name' = `Gene name`,
       'cds.id' = `Protein stable ID`,
       'chr' = `Chromosome/scaffold name`,
       'chr.coding.start' = `Genomic coding start`,
       'chr.coding.end' = `Genomic coding end`,
       'cds.start' = `CDS start`,
       'cds.end' = `CDS end`,
       'length' = `CDS Length`,
       'strand' = Strand)
 
write.table(ENSEMBLv104, file = '~/test/mart_export_filtered.txt', sep = '\t', row.names = FALSE, quote = FALSE)

# Generate refCDS database.
pathCDS = '~/test/mart_export_filtered.txt'
pathFasta = '/mnt/onco0002/repository/general/genomes/hsapiens/hg19_HMF/Homo_sapiens.GRCh37.GATK.illumina.fasta'
dndscv::buildref(cdsfile = pathCDS, genomefile = pathFasta, outfile = 'inst/extdata/refCDS_ENSEMBLv104_HMF.rda', excludechrs='MT', useids = TRUE)
}
\examples{
\donttest{

 data.Cohort <- R2CPCT::importWGSOfCohort(<cpctIds>, <combinedData>)
 rundNdS(data.Cohort$somaticVariants)

}
}
