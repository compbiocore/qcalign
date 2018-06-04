testthat::test_that("Test multiple mapping",{
  
  bamfile <- system.file("extdata", "ex1.bam", package="Rsamtools",
                         mustWork=TRUE)
  
  testthat::expect_equal(unq_map(bamfile,30,'count'),3204)
  testthat::expect_equal(round(unq_map(bamfile,30,'rate'),7),0.9688539)
})
