import sys

indomain_scores_file = sys.argv[1]
gendomain_scores_file = sys.argv[2]
gendomain_sents_file = sys.argv[3]
output_file = sys.argv[4]

with open(indomain_scores_file, 'r') as indomain_scores_f, open(gendomain_scores_file, 'r') as gendomain_scores_f, \
 open(gendomain_sents_file, 'r') as gendomain_sents_f, open(output_file, 'w') as f_o:
 	for line in gendomain_sents_f:
 		indomain_score_line = indomain_scores_f.readline().strip().split()
 		indomain_score = float(indomain_score_line[1])
 		gendomain_score = float(gendomain_scores_f.readline().strip().split()[1])
 		cross_ent_diff = indomain_score - gendomain_score
 		f_o.write(str(cross_ent_diff) + ' ')
 		f_o.write(line)
