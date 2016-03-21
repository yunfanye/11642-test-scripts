source ./fixed-parameters
best_fbDocs=$2
best_fbTerms=$3
# Indri QE your sys
for fbOrigWeight in 0.0 0.2 0.4 0.6 0.8 1.0
do
	model="Indri"
	indri_mu=1000
	indri_lambda=0.7
	fb="true"
	fbDocs=$best_fbDocs
	fbTerms=$best_fbTerms
	fbInitialRankingFile="null"
	tag="_ex4_qe_your_sys"$fbOrigWeight
	bash batch_query.sh $model $indri_mu $indri_lambda $fb $fbDocs \
		$fbTerms $fbOrigWeight $fbInitialRankingFile $tag
done
# Indri QE ref sys
for fbOrigWeight in 0.0 0.2 0.4 0.6 0.8 1.0
do
	model="Indri"
	indri_mu=1000
	indri_lambda=0.7
	fb="true"
	fbDocs=$best_fbDocs
	fbTerms=$best_fbTerms
	fbInitialRankingFile=$reference_SDM
	tag="_ex4_qe_ref_sys"$fbOrigWeight
	bash batch_query.sh $model $indri_mu $indri_lambda $fb $fbDocs \
		$fbTerms $fbOrigWeight $fbInitialRankingFile $tag
done

arg_list=(0 1 2 0.0 0.2 0.4 0.6 0.8 1.0 0.0 0.2 0.4 0.6 0.8 1.0)
# extract final result
best_index=`python extract.py $final_result_output_path"_ex4"	\
		$analysis_output_path"_ex1_rb"						 	\
		$analysis_output_path"_ex4_qe_your_sys0.0"			 	\
		$analysis_output_path"_ex4_qe_your_sys0.2"			 	\
		$analysis_output_path"_ex4_qe_your_sys0.4"			 	\
		$analysis_output_path"_ex4_qe_your_sys0.6"			 	\
		$analysis_output_path"_ex4_qe_your_sys0.8"			 	\
		$analysis_output_path"_ex4_qe_your_sys1.0"			 	\
		$analysis_output_path"_ex4_qe_ref_sys0.0"			 	\
		$analysis_output_path"_ex4_qe_ref_sys0.2"			 	\
		$analysis_output_path"_ex4_qe_ref_sys0.4"			 	\
		$analysis_output_path"_ex4_qe_ref_sys0.6"			 	\
		$analysis_output_path"_ex4_qe_ref_sys0.8"			 	\
		$analysis_output_path"_ex4_qe_ref_sys1.0"`	
echo "best_originWeight="${arg_list[$best_index]} >> $1
cat $final_result_output_path"_ex4"