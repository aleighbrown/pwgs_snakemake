configfile: "config.yaml"
include: "helpers.py"
import sys

include: "multi_vcfcnv.snakefile"

#use pandas to read in the samples and the patients


DATA = pd.read_csv(config["sampleCSVpath"])


PATIENTS = DATA['patient'].tolist()

SAMPLES = DATA["sample"].tolist()


#use the zip command to correctly expand the relationship between patient and sample
rule produce_phylo_input:
	input:
		expand(config["outputdirPhyloInput"] + "{patient}/{patient}.params.json", patient=PATIENTS),
		expand(config["outputdirPhyloInput"] + "{patient}/{patient}.ssm.txt", patient=PATIENTS),
		expand(config["outputdirPhyloInput"] + "{patient}/{patient}.cnvs.txt",patient=PATIENTS)

rule phylo_input_parsing:
	input:
		vcf_files = lambda wildcards: getParsedVCFs(wildcards.patient,config["outputdirPhyloInput"])[0],
		cnv_files = lambda wildcards: getParsedCNVs(wildcards.patient,config["outputdirPhyloInput"])[0]

		#lambda wildcards: config["outputdirPhyloInput"] +"{wildcards.patient}/{sample}_cnvInput.txt".format(samp = wildcards.sample)
	params:
		cnvs = lambda wildcards: makeCNVparam(wildcards.patient,config["outputdirPhyloInput"]),
		vcf_types = lambda wildcards: makeVCFtypesParam(wildcards.patient),
		vcf_listing = lambda wildcards: makeVCFparam(wildcards.patient,config["outputdirPhyloInput"]),
		subsampling = config['subsampling'],
		pipeline_folder = config['pipeline_folder']
	output:
		params_json = config["outputdirPhyloInput"] + "{patient}/{patient}.params.json",
		cnv_parsed = config["outputdirPhyloInput"] + "{patient}/{patient}.cnvs.txt",
		ssm_parsed = config["outputdirPhyloInput"] + "{patient}/{patient}.ssm.txt"
	shell:
		"python2 {params.pipeline_folder}create_phylowgs_inputs.py{params.subsampling}--regions all {params.cnvs} --output-cnvs {output.cnv_parsed} --output-variants {output.ssm_parsed} --output-params {output.params_json} {params.vcf_types} {params.vcf_listing}"
