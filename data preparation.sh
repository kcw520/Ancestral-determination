# bwa mem
bwa index ref.fa -p genome
bwa mem ref.fa sample.fq > sample-se.sam
bwa mem ref.fa sample1.fq sample2.fq > sample-pe.sam
samtools view -@8 -b sample.sam > sample.bam
#samtools
samtools sort -n sample.bam -o sample.sort.bam 
samtools index sample.sort.bam 
samtools flagstat sample.sort.bam
samtools mpileup -OsBa ref.fa  sample.sort.bam > sample.mpileup
#readcounts
VarScan.v2.3.9.jar readcounts sample.mpileup --min-coverage 0 --output-file sample.readcounts
#call SNP
/xtdisk/limk_group/mawt/APP/CPlusPlusShell/CallConsensusSequence/bin/x64/Debug/CallConsensusSequence.out -i sample.readcounts
