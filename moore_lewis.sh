#!/bin/bash

SRC=
TGT=
DOMAIN=

INDOMAIN_DATA=
FULL_CRAWLED_DATA=

OUTPUT_DIR=
KENLM_DIR=
SCRIPTS_DIR=

# Sample parallel data to be roughly same size as indomain data
SAMPLES=$(wc -l $INDOMAIN_DATA.$SRC | awk '{print $1}')
NUM_LINES=$(wc -l $FULL_CRAWLED_DATA.$SRC | awk '{print $1}')
python $SCRIPTS_DIR/randomly_sample_data.py $FULL_CRAWLED_DATA $OUTPUT_DIR/paracrawl.tok.sample $SRC $TGT $SAMPLES $NUM_LINES

# Build LM with indomain data
$KENLM_DIR/bin/lmplz -o 5 -S 90G < $INDOMAIN_DATA.$SRC > $OUTPUT_DIR/$DOMAIN.$SRC.arpa

$KENLM_DIR/bin/build_binary $OUTPUT_DIR/$DOMAIN.$SRC.arpa $OUTPUT_DIR/$DOMAIN.$SRC.binary

# Build LM with sampled crawled data
$KENLM_DIR/bin/lmplz -o 5 -S 90G < $OUTPUT_DIR/paracrawl.tok.sample.$SRC > $OUTPUT_DIR/paracrawl.$SRC.arpa

$KENLM_DIR/bin/build_binary $OUTPUT_DIR/paracrawl.$SRC.arpa $OUTPUT_DIR/paracrawl.$SRC.binary

# Score crawled data with indomain model
$KENLM_DIR/bin/query $OUTPUT_DIR/$DOMAIN.$SRC.binary -v sentence < $FULL_CRAWLED_DATA.$SRC > $OUTPUT_DIR/$DOMAIN.$SRC.scores

# Score crawled data with crawled model
$KENLM_DIR/bin/query $OUTPUT_DIR/paracrawl.$SRC.binary -v sentence < $FULL_CRAWLED_DATA.$SRC > $OUTPUT_DIR/paracrawl.$SRC.scores

# Get cross entropy & sort
python $SCRIPTS_DIR/get_moore_lewis_scores.py $OUTPUT_DIR/$DOMAIN.$SRC.scores $OUTPUT_DIR/paracrawl.$SRC.scores $FULL_CRAWLED_DATA.$SRC $OUTPUT_DIR/moore-lewis-scores.$SRC

python $SCRIPTS_DIR/sort_scores.py $OUTPUT_DIR/moore-lewis-scores.$SRC $FULL_CRAWLED_DATA.$TGT $OUTPUT_DIR/moore-lewis-ranked $SRC $TGT
