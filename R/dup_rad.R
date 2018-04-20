dup_rate <- function(bamfile){

  # not a working example
  gtf <- "genes.gtf"
  stranded <- 2
  paired <- FALSE
  threads <- 4
  bamDuprm <- markDuplicates(dupremover="bamutil",bamfile,
                             path="/opt/bamUtil-master/bin",rminput=FALSE)
  dm <- analyzeDuprates(bamDuprm,gtf,stranded,paired,threads)
  return(dm)
}
