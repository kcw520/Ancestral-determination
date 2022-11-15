# Pipeline to infer the evolutionary relationship between suspicious SARS-CoV-2 sequences and public SARS-CoV-2 genomes

Step one: Download the 5196 sequencing runs which were suspected to include the SARS-CoV-2 progenitor.

The sequencing runs containing SARS-CoV-2 reads discussed in our paper can be downloaded from the NCBI’s SRA database (https://www.ncbi.nlm.nih.gov/sra) using the accession number provided in Supplementary Table 1 in our paper.


Step two:  Reads alignment and files preparation

The sequencing reads were aligned to NC_045512.2 (one of the known earliest SARS-CoV-2 sequences) using BWA mem and the sequencing depth, mpileup files, and read counts files were retrieved from BAM files using Samtools and Varscan. 
The codes were provided in data preparation.sh.


Step three: SNP calling

Mutations were called using the code provided in call SNP.cpp. The input file is the read counts file obtained from Step two. 
The number of SNP is the sum of Nq and Ns in Equations 1&2.


Step four: Searching for the closest sequences in the public SARS-CoV-2 database for a given Q (questioned sequence)

The SARS-CoV-2 sequences in public databases (D) with the least number of mutations from Q (smallest Nd+Nq) can be found using the online tool (https://ngdc.cncb.ac.cn/ncov/online/tool/genome-tracing) by providing the mutation list (mutation.txt) obtained from step three. 
Nd (subject private) and Nq (query private) will be outputted by the online tool.
Ns can be calculated by Nq + Ns - Nq.


Step five: Infer the evolutionary relationship

If Q is the progenitor sequence of SARS-CoV-2, the difference between Q and D should be greater than the difference between Q and E (the known earliest SARS-CoV-2 sequence), thus the number of mutations (N) should conform to the following equations: Nd+Nq > Nq +Ns 
Nd+Nq > Nd+Ns. 
Please note that all progenitor sequences should conform to the two equations. However, satisfying these two equations unnecessarily implies that the sequence is from the progenitor.

The simulation data generated in the studies and scripts to analyze the simulation data are provided in the Simulation folder, which contains 8 subfiles.

Ancestors.tsv: This file contains the ancestry information for each sequence.
MutationAndCount.tsv: This file contains information about the number of mutations at each position of the original sequence.
SeqInfo.tsv: This file contains information about the mutation site and progenies of each sequence.
Simu_mutlist.tsv: This file contains the mutation information for each sequence.
collateral_ancestor.sh: This file provides the analysis code when Q is a collateral ancestor.
descendant.sh: This file provides the analysis code when Q is a descendant.
direct_ancestor.sh: This file provides the analysis code when Q is a direct ancestor.
Simulation_result.xlsx: This file shows the results of the simulation section.

