#' If the BAM file contains an SA tag (from bwa-mem), will return the proportion of sequencing reads
#' that align to two distinct portions of the genome with less than x (by default 0) base pairs overlap.
#' If the BAM file does not contain an SA tag, will throw an exception.
#' @param bamfile the path to the BAM file
#' @export
#' @importFrom Rsamtools ScanBamParam scanBam 
#' @export
chimeric_reads <- function(bamfile) {
  
}