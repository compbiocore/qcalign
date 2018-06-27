context("Testing bam record and read lengths")
no_tags_no_rname <- system.file("extdata", "ex1.bam", package="Rsamtools")

testthat::test_that("Test bam_records",{

  bamfile <- system.file("extdata", "ex1.bam", package="Rsamtools",
                         mustWork=TRUE)

  testthat::expect_equal(bam_records(bamfile),3307)

})

testthat::test_that("Test bam_reads",{
  testthat::expect_equal(bam_reads(no_tags_no_rname),3307)
  
})