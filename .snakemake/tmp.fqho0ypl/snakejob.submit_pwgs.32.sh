#!/bin/sh
# properties = {"type": "single", "rule": "submit_pwgs", "local": false, "input": ["/data/browna6/evolution/pwgs/phyloinputs/egfr_editedCopy2/CL0038_2/CL0038_2.params.json", "/data/browna6/evolution/pwgs/phyloinputs/egfr_editedCopy2/CL0038_2/CL0038_2.cnvs.txt", "/data/browna6/evolution/pwgs/phyloinputs/egfr_editedCopy2/CL0038_2/CL0038_2.ssm.txt"], "output": ["/data/browna6/evolution/pwgs/pwgs_output/egfr_editedCopy2/CL0038_2/CL0038_2/trees.zip"], "wildcards": {"patient": "CL0038_2", "sample": "CL0038_2"}, "params": {"output_dir": "/data/browna6/evolution/pwgs/pwgs_output/egfr_editedCopy2/CL0038_2/CL0038_2", "pwgs_python_directory": "/home/browna6/phylowgs/", "n_chains": 5, "r1": 413, "r2": 473, "r3": 750, "r4": 355, "r5": 966}, "log": [], "threads": 5, "resources": {}, "jobid": 32, "cluster": {"partition": "norm", "time": 10, "extra": "--gres=lscratch:10"}}
cd /spin1/users/browna6/pwgs_snakemake && \
/usr/local/Anaconda/envs_app/snakemake/5.4.0/bin/python3.6 \
-m snakemake /data/browna6/evolution/pwgs/pwgs_output/egfr_editedCopy2/CL0038_2/CL0038_2/trees.zip --snakefile /spin1/users/browna6/pwgs_snakemake/run_full_pipeline.snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /spin1/users/browna6/pwgs_snakemake/.snakemake/tmp.fqho0ypl /data/browna6/evolution/pwgs/phyloinputs/egfr_editedCopy2/CL0038_2/CL0038_2.params.json /data/browna6/evolution/pwgs/phyloinputs/egfr_editedCopy2/CL0038_2/CL0038_2.cnvs.txt /data/browna6/evolution/pwgs/phyloinputs/egfr_editedCopy2/CL0038_2/CL0038_2.ssm.txt --latency-wait 120 \
 --attempt 1 --force-use-threads \
--wrapper-prefix https://bitbucket.org/snakemake/snakemake-wrappers/raw/ \
  -p --nocolor \
--notemp --no-hooks --nolock --mode 2  --allowed-rules submit_pwgs  && touch "/spin1/users/browna6/pwgs_snakemake/.snakemake/tmp.fqho0ypl/32.jobfinished" || (touch "/spin1/users/browna6/pwgs_snakemake/.snakemake/tmp.fqho0ypl/32.jobfailed"; exit 1)

