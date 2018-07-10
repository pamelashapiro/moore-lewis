#!/bin/bash

SRC=
TGT=
DOMAIN=

INDOMAIN_DATA=
ML_SORTED_DATA=

OUTPUT_DIR=
KENLM_DIR=
SCRIPTS_DIR=

SECTIONS=("2000" "4000" "8000" "16000" "32000" "64000" "128000" "256000" "512000" "1024000" "2048000" "4096000")

for TOPK in "${SECTIONS[@]}"
do

    # Build LM with increasing amounts of crawled data
    head -n $TOPK $ML_SORTED_DATA.$SRC | $KENLM_DIR/bin/lmplz -o 5 -S 90G > $OUTPUT_DIR/paracrawl.$SRC.arpa 2> $OUTPUT_DIR/paracrawl.$SRC.log
    $KENLM_DIR/bin/build_binary $OUTPUT_DIR/paracrawl.$SRC.arpa $OUTPUT_DIR/paracrawl.$SRC.binary 2>> $OUTPUT_DIR/paracrawl.$SRC.log

    # Score indomain data with crawled model
    $KENLM_DIR/bin/query $OUTPUT_DIR/paracrawl.$SRC.binary -v summary < $INDOMAIN_DATA.$SRC > $OUTPUT_DIR/paracrawl.$SRC.scores 2>> $OUTPUT_DIR/paracrawl.$SRC.log

    echo "perplexity for datasize: "
    echo $TOPK
    head -n 1 $OUTPUT_DIR/paracrawl.$SRC.scores | cut -f 2

done
