testthat::test_that("Test bam file length",{

  bamfile <- system.file("extdata", "ex1.bam", package="Rsamtools",
                         mustWork=TRUE)

  testthat::expect_equal(bam_length(bamfile),3307)

})
