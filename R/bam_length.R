#' Returns the number of positions in the BAM file alignment.
#' @param bamfile path to the BAM file
#' @export
#' @importFrom Rsamtools ScanBamParam scanBam


bam_length <- function(bamfile){
  p_total <- ScanBamParam(what=scanBamWhat(),flag=scanBamFlag())
  bam_total <- scanBam(bamfile, param=p_total)[[1]]
  return(length(bam_total$qname))
}
