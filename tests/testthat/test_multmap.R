testthat::test_that("Test multiple mapping",{

  bamfile <- system.file("extdata", "ex1.bam", package="Rsamtools",
                         mustWork=TRUE)

  testthat::expect_equal(mult_map(bamfile,30,'count'),67)
  testthat::expect_equal(mult_map(bamfile,30,'rate'),0.02026005)
})
