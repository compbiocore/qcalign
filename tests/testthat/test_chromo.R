testthat::test_that("Test chromosome",{

  bamfile <- system.file("extdata", "ex1.bam", package="Rsamtools",
                         mustWork=TRUE)

  testthat::expect_equal(as.numeric(chromosome(bamfile,'count')[1]),1501)
  testthat::expect_equal(round(as.numeric(chromosome(bamfile,'rate')[1]),3),0.454)
})
