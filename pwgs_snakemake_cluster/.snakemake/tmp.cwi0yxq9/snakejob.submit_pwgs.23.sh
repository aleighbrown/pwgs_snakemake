#!/bin/sh
# properties = {"type": "single", "rule": "submit_pwgs", "local": false, "input": ["/data/GuhaData/pwgs/pwgs_inputs/RA7_39/CL0039/CL0039.params.json", "/data/GuhaData/pwgs/pwgs_inputs/RA7_39/CL0039/CL0039.cnvs.txt", "/data/GuhaData/pwgs/pwgs_inputs/RA7_39/CL0039/CL0039.ssm.txt"], "output": ["/data/GuhaData/pwgs/pwgs_output/RA7_39/CL0039/CL0039/trees.zip"], "wildcards": {"patient": "CL0039", "sample": "CL0039"}, "params": {"output_dir": "/data/GuhaData/pwgs/pwgs_output/RA7_39/CL0039/CL0039", "pwgs_python_directory": "/home/browna6/phylowgs/", "n_chains": 20, "chain_starts": "-r 7815 96 133 9413 3187 8718 4075 952 2955 3747 6982 3293 1830 6682 5625 7891 6448 6379 6266 3551"}, "log": [], "threads": 20, "resources": {}, "jobid": 23, "cluster": {"partition": "norm", "time": 10, "extra": "--gres=lscratch:10"}}
cd /spin1/users/browna6/pwgs_snakemake && \
/usr/local/Anaconda/envs_app/snakemake/5.4.0/bin/python3.6 \
-m snakemake /data/GuhaData/pwgs/pwgs_output/RA7_39/CL0039/CL0039/trees.zip --snakefile /spin1/users/browna6/pwgs_snakemake/run_full_pipeline.snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /spin1/users/browna6/pwgs_snakemake/.snakemake/tmp.cwi0yxq9 /data/GuhaData/pwgs/pwgs_inputs/RA7_39/CL0039/CL0039.params.json /data/GuhaData/pwgs/pwgs_inputs/RA7_39/CL0039/CL0039.cnvs.txt /data/GuhaData/pwgs/pwgs_inputs/RA7_39/CL0039/CL0039.ssm.txt --latency-wait 120 \
 --attempt 1 --force-use-threads \
--wrapper-prefix https://bitbucket.org/snakemake/snakemake-wrappers/raw/ \
  -p --nocolor \
--notemp --no-hooks --nolock --mode 2  --allowed-rules submit_pwgs  && touch "/spin1/users/browna6/pwgs_snakemake/.snakemake/tmp.cwi0yxq9/23.jobfinished" || (touch "/spin1/users/browna6/pwgs_snakemake/.snakemake/tmp.cwi0yxq9/23.jobfailed"; exit 1)

