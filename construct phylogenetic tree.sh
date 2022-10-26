# construct phylogenetic tree
mafft --auto all.fasta > all_mafft.fasta
iqtree2 -s all_mafft.fasta -m GTR+F -asr -nt AUTO -o RaTG13,PCoV GX-P5L,MP789,BANAL-20-52/Laos/2020
