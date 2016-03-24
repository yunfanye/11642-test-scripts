source ./user-parameters
source ./fixed-parameters
# RankedBoolean BOW
model="RankedBoolean"
indri_mu=1000
indri_lambda=0.7
fb="false"
fbDocs=10
fbTerms=10
fbOrigWeight=0.5
fbInitialRankingFile="null"
tag="_ex1_rb"
bash batch_query.sh $model $indri_mu $indri_lambda $fb $fbDocs \
	$fbTerms $fbOrigWeight $fbInitialRankingFile $tag
# Indri BOW your sys
model="Indri"
indri_mu=1000
indri_lambda=0.7
fb="false"
fbDocs=10
fbTerms=10
fbOrigWeight=0.5
fbInitialRankingFile="null"
tag="_ex1_bow_your_sys"
bash batch_query.sh $model $indri_mu $indri_lambda $fb $fbDocs \
	$fbTerms $fbOrigWeight $fbInitialRankingFile $tag
# Indri BOW ref sys
tag="_ex1_bow_ref_sys"
eval_output_path=$eval_out_file_path$tag
direct_analysis_output_path=$analysis_output_path$tag
perl $fetch_pl_file_path $username $password \
	$reference_BOW $eval_output_path "Detailed"
# retrieve interested results, i.e. P@10, P@20, P@30, MAP
python $analyze_py_file_path $eval_output_path \
	$direct_analysis_output_path
# Indri QE your sys
model="Indri"
indri_mu=1000
indri_lambda=0.7
fb="true"
fbDocs=10
fbTerms=10
fbOrigWeight=0.5
fbInitialRankingFile="null"
tag="_ex1_qe_your_sys"
bash batch_query.sh $model $indri_mu $indri_lambda $fb $fbDocs \
	$fbTerms $fbOrigWeight $fbInitialRankingFile $tag
# Indri QE ref sys
model="Indri"
indri_mu=1000
indri_lambda=0.7
fb="true"
fbDocs=10
fbTerms=10
fbOrigWeight=0.5
fbInitialRankingFile=$reference_BOW
tag="_ex1_qe_ref_sys"
bash batch_query.sh $model $indri_mu $indri_lambda $fb $fbDocs \
	$fbTerms $fbOrigWeight $fbInitialRankingFile $tag

# extract final result
python extract.py $final_result_output_path"_ex1"			\
		$analysis_output_path"_ex1_rb"						\
		$analysis_output_path"_ex1_bow_your_sys"			\
		$analysis_output_path"_ex1_bow_ref_sys"				\
		$analysis_output_path"_ex1_qe_your_sys"				\
		$analysis_output_path"_ex1_qe_ref_sys"
cat $final_result_output_path"_ex1"