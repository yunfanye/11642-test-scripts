import os
import re
import json
import time
import sys

para_filename = sys.argv[1]

parameter_tpl = "indexPath=/home/ec2-user/index\n"		+\
				"queryFilePath={0}\n"					+\
				"trecEvalOutputPath={1}\n"				+\
				"retrievalAlgorithm={2}\n"				+\
				"Indri:mu={3}\n" 						+\
				"Indri:lambda={4}\n"					+\
				"fb={5}\n"	 							+\
				"fbDocs={6}\n"							+\
				"fbTerms={7}\n"							+\
				"fbMu=0\n"								+\
				"fbOrigWeight={8}\n"					+\
				"fbExpansionQueryFile={9}"
		

queryFilePath = sys.argv[2]
outputPath = sys.argv[3]
model = sys.argv[4]
indri_mu = sys.argv[5]
indri_lambda = sys.argv[6]
fb = sys.argv[7]
fbDocs = sys.argv[8]
fbTerms = sys.argv[9]
fbOrigWeight = sys.argv[10]
expansionOutput = sys.argv[11]
fbInitialRankingFile = sys.argv[12]
parameters = parameter_tpl.format(queryFilePath, outputPath,
 	model, indri_mu, indri_lambda, fb, fbDocs, fbTerms,
 	fbOrigWeight, expansionOutput)
if fbInitialRankingFile != "null":
	parameters += "\nfbInitialRankingFile={0}".format(fbInitialRankingFile)
para_file = open(para_filename, 'w+')
para_file.write(parameters)


