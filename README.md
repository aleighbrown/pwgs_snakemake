# pwgs_snakemake
Snakemake pipeline for running PhyloWGS on NIH Biowulf Cluster
Currently set up to run on copy number calls by FACETS, https://github.com/mskcc/facets, using a parser with an additional FACETS class. Theoretically it should be able to run with any kind of copy number caller if the appropiate changes are made. 

Also runs on a vcf file that includes both indels and ssms mushed into one with a parser for making it into a useful file for PhyloWGS. Original PhyloWGS software here: https://github.com/morrislab/phylowgs

Features which might be useful include a tree parser which PhyloWGS doesn't include in their software, an additional classes for a "StrelkaCombinedParser" which will parse a VCF containing both indels and SSMs produced by combining the strelka.snv and strelk.indel files, as well as FACETs copy number caller.  

Importantly you should be able to get everything set up by editing just the config file and the samples.csv, but there's a couple of instances with hard coded paths, which might need to be edited. 

samples.csv should look like this

|patient	|sample	|cnv_file_type	|vcf_file	|vcf_file_type|
|---------|-------|--------------|----------|-------------|
|patient_a|	one_a|	battenberg	|/path/to/vcf/one_a.vcf	|sanger
|patient_a|	two_a|	battenberg-smchet	|/path/to/vcf/two_a.vcf	|mutect_pcawg
|patient_a|	three_a|	titan	|/path/to/vcf/three_a.vcf	|mutect_smchet
|patient_b|	one_b|	facets	|/path/to/vcf/one_b.vcf	|strelka_indelcombined
|patient_b|	two_b|	facets	|/path/to/vcf/two_b.vcf	|vardict

See the cnv parser and original Phylowgs parser README for the valid types of cnv_file_type and vcf_file_type. 
To add an additional file type for the parsers, extend the relevant classes in `parse_cnvs_facets_extension.py` and `create_phylowgs_inputs.py`.

Submit on a slurm cluster using the command:
`sbatch --cpus-per-task=20 --time=20:00:00 snakemake.sh`

For an SGE cluster, you'd want a slightly different configuration for the snakemake.sh file. See my "rna_seq_snakemake" repo for an example 
