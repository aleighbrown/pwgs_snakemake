#!/bin/bash
#Submit to the cluster, give it a unique name
#$ -S /bin/bash

#$ -cwd
#$ -V
#$ -l h_vmem=1.9G,h_rt=20:00:00,tmem=1.9G
#$ -pe smp 2

# join stdout and stderr output
#$ -j y
#$ -R y


if [ "$1" != "" ]; then
    RUN_NAME=$1
else
    RUN_NAME=$""
fi

FOLDER=submissions/$(date +"%Y%m%d%H%M")

mkdir -p $FOLDER
cp config.yaml $FOLDER/$RUN_NAMEconfig.yaml

snakemake -s run_full_pipeline.snakefile \
--jobscript cluster_qsub.sh \
--cluster-config cluster_sge.yaml \
--cluster-sync "qsub -R y -l h_vmem={cluster.h_vmem},h_rt={cluster.h_rt} -pe {cluster.pe} -o $FOLDER" \
-j 50 \
--nolock \
--rerun-incomplete \
--latency-wait 100
