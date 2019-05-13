configfile: "config.yaml"
include: "helpers.py"
import sys

#include: "facets.snakefile"

#use pandas to read in the samples and the patients


DATA = pd.read_csv(config["sampleCSVpath"])


PATIENTS = DATA['patient'].tolist()

SAMPLES = DATA["sample"].tolist()

VCF_FILES = DATA["vcf_file"].tolist()


#use the zip command to correctly expand the relationship between patient and sample
rule first_parse:
	input:
		expand(config["outputdirPhyloInput"] +"{patient}/{sample}_cnvInput.txt", zip, patient=PATIENTS, sample=SAMPLES),
		expand(config["outputdirPhyloInput"]+ "{sample}.passed.somatic.snvs_indels_snpEff_on_exome_combined.vcf", zip, patient=PATIENTS, sample=SAMPLES),

rule run_cnv_parsing:
	input:
		cnv_file=config["cnv_files_folder"] + "{sample}.snppile.csv.gz_fitted.csv"
	params:
		purity = lambda wildcards: getPurity(config["cnv_files_folder"] + "{samp}.snppile.csv.gz_fitted.csv".format(samp = wildcards.sample)),
		patientFolder = lambda wildcards: getPatient(wildcards.sample),
		fileType = lambda wildcards: getFileType(wildcards.sample),
		outputdir = config["outputdirPhyloInput"]
	output:
		config["outputdirPhyloInput"] +"{patient}/{sample}_cnvInput.txt"
	run:
		shell("python2 /data/browna6/pwgs_snakemake/parse_cnvs_facets_extension.py -f {params.fileType} -c {params.purity} --cnv-output {params.outputdir}{wildcards.patient}/{wildcards.sample}_cnvInput.txt {input}")

rule run_pretty_vcf:
	input:
		vcf_file = lambda wildcards: getVCFFILE(wildcards.sample)
	output:
		config["outputdirPhyloInput"]+ "{sample}.passed.somatic.snvs_indels_snpEff_on_exome_combined.vcf"
	run:
		writePrettyVCFs({input.vcf_file}, config["outputdirPhyloInput"], wildcards.sample)

