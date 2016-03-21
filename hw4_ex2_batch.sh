source ./fixed-parameters
# Indri QE your sys
for fbDocs in 10 20 30 40 50 100
do
	model="Indri"
	indri_mu=1000
	indri_lambda=0.7
	fb="true"
	fbTerms=10
	fbOrigWeight=0.5
	fbInitialRankingFile="null"
	tag="_ex2_qe_your_sys"$fbDocs
	bash batch_query.sh $model $indri_mu $indri_lambda $fb $fbDocs \
		$fbTerms $fbOrigWeight $fbInitialRankingFile $tag
done
# Indri QE ref sys
for fbDocs in 10 20 30 40 50 100
do
	model="Indri"
	indri_mu=1000
	indri_lambda=0.7
	fb="true"
	fbTerms=10
	fbOrigWeight=0.5
	fbInitialRankingFile=$reference_SDM
	tag="_ex2_qe_ref_sys"$fbDocs
	bash batch_query.sh $model $indri_mu $indri_lambda $fb $fbDocs \
		$fbTerms $fbOrigWeight $fbInitialRankingFile $tag
done

arg_list=(0 1 2 10 20 30 40 50 100 10 20 30 40 50 100)

# extract final result
best_index=`python extract.py $final_result_output_path"_ex2"	\
		$analysis_output_path"_ex1_rb"							\
		$analysis_output_path"_ex2_qe_your_sys10"				\
		$analysis_output_path"_ex2_qe_your_sys20"				\
		$analysis_output_path"_ex2_qe_your_sys30"				\
		$analysis_output_path"_ex2_qe_your_sys40"				\
		$analysis_output_path"_ex2_qe_your_sys50"				\
		$analysis_output_path"_ex2_qe_your_sys100"				\
		$analysis_output_path"_ex2_qe_ref_sys10"				\
		$analysis_output_path"_ex2_qe_ref_sys20"				\
		$analysis_output_path"_ex2_qe_ref_sys30"				\
		$analysis_output_path"_ex2_qe_ref_sys40"				\
		$analysis_output_path"_ex2_qe_ref_sys50"				\
		$analysis_output_path"_ex2_qe_ref_sys100"`
echo "best_fbDocs="${arg_list[$best_index]} >> $1
cat $final_result_output_path"_ex2"