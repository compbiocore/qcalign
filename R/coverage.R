#' coverage rate: mean, median and sd
#'
#' @param bamfile the path to the bam file
#' @return coverage rate mean, median and sd matrix
#' @importFrom IRanges IRanges
#' @importFrom GenomicRanges GRanges coverage
#' @importFrom Rsamtools ScanBamParam scanBam



cover_age <- function(bamfile){


  p_cover <- ScanBamParam(what=scanBamWhat(),flag=scanBamFlag(isUnmappedQuery = FALSE))
  bam = scanBam(bamfile, param=p_cover)[[1]]


  i_ranges <- IRanges(start=bam$pos, width=bam$qwidth, names=make.names(bam$qname, unique=TRUE))
  g_ranges <- GRanges(seqnames=Rle(bam$rname), ranges=I_ranges, strand=Rle(bam$strand), flag=bam$flag, readid=bam$rname)

  coverage <- rbind(mean(GenomicRanges::coverage(g_ranges)),median(GenomicRanges::coverage(g_ranges)),sd(GenomicRanges::coverage(g_ranges)))
  rownames(coverage) <- c("mean","median","sd")

  return(coverage)


}
