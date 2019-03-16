#!/bin/sh
# properties = {"type": "single", "rule": "submit_pwgs", "local": false, "input": ["/data/browna6/evolution/pwgs/phyloinputs/egfr_exome/NCI0411/NCI0411_1Met.params.json", "/data/browna6/evolution/pwgs/phyloinputs/egfr_exome/NCI0411/NCI0411_1Met.cnvs.txt", "/data/browna6/evolution/pwgs/phyloinputs/egfr_exome/NCI0411/NCI0411_1Met.ssm.txt"], "output": ["/data/browna6/evolution/pwgs/pwgs_output/egfr_exome_bysample/NCI0411/NCI0411_1Met/trees.zip"], "wildcards": {"patient": "NCI0411", "sample": "NCI0411_1Met"}, "params": {"output_dir": "/data/browna6/evolution/pwgs/pwgs_output/egfr_exome_bysample/NCI0411/NCI0411_1Met", "pwgs_python_directory": "/home/browna6/phylowgs/", "n_chains": 5, "r1": 883, "r2": 85, "r3": 22, "r4": 395, "r5": 865}, "log": [], "threads": 5, "resources": {}, "jobid": 370, "cluster": {"partition": "norm", "time": 10, "extra": "--gres=lscratch:10"}}
cd /spin1/users/browna6/pwgs_snakemake && \
/usr/local/Anaconda/envs_app/snakemake/5.4.0/bin/python3.6 \
-m snakemake /data/browna6/evolution/pwgs/pwgs_output/egfr_exome_bysample/NCI0411/NCI0411_1Met/trees.zip --snakefile /spin1/users/browna6/pwgs_snakemake/run_full_pipeline.snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /spin1/users/browna6/pwgs_snakemake/.snakemake/tmp.af7x3p8a /data/browna6/evolution/pwgs/phyloinputs/egfr_exome/NCI0411/NCI0411_1Met.params.json /data/browna6/evolution/pwgs/phyloinputs/egfr_exome/NCI0411/NCI0411_1Met.cnvs.txt /data/browna6/evolution/pwgs/phyloinputs/egfr_exome/NCI0411/NCI0411_1Met.ssm.txt --latency-wait 120 \
 --attempt 1 --force-use-threads \
--wrapper-prefix https://bitbucket.org/snakemake/snakemake-wrappers/raw/ \
  -p --nocolor \
--notemp --no-hooks --nolock --mode 2  --allowed-rules submit_pwgs  && touch "/spin1/users/browna6/pwgs_snakemake/.snakemake/tmp.af7x3p8a/370.jobfinished" || (touch "/spin1/users/browna6/pwgs_snakemake/.snakemake/tmp.af7x3p8a/370.jobfailed"; exit 1)

