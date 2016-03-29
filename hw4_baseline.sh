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
# Save BOW queries
cp $query_file_path $query_file_path"_BOW"
# Change queries to RankedBoolean AND
cp $query_file_path"_AND" $query_file_path
bash batch_query.sh $model $indri_mu $indri_lambda $fb $fbDocs \
	$fbTerms $fbOrigWeight $fbInitialRankingFile $tag
# Restore queries
cp $query_file_path"_BOW" $query_file_path