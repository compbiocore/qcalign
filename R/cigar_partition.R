#' cigar partitioning
#' @param bamfile the path to the BAM file
#' @export
#' @importFrom Rsamtools quickBamFlagSummary


cigar_partition <- function(bamfile){
  return(quickBamFlagSummary(bamFile,main.groups.only = TRUE))
}
