import random
import sys

input_start = sys.argv[1]
output_start = sys.argv[2]
src_lang = sys.argv[3]
tgt_lang = sys.argv[4]
samples = sys.argv[5]
num_lines = sys.argv[6]

threshold = float(samples) / float(num_lines)
input_src = input_start + "." + src_lang
input_tgt = input_start + "." + tgt_lang
output_src = output_start + "." + src_lang
output_tgt = output_start + "." + tgt_lang

i = 0
with open(input_src, 'r') as f_is, open(input_tgt, 'r') as f_it, open(output_src, 'w') as f_os, open(output_tgt, 'w') as f_ot:
	for line_s in f_is:
		line_t = f_it.readline()
		if random.random() < threshold:
			f_os.write(line_s)
			f_ot.write(line_t)
			i += 1
