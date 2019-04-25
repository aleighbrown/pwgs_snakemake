#!/bin/sh
# properties = {"type": "single", "rule": "submit_pwgs", "local": false, "input": ["/data/GuhaData/pwgs/pwgs_inputs/RA7_39/CL0039/CL0039.params.json", "/data/GuhaData/pwgs/pwgs_inputs/RA7_39/CL0039/CL0039.cnvs.txt", "/data/GuhaData/pwgs/pwgs_inputs/RA7_39/CL0039/CL0039.ssm.txt"], "output": ["/data/GuhaData/pwgs/pwgs_output/RA7_39/CL0039/CL0039/trees.zip"], "wildcards": {"patient": "CL0039", "sample": "CL0039"}, "params": {"output_dir": "/data/GuhaData/pwgs/pwgs_output/RA7_39/CL0039/CL0039", "pwgs_python_directory": "/home/browna6/phylowgs/", "n_chains": 20, "chain_starts": "-r 4471 1748 7213 5162 8074 8116 8047 6492 5481 7009 8913 2683 986 5304 1489 1924 873 1796 1236 6034"}, "log": [], "threads": 20, "resources": {}, "jobid": 23, "cluster": {"partition": "norm", "time": 10, "extra": "--gres=lscratch:10"}}
cd /spin1/users/browna6/pwgs_snakemake && \
/usr/local/Anaconda/envs_app/snakemake/5.4.0/bin/python3.6 \
-m snakemake /data/GuhaData/pwgs/pwgs_output/RA7_39/CL0039/CL0039/trees.zip --snakefile /spin1/users/browna6/pwgs_snakemake/run_full_pipeline.snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /spin1/users/browna6/pwgs_snakemake/.snakemake/tmp.22mlqw7b /data/GuhaData/pwgs/pwgs_inputs/RA7_39/CL0039/CL0039.params.json /data/GuhaData/pwgs/pwgs_inputs/RA7_39/CL0039/CL0039.cnvs.txt /data/GuhaData/pwgs/pwgs_inputs/RA7_39/CL0039/CL0039.ssm.txt --latency-wait 120 \
 --attempt 1 --force-use-threads \
--wrapper-prefix https://bitbucket.org/snakemake/snakemake-wrappers/raw/ \
  -p --nocolor \
--notemp --no-hooks --nolock --mode 2  --allowed-rules submit_pwgs  && touch "/spin1/users/browna6/pwgs_snakemake/.snakemake/tmp.22mlqw7b/23.jobfinished" || (touch "/spin1/users/browna6/pwgs_snakemake/.snakemake/tmp.22mlqw7b/23.jobfailed"; exit 1)

