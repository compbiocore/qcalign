#' Identifies reads that have been mapped to two distinct portions of the genome, here
#' defined as different chromosomes or sequence segments. It
#' returns the proportion of sequencing reads that are chimeric.
#' 
#' It checks for two different things:
#' 1. If the SA tag exists. This tag only exists for SAM/BAM files produced by bwa-mem.
#' 2. If the rname of two reads with the same qname is different. This generally indicates that the reads
#' have been aligned to two different portions of the genome.
#' 
#' The proportion returned will be the proportion of reads with any of the features above. The user also has
#' the option to only check for 1 of the 2.
#' 
#' NOTE that the absence of either of the 2 features above does NOT mean that your alignment does not have
#' chimeras, especially if you are using older versions of reference aligners. This is merely a
#' heuristic diagnostic using convenient metrics to assess overall quality of your alignment.
#' 
#' Planned improvements:
#' Also check for if the 0x800 flag exists, indicating a supplementary and thus chimeric alignment.
#' This flag only exists in version 1.5 of the SAM and BAM formats and beyond.
#' 
#' @param bamfile the path to the BAM file
#' @param checks 1 indicates checking only for SA tag, 2 only for rname, and 3 for both. Default is both.
#' @export
#' @importFrom Rsamtools ScanBamParam scanBam 
#' @export
chimeric_reads <- function(bamfile, checks=3) {
  if(checks==1) {
    chimeric_tags(bamfile)
  }
  else if(checks==2) {
    chimeric_rname(bamfile)
  }
  else if(checks==3) {
    chimeric_tags(bamfile)
    chimeric_rname(bamfile)
  }
  else {
    stop("Checks must be 1, 2, or 3 as described in docs for chimeric_reads.")
  }
}

#' Identifies reads with the SA tag, indicating a chimeric read as defined by bwa-mem.
#' 
#' @param bamfile the path to the BAM file
chimeric_tags <- function(bamfile) {
  tag <- ScanBamParam(tag=c("SA"))
  bam <- scanBam(bamfile, param=tag)
}

#' Identifies reads with with the same qname but different rname. This indicates a chimeric read alignment.
chimeric_rname <- function(bamfile) {
  names <- ScanBamParam(what=c("rname","qname"))
  nameBam <- scanBam(bamfile, param=names)
  find_rname(nameBam[[1]]$qname, nameBam[[1]]$rname)
}

#' Counts 
count_rname <- function(qnames, rnames) {
  dup<-which(duplicated(qnames))
  ind<-lapply(dup, function(x) which(qnames==x))
  ind_rnames<-lapply(ind, function(x) anyDuplicated(rnames[x]))
  sum(ind_rnames==0)*2/length(qnames)
}