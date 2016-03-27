import sys

extract_output_path=sys.argv[1]
baseline_path=sys.argv[2]

baseline_dict = dict()
result_dict = dict()
interest_set = ['P10', 'P20', 'P30', 'map', 'win']

names=dict()
for i in range(2, len(sys.argv)):
	start = sys.argv[i].rfind("/")
	names[i] = sys.argv[i][(start + 1):]

for i in range(len(sys.argv)):
	result_dict[i] = dict()

file_h = open(baseline_path, 'r')
text = file_h.read()
result_dict[2]["win"] = 0
for line in text.split('\n'):
	if len(line) == 0:
		continue
	qid, metric_pair = line.split('_')
	metric, value = metric_pair.split('=')
	if qid == "all":
		result_dict[2][metric] = value
	else:
		if metric == "map":
			baseline_dict[qid] = value
file_h.close()

for i in range(3, len(sys.argv)):
	win = 0
	file_h = open(sys.argv[i], 'r')
	text = file_h.read()
	for line in text.split('\n'):
		if len(line) == 0:
			continue
		qid, metric_pair = line.split('_')
		metric, value = metric_pair.split('=')
		if qid == "all":
			result_dict[i][metric] = value
		else:
			if metric == "map":
				if(value > baseline_dict[qid]):
					win += 1
	result_dict[i]["win"] = win
	file_h.close()

extract_file = open(extract_output_path, 'w+')
best_map = 0.0
best_index = 0
for i in range(2, len(sys.argv)):
    if result_dict[i]['map'] > best_map:
        best_map = result_dict[i]['map']
        best_index = i
    for metric in interest_set:
        extract_file.write("{0}:{1}={2}\n".format(names[i],
        	metric, result_dict[i][metric]))
print best_index
extract_file.close()