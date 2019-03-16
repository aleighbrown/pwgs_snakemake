#!/bin/sh
# properties = {"type": "single", "rule": "submit_pwgs", "local": false, "input": ["/data/browna6/evolution/pwgs/phyloinputs/egfr_exome/CL0038/CL0038_T3D_E.params.json", "/data/browna6/evolution/pwgs/phyloinputs/egfr_exome/CL0038/CL0038_T3D_E.cnvs.txt", "/data/browna6/evolution/pwgs/phyloinputs/egfr_exome/CL0038/CL0038_T3D_E.ssm.txt"], "output": ["/data/browna6/evolution/pwgs/pwgs_output/egfr_exome_bysample/CL0038/CL0038_T3D_E/trees.zip"], "wildcards": {"patient": "CL0038", "sample": "CL0038_T3D_E"}, "params": {"output_dir": "/data/browna6/evolution/pwgs/pwgs_output/egfr_exome_bysample/CL0038/CL0038_T3D_E"}, "log": [], "threads": 4, "resources": {}, "jobid": 6, "cluster": {"partition": "norm", "time": 10, "extra": "--gres=lscratch:10"}}
cd /spin1/users/browna6/pwgs_snakemake && \
/usr/local/Anaconda/envs_app/snakemake/5.3.0/bin/python \
-m snakemake /data/browna6/evolution/pwgs/pwgs_output/egfr_exome_bysample/CL0038/CL0038_T3D_E/trees.zip --snakefile /spin1/users/browna6/pwgs_snakemake/run_pwgs.snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /spin1/users/browna6/pwgs_snakemake/.snakemake/tmp.1lvu3p__ /data/browna6/evolution/pwgs/phyloinputs/egfr_exome/CL0038/CL0038_T3D_E.params.json /data/browna6/evolution/pwgs/phyloinputs/egfr_exome/CL0038/CL0038_T3D_E.cnvs.txt /data/browna6/evolution/pwgs/phyloinputs/egfr_exome/CL0038/CL0038_T3D_E.ssm.txt --latency-wait 120 \
 --attempt 1 --force-use-threads \
--wrapper-prefix https://bitbucket.org/snakemake/snakemake-wrappers/raw/ \
  -p --nocolor \
--notemp --no-hooks --nolock --mode 2  --allowed-rules submit_pwgs  && touch "/spin1/users/browna6/pwgs_snakemake/.snakemake/tmp.1lvu3p__/6.jobfinished" || (touch "/spin1/users/browna6/pwgs_snakemake/.snakemake/tmp.1lvu3p__/6.jobfailed"; exit 1)

