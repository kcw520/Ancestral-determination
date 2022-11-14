#!/bin/bash
for varible in {1..1000} 
do
	shuf Ancestors.tsv -n 1 |awk '{$1=null;print $0}' > random_line_${varible}.txt
	###get E
	c_${varible}=0 
	for line_${varible} in `cat random_line_${varible}.txt`
	do
		alls_${varible}[$c_${varible}]=$line_${varible}
		((c_${varible}++))
	done
	arr_${varible}=($(seq 1 $(${#alls_${varible}[*]}-1)))
	res_${varible}=${arr_${varible}[$(($RANDOM%${#arr_${varible}[*]}))]}
	E_raw_${varible}=${alls_${varible}[$res_${varible}]}
	#get Q
	sed 's/^[ t]*//g' random_line_${varible}.txt |cut -d -f 1-$res_${varible}| tr ' ' 'n' | sort | uniq |sed '/^$/d' > Qfather_${varible} 
	awk '{$1=null;print $0}' Ancestors.tsv |sed 's/^[ t]*//g' |cut -d   -f 1-$res_${varible} | tr ' ' 'n'| sort | uniq |sed '/^$/d' > Qall_${varible} 
	cat Qall_${varible} Qfather_${varible}|sort|uniq -u > Quncle_${varible} 
	shuf Quncle_${varible} -n 1 -o Q_${varible}.txt 
	for line1_${varible} in `cat Q_${varible}.txt` 
	do 
		Q_raw_${varible}=$line1_${varible} 
	done 
	###get D
	cat Ancestors.tsv |grep -o -w $E_raw_${varible} .*| awk -F  '{print $0}'|awk '{$1=null;print $0}'| tr ' ' 'n'| sort | uniq |sed '/^$/d' >d_test_${varible} 
	row_${varible}=$(cat d_test_${varible} | wc -l) 
	Dnum_${varible}=$[(row_${varible}+10-1)/10] 
	#selecte 10% of the descendant sequences randomly as D
	shuf d_test_${varible} -n $Dnum_${varible} -o d_test2_${varible} 
	seq=SEQ 
	E_${varible}=$seq$E_raw_${varible} 
	Q_${varible}=$seq$Q_raw_${varible} 
	awk '$1~/^'$Q_${varible}'$/' Simu_mutlist.tsv | tr  't' 'n' | tr  ' ' 'n' > q_sequence_${varible}
	awk '$1~/^'$E_${varible}'$/' Simu_mutlist.tsv | tr  't' 'n'| tr  ' ' 'n' > e_sequence_${varible}
	for id_${varible} in `cat d_test2_${varible}` 
	do 
		seq=SEQ 
		D_${varible}=$seq$id_${varible} 
		awk '$1~/^'$D_${varible}'$/' Simu_mutlist.tsv| tr  't' 'n'| tr  ' ' 'n' > d_sequence_${varible}
		cat d_sequence_${varible} q_sequence_${varible}|sort|uniq -u|awk 'END{print NR}'>N_q_d_${varible}
		echo $D_${varible} > D_${varible}
		paste D_${varible} N_q_d_${varible} >>N_q_d_all_${varible} 
	done 
		sort -n -k 2 N_q_d_all_${varible} |head -1 |awk  '{print $1}' |awk '$1~/^'$D_small_${varible}'$/'| tr  't' 'n' | tr  ' ' 'n' > d_small_sequence_${varible}	cat e_sequence3_${varible} d_small_sequence3_${varible}|sort|uniq -u|awk 'END{print NR}'> N_d_e_${varible}  
	cat e_sequence3_${varible} q_sequence3_${varible}|sort|uniq -u|awk 'END{print NR}'> N_q_e_${varible} 
	echo $E_${varible} > E_${varible} 
	echo $Q_${varible} > Q_${varible} 
	paste N_d_e_${varible}  E_${varible}Q_${varible} N_q_e_${varible} N_q_d_samll_${varible} >>E_Q_D_${varible} 

done
