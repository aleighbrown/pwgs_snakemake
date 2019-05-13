# pwgs_snakemake
Snakemake pipeline for running PhyloWGS on NIH Biowulf Cluster
Currently set up to run on copy number calls by FACETS, https://github.com/mskcc/facets, using a parser with an additional FACETS class. Theoretically it should be able to run on any kind of copy number if the appropiate changes are made. 

Also runs on a vcf file that includes both indels and ssms mushed into one with a parser for making it into a useful file for PhyloWGS. Original PhyloWGS software here: https://github.com/morrislab/phylowgs

This is a very rough pipeline, which was pratically built as an excercise in learning snakemake, so if you're looking for a good way to build a snakemake pipeline, don't follow this one. 

But it does have a couple of features which might be useful, including a tree parser which PhyloWGS doesn't include in their software. 

Importantly you should be able to get everything set up by editing just the config file and the samples.csv, but there's a couple of instances where I've hard coded paths, which might need to be edited. 



Submit on a slurm cluster using the command:
`sbatch --cpus-per-task=20 --time=20:00:00 snakemake.sh`

For an SGE cluster, you'd want a slightly different configuration for the snakemake.sh file. See my "rna_seq_snakemake" repo for an example 
