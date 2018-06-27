context("Tests for chimeric reads.")
no_tags_no_rname <- system.file("extdata","ex1.bam",package="Rsamtools")
has_tags_no_rname <- system.file("extdata","sa.bam",package="qckitalign")
has_tags_has_rname <- system.file("extdata","tags_rname.bam",package="qckitalign")
no_tags_has_rname <- system.file("extdata","rname.bam",package="qckitalign")

testthat::test_that("Test chimeric_reads with option 1",{
  testthat::expect_equal(chimeric_reads(no_tags_no_rname,checks=1),NULL)
  testthat::expect_equal(length(chimeric_reads(has_tags_no_rname,checks=1)),2)
  testthat::expect_equal(length(chimeric_reads(has_tags_has_rname,checks=1)),2)
  testthat::expect_equal(chimeric_reads(no_tags_has_rname,checks=1),NULL)
})

testthat::test_that("Test chimeric_reads with option 2",{
  testthat::expect_equal(chimeric_reads(no_tags_no_rname,checks=2),NULL)
  testthat::expect_equal(chimeric_reads(has_tags_no_rname,checks=2),NULL)
  testthat::expect_equal(length(chimeric_reads(has_tags_has_rname,checks=2)),4)
  testthat::expect_equal(length(chimeric_reads(no_tags_has_rname,checks=2)),4)
})

testthat::test_that("Test chimeric_reads with option 3/default",{
  testthat::expect_equal(chimeric_reads(no_tags_no_rname,checks=3),NULL)
  testthat::expect_equal(chimeric_reads(has_tags_no_rname),c(3,5))
  testthat::expect_equal(length(chimeric_reads(has_tags_has_rname,checks=3)),4)
  testthat::expect_equal(length(chimeric_reads(no_tags_has_rname)),4)
})

testthat::test_that("Test chimeric_reads with option > 3",{
  has_tags_no_rname <- system.file("extdata","sa.bam",package="qckitalign")
  testthat::expect_error(chimeric_reads(has_tags_no_rname,checks=5))
})

testthat::test_that("Test chimeric_tags", {
  testthat::expect_equal(chimeric_tags(no_tags_no_rname),NULL)
  testthat::expect_equal(length(chimeric_tags(has_tags_no_rname)),2)
  testthat::expect_equal(length(chimeric_tags(has_tags_has_rname)),2)
  testthat::expect_equal(chimeric_tags(no_tags_has_rname),NULL)
})

testthat::test_that("Test chimeric_rname", {
  testthat::expect_equal(chimeric_rname(no_tags_no_rname),list())
  testthat::expect_equal(chimeric_rname(has_tags_no_rname),list())
  testthat::expect_equal(length(unlist(chimeric_rname(has_tags_has_rname))),4)
  testthat::expect_equal(length(chimeric_rname(no_tags_has_rname)),2)
})

testthat::test_that("Test num_chimeric", {
  testthat::expect_equal(num_chimeric(no_tags_no_rname),0)
  testthat::expect_equal(num_chimeric(has_tags_no_rname),1)
  testthat::expect_equal(num_chimeric(has_tags_has_rname),2)
  testthat::expect_equal(num_chimeric(no_tags_has_rname),2)
})

testthat::test_that("Test num_chimeric", {
  testthat::expect_equal(chimeric_proportion(no_tags_no_rname),0)
  testthat::expect_equal(chimeric_proportion(has_tags_no_rname),1/5)
  testthat::expect_equal(chimeric_proportion(has_tags_has_rname),1/2)
  testthat::expect_equal(chimeric_proportion(no_tags_has_rname),1/2)
})