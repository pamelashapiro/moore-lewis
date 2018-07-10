Moore-Lewis Selection for Domain Adaptation with KenLM Scripts

Step 1:

Clone this repo
You'll need to change variables for each of these steps in the moore_lewis.sh file
Start with changing SCRIPTS_DIR to be the location of this repo

Step 2:

Install kenlm (https://github.com/kpu/kenlm)
Change KENLM_DIR to be the location of the build directory of your installation

Step 3:

Make a directory for your output
Change OUTPUT_DIR to this path

Step 4:

Set SRC, TGT, and DOMAIN
Set INDOMAIN_DATA to the path for your in domain data and FULL_CRAWLED_DATA to the large dataset you'd like to select from. The script assumes your data ends with .$SRC, .$TGT and you only specify the path up to this point, so you may need to change paths if this structure doesn't hold.

Step 5:

Run moore_lewish.sh. It may use up to 100G so if your grid requires you reserve this, you should reserve that much.
Your Moore-Lewis-sorted sentence pairs will be in moore-lewis-ranked.$SRC and moore-lewis-ranked.$TGT. 

(Optional) Step 6:

If you'd like to use perplexity on in-domain data to select the right amount of data, use perplexity_selection.sh. The variables are set the same as above, with the exception that ML_SORTED_DATA should point to your output moore-lewis-ranked, and OUTPUT_DIR should be a different output directory than above.

It initially searches by doubling data sizes, but if you'd like to narrow the search, you can change the variable SECTIONS to be the data sizes to try.