echo "Before run the scripts," 							\
	"fill in constants in user-parameters file, and"	\
	"copy in java files to QryEval directory"
# assume default settings at aws ec2
echo "Test started. You can monitor the progress at"	\
 	"http://your-domain-name/log/info.php." 			\
 	"All logs can be downloaded at" 					\
 	"http://your-domain-name/log.tar.gz"				\
 	"after completion."
source ./fixed-parameters
mkdir $log_path
bash hw4_ex1_batch.sh
rm -f $best_arg_file
bash hw4_ex2_batch.sh $best_arg_file >> $bash_log_path
source $best_arg_file
bash hw4_ex3_batch.sh $best_arg_file $best_fbDocs >> $bash_log_path
source $best_arg_file
bash hw4_ex4_batch.sh $best_arg_file $best_fbDocs $best_fbTerms >> $bash_log_path
source $best_arg_file
bash hw4_ex5_batch.sh $best_arg_file $best_fbDocs $best_fbTerms $best_originWeight >> $bash_log_path
cat $best_arg_file
# tar into a tar ball for download
tar -czvf $log_tar_ball_path $log_path
echo "Test ended"