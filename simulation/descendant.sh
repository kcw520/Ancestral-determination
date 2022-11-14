#!/bin/bash
for varible in {1..100} 
do
	shuf Ancestors.tsv -n 1 | awk '{$1=null;print $0}' > random_line_${varible}.txt
    ###get E
	c_${varible}=0
	for line_${varible} in `cat random_line_${varible}.txt`
	do 
		aalls_${varible}[$c_${varible}]=$line_${varible}
		((c_${varible}++))
	done 
	arr_${varible}=($(seq 1 $(${#alls_${varible}[*]}-1)))
	res_${varible}=${arr_${varible}[$(($RANDOM%${#arr_${varible}[*]}))]}
	E_raw_${varible}=${alls_${varible}[$res_${varible}]}
	###get D
	cat Ancestors.tsv |grep -o -w $E_raw_${varible} .*| awk -F  '{print $0}'|awk '{$1=null;print $0}' result_${varible}.txt > Draw_${varible}.txt 
	###get Q
	cat Draw_${varible}.txt | tr ' ' 'n'| sort | uniq |sed '/^$/d'>d_test_${varible} 
	shuf d_test_${varible} -n 1 -o Q_${varible}.txt 
	for line1_${varible} in `cat Q_${varible}.txt` 
	do 
	  Q_raw_${varible}=$line1_${varible} 
	done 
	#remove Q from D
	sed 's/'$Q_raw_${varible}'//' d_test_${varible} |sed '/^$/d' >d_test2_${varible}  
	row_${varible}=$(cat d_test2_${varible} | wc -l) 
	#selecte 10% of the descendant sequences randomly as D
	shuf d_test2_${varible} -n $[(row_${varible}+10-1)/10]  -o d_test3_${varible} 
	seq=SEQ 
	E_${varible}=$seq$E_raw_${varible} 
	Q_${varible}=$seq$Q_raw_${varible} 
	awk '$1~/^'$Q_${varible}'$/' Simu_mutlist.tsv | tr  't' 'n' | tr  ' ' 'n' > q_sequence_${varible}
	awk '$1~/^'$E_${varible}'$/' Simu_mutlist.tsv | tr  't' 'n'| tr  ' ' 'n' > e_sequence_${varible}
	for id_${varible} in `cat d_test3_${varible}` 
	do 
		seq=SEQ 
		D_${varible}=$seq$id_${varible} 
		awk '$1~/^'$D_${varible}'$/' Simu_mutlist.tsv| tr  't' 'n'| tr  ' ' 'n' > d_sequence_${varible}
		cat d_sequence_${varible} q_sequence_${varible}|sort|uniq -u|awk 'END{print NR}'>N_q_d_${varible}
		echo $D_${varible} > D_${varible}
		paste D_${varible} N_q_d_${varible} >>N_q_d_all_${varible} 
	done 
	sort -n -k 2 N_q_d_all_${varible} |head -1 >N_q_d_samll_${varible} 
	awk  '{print $1}' N_q_d_samll_${varible} >D_small_${varible} 
	for D_small_${varible} in `cat D_small_${varible}`  
		do 
		echo 	echo $D_small_${varible} 
		done 
	awk '$1~/^'$D_small_${varible}'$/' Simu_mutlist.tsv > d_small_sequence_${varible} 
	cat d_small_sequence_${varible} | tr  't' 'n' > d_small_sequence2_${varible}   
	cat d_small_sequence2_${varible} | tr  ' ' 'n' > d_small_sequence3_${varible}   
	cat e_sequence3_${varible} d_small_sequence3_${varible}|sort|uniq -u|awk 'END{print NR}'> N_d_e_${varible}  
	cat e_sequence3_${varible} q_sequence3_${varible}|sort|uniq -u|awk 'END{print NR}'> N_q_e_${varible} 
	echo $E_${varible} > E_${varible} 
	echo $Q_${varible} > Q_${varible} 
	paste N_d_e_${varible} res_${varible} E_raw_${varible} E_${varible} res1_${varible} Q_raw_${varible} Q_${varible} N_q_e_${varible} N_q_d_samll_${varible} >>E_Q_D_${varible} 
done
