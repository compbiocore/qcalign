cigar_prof_plot <- function(){

  directory <- bamfile
  decoder.file <- system.file("extdata/decoder.txt",
                              package="QoRTsExampleData",
                              mustWork=TRUE);
  decoder.data <- read.table(decoder.file,
                             header=T,
                             stringsAsFactors=F);
  res <- read.qc.results.data(directory, decoder = decoder.data,
                              calc.DESeq2 = TRUE, calc.edgeR = TRUE);
  byLane.plotter <- build.plotter.colorByLane(res);
  makePlot.cigarOp.byCycle(byLane.plotter, "Del");
  makePlot.cigarOp.byCycle(byLane.plotter, "Ins");
  makePlot.cigarOp.byCycle(byLane.plotter, "Splice");
}
