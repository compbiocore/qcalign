testthat::test_that("Test unmapped reads",{

  bamfile <- system.file("extdata", "ex1.bam", package="Rsamtools",
                    mustWork=TRUE)

  testthat::expect_equal(unmapped_reads(bamfile,'count'),36)
  testthat::expect_equal(unmapped_reads(bamfile,'rate'),0.010886)
})
