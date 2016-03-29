echo "NOTE: This script only run ex4 and ex5."
echo "Before run the scripts,"                                      \
        "set best_fbDocs and best_fbTerms in best_arguments file,"  \
        "fill in constants in user-parameters file, and"            \
        "copy in java files to QryEval directory"
source ./fixed-parameters
mkdir $log_path
# assume default settings at aws ec2
echo "Test started. You can monitor the progress at"                \
        "http://your-domain-name/log/."                             \
        "All logs can be downloaded at"                             \
        "http://your-domain-name/log.tar.gz"                        \
        "after completion."
bash hw4_baseline.sh
source $best_arg_file
bash hw4_ex4_batch.sh $best_arg_file $best_fbDocs $best_fbTerms >> $bash_log_path
source $best_arg_file
bash hw4_ex5_batch.sh $best_arg_file $best_fbDocs $best_fbTerms $best_originWeight >> $bash_log_path
cat $best_arg_file >> $bash_log_path
# tar into a tar ball for download
tar -czvf $log_tar_ball_path $log_path
echo "Test ended"