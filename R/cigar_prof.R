#' cigar profile
#'
#' @param bamfile path to bam file


cigar_prof <- function(bamfile){

  p_cig <- ScanBamParam(what=scanBamWhat(),flag=scanBamFlag(isUnmappedQuery = FALSE))
  cig = scanBam(bamfile, param=p_cig)[[1]]$cigar
  return(cig)

}
