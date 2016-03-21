source ./fixed-parameters
source ./user-parameters

best_fbDocs=$2
best_fbTerms=$3
best_originWeight=$4
indri_mu=$best_indri_mu
indri_lambda=$best_indri_lambda
fbDocs=$best_fbDocs
fbTerms=$best_fbTerms
fbOrigWeight=$best_originWeight

model="Indri"
# Indri BOW origin
fb="false"
fbInitialRankingFile="null"
tag="_ex5_bow_ori"
bash batch_query.sh $model $indri_mu $indri_lambda $fb $fbDocs \
	$fbTerms $fbOrigWeight $fbInitialRankingFile $tag
# Indri BOW your sys
fb="true"
fbInitialRankingFile="null"
tag="_ex5_bow_you_qe"
bash batch_query.sh $model $indri_mu $indri_lambda $fb $fbDocs \
	$fbTerms $fbOrigWeight $fbInitialRankingFile $tag
# Indri BOW ref sys
fb="true"
fbInitialRankingFile=$reference_BOW
tag="_ex5_bow_ref_qe"
bash batch_query.sh $model $indri_mu $indri_lambda $fb $fbDocs \
	$fbTerms $fbOrigWeight $fbInitialRankingFile $tag

# back up original query
cp $query_file_path $query_file_path"_BOW"
# change query set to SDM
# run SDM perl
perl $SDM_pl_file_path $best_and_weight $best_near_weight \
	$best_window_weight $query_file_path $query_file_path"_SDM"
# replace the query
cp $query_file_path"_SDM" $query_file_path 
# Indri SDM origin
fb="false"
fbInitialRankingFile="null"
tag="_ex5_sdm_ori"
bash batch_query.sh $model $indri_mu $indri_lambda $fb $fbDocs \
	$fbTerms $fbOrigWeight $fbInitialRankingFile $tag
# Indri SDM your sys
fb="true"
fbInitialRankingFile="null"
tag="_ex5_sdm_you_qe"
bash batch_query.sh $model $indri_mu $indri_lambda $fb $fbDocs \
	$fbTerms $fbOrigWeight $fbInitialRankingFile $tag
# Indri SDM ref sys
fb="true"
fbInitialRankingFile=$reference_SDM
tag="_ex5_sdm_ref_qe"
bash batch_query.sh $model $indri_mu $indri_lambda $fb $fbDocs \
	$fbTerms $fbOrigWeight $fbInitialRankingFile $tag

# extract final result
python extract.py $final_result_output_path"_ex5"			\
		$analysis_output_path"_ex1_rb"						\
		$analysis_output_path"_ex5_bow_ori"					\
		$analysis_output_path"_ex5_bow_you_qe"				\
		$analysis_output_path"_ex5_bow_ref_qe"				\
		$analysis_output_path"_ex5_sdm_ori"					\
		$analysis_output_path"_ex5_sdm_you_qe"				\
		$analysis_output_path"_ex5_sdm_ref_qe"				

# restore the query
cp $query_file_path"_BOW" $query_file_path
cat $final_result_output_path"_ex5"