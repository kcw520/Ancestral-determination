# SuspiciousSequence
 The code of paper Genomic analysis of the suspicious SARS-CoV-2 sequences in the public sequencing database
This is the programe of our computational method.
In our computational method, If Q is the progenitor sequence of SARS-CoV-2, the difference between Q and D must be greater than the difference between Q and E, thus the number of mutations (N) should conform to the following equations. 
Nd+Nq > Nq +Ns (1)
Nd+Nq > Nd +Ns (2)
For a given Q, Nq+Ns is the difference between Q and E. The value of Nq+Ns can be calculated from mutation.txt which obtained from data preparation.sh and call SNP.cpp. The smallest Nd+Nq can be found using the database (https://ngdc.cncb.ac.cn/ncov/online/tool/genome-tracing) by providing the mutation list (mutation.txt). Since we got Nq+Ns and Nd+Nq , we can calcaluate Nq, Ns and Nd individually. Once we got the number used in the equations above, we can use our computational method to identify the ancestral sequences. 

call SNP.cpp: The code is used for calling SNP.
construct phylogenetic tree.sh: The code is used for constructing phylogenetic tree.
data preparation.sh: The code is used for processing the data downloaded from public database.
mutation.txt: The mutations of 204 samples that have mutations when compared to  NC_045512.2.Use the file to search in https://ngdc.cncb.ac.cn/ncov/online/tool/genome-tracing/ and you can find D with the least number of mutations from Q sequence.
