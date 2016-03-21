import os
import re
import json
import time
import sys

eval_output_path = sys.argv[1]
analysis_output_path = sys.argv[2]

def parse_result(text, interest_set = None):
    begin_mark = 'uploaded ----'
    end_mark = '---- Done ----'
    if begin_mark not in text or end_mark not in text:
        return None
    text = text[text.find(begin_mark) + len(begin_mark) : text.find(end_mark)]
    qDict = dict()
    for line in text.split('\n'):
        seg = re.split(r'\s+', line)
        if len(seg) != 3:
            continue
        if not seg[1] in qDict:
            qDict[seg[1]] = dict()
        if interest_set and seg[0] not in interest_set:
            continue
        qDict[seg[1]][seg[0]] = seg[2]
    return qDict

interest_set = ['P10', 'P20', 'P30', 'map']
file_h = open(eval_output_path, 'r')
text = file_h.read()
result_set = parse_result(text, interest_set)

analysis_file = open(analysis_output_path, 'w+')
for query, result in result_set.iteritems():
    for metric, value in result.iteritems():
        analysis_file.write("{0}_{1}={2}\n".format(query, metric, value))
analysis_file.close()

