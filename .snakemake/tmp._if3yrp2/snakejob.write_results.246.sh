#!/bin/sh
# properties = {"type": "single", "rule": "write_results", "local": false, "input": ["/data/browna6/evolution/pwgs/pwgs_output/egfr_exome_bysample/CL0088/CL0088_T2D_E/trees.zip"], "output": ["/data/browna6/evolution/pwgs/pwgs_output/egfr_exome_bysample/CL0088/CL0088_T2D_E/CL0088_T2D_E.mutass.zip", "/data/browna6/evolution/pwgs/pwgs_output/egfr_exome_bysample/CL0088/CL0088_T2D_E/CL0088_T2D_E.muts.json.gz", "/data/browna6/evolution/pwgs/pwgs_output/egfr_exome_bysample/CL0088/CL0088_T2D_E/CL0088_T2D_E.summ.json.gz"], "wildcards": {"patient": "CL0088", "sample": "CL0088_T2D_E"}, "params": {}, "log": [], "threads": 1, "resources": {}, "jobid": 246, "cluster": {"partition": "norm", "time": 10, "extra": "--gres=lscratch:10"}}
cd /spin1/users/browna6/pwgs_snakemake && \
/usr/local/Anaconda/envs_app/snakemake/5.4.0/bin/python3.6 \
-m snakemake /data/browna6/evolution/pwgs/pwgs_output/egfr_exome_bysample/CL0088/CL0088_T2D_E/CL0088_T2D_E.mutass.zip --snakefile /spin1/users/browna6/pwgs_snakemake/run_full_pipeline.snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /spin1/users/browna6/pwgs_snakemake/.snakemake/tmp._if3yrp2 /data/browna6/evolution/pwgs/pwgs_output/egfr_exome_bysample/CL0088/CL0088_T2D_E/trees.zip --latency-wait 120 \
 --attempt 1 --force-use-threads \
--wrapper-prefix https://bitbucket.org/snakemake/snakemake-wrappers/raw/ \
  -p --nocolor \
--notemp --no-hooks --nolock --mode 2  --allowed-rules write_results  && touch "/spin1/users/browna6/pwgs_snakemake/.snakemake/tmp._if3yrp2/246.jobfinished" || (touch "/spin1/users/browna6/pwgs_snakemake/.snakemake/tmp._if3yrp2/246.jobfailed"; exit 1)

