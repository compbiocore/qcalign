#' return name of unmapped reads
#'
#' @param bamfile the path to the bam file
#' @param option  'count' or 'rate' gives either count of unmapped reads or the rate of unmapped reads
#' @importFrom Rsamtools ScanBamParam scanBam


unmapped_reads <- function(bamfile,option){

  p2 <- Rsamtools::ScanBamParam(what=scanBamWhat(),flag=scanBamFlag(isUnmappedQuery = TRUE))
  unmap = Rsamtools::scanBam(bamfile, param=p2)[[1]]$qname
  if (option == "rate") return(length(unmap)/bam_length(bamfile))
  if (option == "count") return(length(unmap))

}
