#' unique mapping
#'
#' @param bamfile the path to bam file
#' @param quality set default to 30
#' @param option either count or rate
#' @importFrom Rsamtools ScanBamParam scanBam
#' @export


unq_map <- function(bamfile,quality=30,option){

  p_um <- ScanBamParam(what=scanBamWhat(),flag=scanBamFlag(isUnmappedQuery = FALSE))
  uniq_map_r = scanBam(bamfile, param=p_um)[[1]]

  uniq_map  <- lapply(uniq_map_r, function(x)x[uniq_map_r$mapq>quality])

  if (option == "count") return(length(uniq_map$qname))
  if (option == "rate") return(length(uniq_map$qname)/bam_length(bamfile))
}
