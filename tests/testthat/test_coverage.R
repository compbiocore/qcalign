testthat::test_that("Test bam file length",{

  bamfile <- system.file("extdata", "ex1.bam", package="Rsamtools",
                         mustWork=TRUE)

  testthat::expect_equal(round(as.numeric(cover_age(bamfile)[1,]),5),c(33.25749,40.27122))

})
