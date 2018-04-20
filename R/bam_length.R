#' length of entire bam file
#' @param bamfile the path to the BAM file
#' @export
#' @importFrom Rsamtools ScanBamParam scanBam


bam_length <- function(bamfile){
  p_total <- ScanBamParam(what=scanBamWhat(),flag=scanBamFlag())
  bam_total <- scanBam(bamfile, param=p_total)[[1]]
  return(length(bam_total$qname))
}
