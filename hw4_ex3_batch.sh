source ./fixed-parameters
best_fbDocs=$2
# Indri QE your sys
for fbTerms in 5 10 20 30 40 50
do
	model="Indri"
	indri_mu=1000
	indri_lambda=0.7
	fb="true"
	fbDocs=$best_fbDocs
	fbOrigWeight=0.5
	fbInitialRankingFile="null"
	tag="_ex3_qe_your_sys"$fbTerms
	bash batch_query.sh $model $indri_mu $indri_lambda $fb $fbDocs \
		$fbTerms $fbOrigWeight $fbInitialRankingFile $tag
done
# Indri QE ref sys
for fbTerms in 5 10 20 30 40 50
do
	model="Indri"
	indri_mu=1000
	indri_lambda=0.7
	fb="true"
	fbDocs=$best_fbDocs
	fbOrigWeight=0.5
	fbInitialRankingFile=$reference_SDM
	tag="_ex3_qe_ref_sys"$fbTerms
	bash batch_query.sh $model $indri_mu $indri_lambda $fb $fbDocs \
		$fbTerms $fbOrigWeight $fbInitialRankingFile $tag
done


arg_list=(0 1 2 5 10 20 30 40 50 5 10 20 30 40 50)
# extract final result
best_index=`python extract.py $final_result_output_path"_ex3"	\
		$analysis_output_path"_ex1_rb"							\
		$analysis_output_path"_ex3_qe_your_sys5"				\
		$analysis_output_path"_ex3_qe_your_sys10"				\
		$analysis_output_path"_ex3_qe_your_sys20"				\
		$analysis_output_path"_ex3_qe_your_sys30"				\
		$analysis_output_path"_ex3_qe_your_sys40"				\
		$analysis_output_path"_ex3_qe_your_sys50"				\
		$analysis_output_path"_ex3_qe_ref_sys5"					\
		$analysis_output_path"_ex3_qe_ref_sys10"				\
		$analysis_output_path"_ex3_qe_ref_sys20"				\
		$analysis_output_path"_ex3_qe_ref_sys30"				\
		$analysis_output_path"_ex3_qe_ref_sys40"				\
		$analysis_output_path"_ex3_qe_ref_sys50"`	
echo "best_fbTerms="${arg_list[$best_index]} >> $1
cat $final_result_output_path"_ex3"