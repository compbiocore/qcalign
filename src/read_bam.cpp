// [[Rcpp::depends(RSeqAn)]]

#include <Rcpp.h>
#include <seqan/bam_io.h>
using namespace Rcpp;
using namespace seqan;

// [[Rcpp::plugins(cpp14)]]

//' Read in a BAM or SAM file. For a BAM file package will need to be
//' linked against zlib.
//' 
//' @param fileName path to SAM or BAM file
//' @return 
//' @export
// [[Rcpp::export]]
int read_bam_or_sam(std::string bamFileName) {
  // Open input file, BamFileIn can read SAM and BAM files.
  BamFileIn bamFileIn(toCString(bamFileName));
  
  // Open output file, BamFileOut accepts also an ostream and a format tag.
  BamFileOut bamFileOut(context(bamFileIn), std::cout, Sam());
  
  // Copy header.
  BamHeader header;
  readHeader(header, bamFileIn);
  writeHeader(bamFileOut, header);
  
  // Copy records.
  BamAlignmentRecord record;
  while (!atEnd(bamFileIn))
  {
    readRecord(record, bamFileIn);
    writeRecord(bamFileOut, record);
  }
  
  return 0;
}


// You can include R code blocks in C++ files processed with sourceCpp
// (useful for testing and development). The R code will be automatically 
// run after the compilation.
//

/*** R
read_bam_or_sam()
*/
