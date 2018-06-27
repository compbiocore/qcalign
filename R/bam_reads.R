#' Returns the number of alignment records in the BAM file alignment.
#' 
#' @param bamfile path to the BAM file
#' @export
#' @importFrom Rsamtools ScanBamParam scanBam scanBamWhat scanBamFlag
bam_records <- function(bamfile){
  p_total <- ScanBamParam(what=scanBamWhat(),flag=scanBamFlag())
  bam_total <- scanBam(bamfile, param=p_total)[[1]]
  return(length(bam_total$qname))
}

#' Returns the number of distinct reads in the BAM file alignment. This may be different from
#' `bam_length`, in particular if there are chimeric alignments, as those will present as multiple records
#' despite being a single read alignment. Read pairs are counted as 2 distinct reads.
#' 
#' How chimeric reads are defined is described in `chimeric_reads`.
#' 
#' Planned improvements: Because Rsamtools does not have the capability for the 0x800 flag, implement
#' as a function based on the RSeqAn library instead for easier flagging of chimeric reads.
#' 
#' @param bamfile path to the BAM file
#' @param checks 1 indicates checking only for SA tag, 2 only for rname, and 3 for both. Default is both.
#' @export
bam_reads <- function(bamfile,checks=3){
  return(bam_records(bamfile)-num_chimeric(bamfile,checks=3))
}