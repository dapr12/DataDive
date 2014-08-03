# extracts a subsample of records from a file

# assumes the goal is to avoid reading the entire file into 
# memory at once; here, only 1 line will be in memory 
# at any time

# also assumes the total number of records in the file is 
# not known (on # Linux/Mac, obtain as output of wc -l infile, 
# but may take a long time)

# every k-th record will extracted

# arguments:
#
#   infile:  name of input file, quoted
#   outfile:  name of output file, quoted
#   k:  every k-th record of infile will be extracted
#   header:  TRUE means infile has a header record

# value:  number of records extracted 

subsamfile <- function(infile,outfile,k,header=T) {
   ci <- file(infile,"r")
   co <- file(outfile,"w")
   if (header) {
      hdr <- readLines(ci,n=1)
      writeLines(hdr,co)
   }
   recnum = 0
   numout = 0
   while (TRUE) {
      inrec <- readLines(ci,n=1)
      if (length(inrec) == 0) {  # end of file?
         close(co) 
         return(numout)
      }
      recnum <- recnum + 1
      if (recnum %% k == 0) {
         numout <- numout + 1
         writeLines(inrec,co)
      }
   }
}
