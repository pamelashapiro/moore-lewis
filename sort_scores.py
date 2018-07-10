import sys

scores_file = sys.argv[1]
tgt_file = sys.argv[2]
output_start = sys.argv[3]
src_lang = sys.argv[4]
tgt_lang = sys.argv[5]

output_src = output_start + "." + src_lang
output_tgt = output_start + "." + tgt_lang

scores = []
with open(scores_file, 'r') as f_is, open(tgt_file, 'r') as f_it:
	for line_s in f_is:
		fields = line_s.strip().split()
		s1 = float(fields[0])
		s2 = ' '.join(fields[1:])
		line_t = f_it.readline()
		scores.append((s1, s2, line_t))

with open(output_src, 'w') as f_os, open(output_tgt, 'w') as f_ot:
	for (s1, s2, line_t) in sorted(scores, reverse=True):
		f_os.write(s2)
		f_os.write('\n')
		f_ot.write(line_t)
