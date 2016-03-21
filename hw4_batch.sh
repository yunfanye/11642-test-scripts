source ./fixed-parameters
bash hw4_ex1_batch.sh
rm -f $best_arg_file
bash hw4_ex2_batch.sh $best_arg_file
source $best_arg_file
bash hw4_ex3_batch.sh $best_arg_file $best_fbDocs
source $best_arg_file
bash hw4_ex4_batch.sh $best_arg_file $best_fbDocs $best_fbTerms
source $best_arg_file
bash hw4_ex5_batch.sh $best_arg_file $best_fbDocs $best_fbTerms $best_originWeight