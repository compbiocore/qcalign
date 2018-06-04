#' chromosome
#'
#' @param bamfile path to bam file
#' @param option either count, rate or length enter as string
#' @importFrom Rsamtools ScanBamParam scanBam BamFile
#' @export
#'


chromosome <- function(bamfile,option){

  p_chrom <- ScanBamParam(what=c("rname","pos"))
  chromosome = scanBam(bamfile, param=p_chrom)[[1]]
  chrome_seq <- seqinfo(BamFile(bamfile))
  if (option == "rate") return(table(chromosome$rname)/bam_length(bamfile))
  if (option == "count") return(table(chromosome$rname))
  if (option == "length") return(chrome_seq)



}
