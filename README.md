# SuspiciousSequence
This is the program of our computational method.

#download
Step one: The sequencing runs containing SARS-CoV-2 reads discussed in our paper can be downloaded in FASTQ format in the NCBI’s SRA database (https://www.ncbi.nlm.nih.gov/sra) using their accession number provided in Supplementary Table 1.

#sequence alignment
Step two: The sequencing read can be aligned to NC_045512.2 using BWA and the sequencing depth, mpileup files and read counts files can be retrieved from BAM files using Samtools and Varscan. The example code of this part provided in data preparation.sh.

#call mutation & get the value of Nq+Ns
Step three: Mutation was called using the code provided in call SNP.cpp, the input file is the read counts file obtained from Step two and default values are used for other parameters. The mutation number is the difference between one questioned sequence (Q) and the earliest SARS-CoV-2 sequence (E) (NC_045512.2), and is the sum of Nq and Ns mentioned in our equations.

#get the value of Nd , Nq
Step four: For a given Q, the SARS-CoV-2 sequences in public databases (D) with the least number of mutations from Q sequence (smallest Nd+Nq) can be found using the database (https://ngdc.cncb.ac.cn/ncov/online/tool/genome-tracing) by providing the mutation list (mutation.txt) obtained from step three. The database provides Nd (Subject private) and Nq (Query private) respectively and then Ns can be calculated by knowing the sum of Nq and Ns in step three.

#apply equations
Step five: In our computational method, If Q is the progenitor sequence of SARS-CoV-2, the difference between Q and D must be greater than the difference between Q and E, thus the number of mutations (N) should conform to the equations that Nd+Nq > Nq +Ns and Nd+Nq > Nd+Ns. Since Nq, Ns and Nd can be obtained individually from steps above, we can use our computational method to identify the ancestral sequences.

