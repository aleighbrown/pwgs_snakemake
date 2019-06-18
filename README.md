# pwgs_snakemake
Snakemake pipeline for running PhyloWGS on NIH Biowulf Cluster
Currently set up to run on copy number calls by FACETS, https://github.com/mskcc/facets, using a parser with an additional FACETS class. Theoretically it should be able to run on any kind of copy number if the appropiate changes are made. 

Also runs on a vcf file that includes both indels and ssms mushed into one with a parser for making it into a useful file for PhyloWGS. Original PhyloWGS software here: https://github.com/morrislab/phylowgs

Features which might be useful include a tree parser which PhyloWGS doesn't include in their software. 

Importantly you should be able to get everything set up by editing just the config file and the samples.csv, but there's a couple of instances with hard coded paths, which might need to be edited. 



Submit on a slurm cluster using the command:
`sbatch --cpus-per-task=20 --time=20:00:00 snakemake.sh`

For an SGE cluster, you'd want a slightly different configuration for the snakemake.sh file. See my "rna_seq_snakemake" repo for an example 
