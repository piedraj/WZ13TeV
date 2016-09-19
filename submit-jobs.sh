#!/bin/bash

if [ $# -lt 2 ]; then
    echo "  "
    echo "  rm -rf jobs"
    echo "  rm -rf rootfiles"
    echo "  "
    echo "  ./submit-jobs.sh samples/80x/samples_data_l1loose.txt nominal"
    echo "  ./submit-jobs.sh samples/80x/samples_mc_l1loose.txt   nominal"
    echo "  "
    exit -1
fi

export SAMPLES=$1
export SYSTEMATIC=$2


# Compile
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo "  "
echo "  Let's play it safe. Compiling runAnalysis..."
./make
echo "  "


# Submit jobs to the queues
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
export NJOBS=`cat $SAMPLES | grep latino | grep -v "#" | wc -l`
echo "  And... submitting" $NJOBS "jobs"
echo "  "
mkdir -p jobs
qsub -t 1-$NJOBS -v SAMPLES -v SYSTEMATIC settings.sge
