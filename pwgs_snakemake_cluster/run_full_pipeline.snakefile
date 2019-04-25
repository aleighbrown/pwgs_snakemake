configfile: "config.yaml"

include: "helpers.py"
#include: "facets.snakefile"
if config["multisample"] == True:
	include: "phyloWGSparsing_multi.snakefile"
else:
	include: "phyloWGSparsing.snakefile"

include: "run_pwgs.snakefile"


DATA = pd.read_csv(config["sampleCSVpath"])

PATIENTS = DATA['patient'].tolist()
SAMPLES = DATA["sample"].tolist()

if config["multisample"] == True:
	rule all:
		input:
			expand(config["parsedOutputPWGS"] + "{patient}/{sample}/tree_likelihoods.txt", zip, patient=PATIENTS, sample=PATIENTS)
else:
	rule all:
		input:
			expand(config["parsedOutputPWGS"] + "{patient}/{sample}/tree_likelihoods.txt", zip, patient=PATIENTS, sample=SAMPLES)

rule write_results:
	input:
		lambda wildcards: config['outputdirPhyloOutput'] + "{patient}/{sample}/" + "trees.zip"
	output:
		mutass_zip = config["outputdirPhyloOutput"] + "{patient}/{sample}/{sample}.mutass.zip",
		muts_json_gz = config["outputdirPhyloOutput"] + "{patient}/{sample}/{sample}.muts.json.gz",
		summ_json_gz = config["outputdirPhyloOutput"] + "{patient}/{sample}/{sample}.summ.json.gz"

	shell:
		"python2 /home/browna6/phylowgs/write_results.py --allow-polyclonal --include-polyclonal {wildcards.sample} {input} {output.summ_json_gz} {output.muts_json_gz} {output.mutass_zip}"

rule move_and_unzip_files:
	input:
		mutass_file = lambda wildcards: config["outputdirPhyloOutput"] + "{patient}/{sample}/{sample}.mutass.zip",
		muts_json = lambda wildcards: config["outputdirPhyloOutput"] + "{patient}/{sample}/{sample}.muts.json.gz",
		summ_json = lambda wildcards: config["outputdirPhyloOutput"] + "{patient}/{sample}/{sample}.summ.json.gz"
	params:
		pwgs_python_directory = config["pwgsPythonDir"],
		pwgs_fold = config["outputdirPhyloOutput"],
		witness_fold = config["outputdirWitness"] + "{patient}/"

	output:
		mutass_file = config["outputdirWitness"] + "{patient}/{sample}.mutass.zip",
		muts_json = config["outputdirWitness"] + "{patient}/{sample}.muts.json",
		summ_json = config["outputdirWitness"] + "{patient}/{sample}.summ.json"

	run:
		shell("mkdir -p {params.witness_fold}")
		shell("cp `find {params.pwgs_fold}{wildcards.patient} -name '*.gz' -print` {params.witness_fold}")
		shell("cp `find {params.pwgs_fold}{wildcards.patient} -name '*.mutass.zip' -print` {params.witness_fold}")

		shell("gunzip -f {params.witness_fold}{wildcards.sample}*.gz")

		shell("python2 /data/browna6/evolution/pwgs/pwgs_output/witness/index_data.py")

rule run_final_parser_ms:
	input:
		cnv_input = lambda wildcards: config["outputdirPhyloInput"] + "{patient}/{sample}.cnvs.txt",
		ssm_input = lambda wildcards: config["outputdirPhyloInput"] + "{patient}/{sample}.ssm.txt",
		summary_file = lambda wildcards: config["outputdirWitness"] + "{patient}/{sample}.summ.json",
		mutasgn_path = lambda wildcards: config["outputdirWitness"] + "{patient}/{sample}.mutass.zip"
	params:
		output_parsed_pwgs_results = config['parsedOutputPWGS'],

		k_trees = config['k_trees']

	output:
		#dynamic(config['parsedOutputPWGS'] + "{patient}/{sample}/{treenumber}.csv"),
		config['parsedOutputPWGS'] + "{patient}/{sample}/tree_likelihoods.txt"
	run:
		shell('mkdir -p {params.output_parsed_pwgs_results}{wildcards.patient}/{wildcards.sample}')
		shell('python2 /data/browna6/pwgs_snakemake/parse_pwgs_output.py --k {params.k_trees} --cnv_input {input.cnv_input} --ssm_input {input.ssm_input} --summary_file {input.summary_file} --mutasgn_path {input.mutasgn_path} --output_folder {params.output_parsed_pwgs_results}{wildcards.patient}/{wildcards.sample}')







