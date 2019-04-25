#! /bin/bash
# this file is snakemake.sh
module load snakemake  || exit 1

sbcmd="sbatch --cpus-per-task={threads}"
sbcmd+=" --time=100:00:00 --partition={cluster.partition}"
sbcmd+=" {cluster.extra}"

snakemake -s run_full_pipeline.snakefile -pr --keep-going --local-cores $SLURM_CPUS_PER_TASK \
    --jobs 10 --nolock --cluster-config cluster.yaml --cluster "$sbcmd" \
    --latency-wait 120 all
