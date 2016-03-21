# get command line args
model=$1
indri_mu=$2
indri_lambda=$3
fb=$4
fbDocs=$5
fbTerms=$6
fbOrigWeight=$7
fbInitialRankingFile=$8
tag=$9
# read parameters
source ./user-parameters
source ./fixed-parameters
# process parameters
eval_input_path=$eval_in_file_path$tag
eval_output_path=$eval_out_file_path$tag
expansionOutput=$expanded_query_output_path$tag
analysis_output_path=$analysis_output_path$tag
java_output_path=$java_output_path$tag
# set parameters
python $change_para_py_path $para_file_path $query_file_path 	\
	$eval_input_path $model $indri_mu $indri_lambda $fb $fbDocs	\
	$fbTerms $fbOrigWeight $expansionOutput $fbInitialRankingFile
# compile
javac -cp $class_path -g $java_path/*.java
# delete may-exist infile due to multiple runs
rm -f $eval_input_path
rm -f $expansionOutput
# run
java -cp $class_path QryEval $para_file_path >> $java_output_path
# delete may-exist outfile due to multiple runs
rm -f $eval_output_path
# sent request to server to evaluate results, get detailed
perl $fetch_pl_file_path $username $password \
	$eval_input_path $eval_output_path "Detailed"
# retrieve interested results, i.e. P@10, P@20, P@30, MAP
python $analyze_py_file_path $eval_output_path $analysis_output_path
