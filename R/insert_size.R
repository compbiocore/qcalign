#'Insert size
#'
#'@param bamfile that path to bam file
#'

insert_size <- function(bamfile){
  p_ins <- ScanBamParam(what=scanBamWhat(),flag=scanBamFlag(isPaired = TRUE,isProperPair = TRUE))
  in_size = scanBam(bamfile, param=p_ins)[[1]]$isize
  return(in_size)
}
