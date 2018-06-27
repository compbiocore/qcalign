#' Identifies reads by index record that have been mapped to two distinct portions of the genome, here
#' defined as different chromosomes or sequence segments.
#' 
#' It checks for two different things:
#' 1. If the SA tag exists. This tag only exists for SAM/BAM files produced by bwa-mem.
#' 2. If the rname of two reads with the same qname is different. This generally indicates that the reads
#' have been aligned to two different portions of the genome.
#' 
#' The indices returned will be those with any of the features above. The user also has
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
#' @return Indices of chimeric records. If there aren't
#' @examples 
#' no_tags_no_rname <- system.file("extdata","ex1.bam",package="Rsamtools")
#' chimeric_reads(no_tags_no_rname,checks=1)
#' chimeric_reads(no_tags_no_rname)
#' @export
#' @importFrom Rsamtools ScanBamParam scanBam 
chimeric_reads <- function(bamfile, checks=3) {
  if(checks==1) {
    chimeric_tags(bamfile)
  }
  else if(checks==2) {
    which_rname<-chimeric_rname(bamfile)
    do.call(c,which_rname)
  }
  else if(checks==3) {
    which_tags<-chimeric_tags(bamfile)
    which_rname<-chimeric_rname(bamfile)
    unique(c(which_tags,do.call(c,which_rname)))
  }
  else {
    stop("Checks must be 1, 2, or 3 as described in docs for chimeric_reads.")
  }
}

#' Identifies reads with the SA tag, indicating a chimeric read as defined by bwa-mem.
#' 
#' @param bamfile the path to the BAM file
#' @export
chimeric_tags <- function(bamfile) {
  tag <- ScanBamParam(what=c("qname"),tag=c("SA"))
  bam <- scanBam(bamfile, param=tag)
  # if no tags will apply is.na to NULL giving warning
  which_tags <- suppressWarnings(which(!is.na(bam[[1]]$tag$SA)))
  
  if(sum(which_tags)==0) { return(NULL) }
  else { return(which_tags) }
}

#' Identifies reads with the same qname but different rname from a bamfile.
#' 
#' @param bamfile the path to the BAM file
#' @return list of index record pairs that have the same qname but different rname
#' @export
chimeric_rname <- function(bamfile) {
  names <- ScanBamParam(what=c("rname","qname"))
  nameBam <- scanBam(bamfile, param=names)
  qnames <- nameBam[[1]]$qname
  rnames <- nameBam[[1]]$rname
  dup <- qnames[which(duplicated(qnames))]
  ind <- lapply(dup, function(x) which(qnames==x))
  ind_rnames<-lapply(ind, function(x) anyDuplicated(rnames[x]))
  ind[ind_rnames==0]
}

#' Return number of chimeric reads from a bamfile.
#' 
#' @param bamfile the path to the BAM file
#' @param checks 1, 2, or 3.
num_chimeric <- function(bamfile, checks=3) {
  chimeric <- chimeric_reads(bamfile,checks)
  length(chimeric)/2 # should be an even number...
}

#' Returns proportion of reads that have been mapped to two distinct portions of the genome, here
#' defined as different chromosomes or sequence segments.
#' 
#' How chimeric reads are identified is described in `chimeric_reads`. The indices returned will be
#' the proportion of reads with any of the features above. The user also has
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
chimeric_proportion <- function(bamfile, checks=3) {
  return(num_chimeric(bamfile,checks)/bam_reads(bamfile,checks))
}