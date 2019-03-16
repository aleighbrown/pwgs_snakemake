configfile: "config.yaml"

include: "helpers.py"
#include: "facets.snakefile"
#include: "phyloWGSparsing.snakefile"
import random
print(config["outputdirPhyloInput"])

DATA = pd.read_csv(config["sampleCSVpath"])
PATIENTS = DATA['patient'].tolist()
SAMPLES = DATA["sample"].tolist()

if config["multisample"] == True:
	rule tree_output_ms:
		input:
			expand(config['outputdirPhyloOutput'] + "{patient}/{sample}/" + "trees.zip", zip, patient=PATIENTS, sample=PATIENTS)
else:
	rule tree_output:
		input:
			expand(config['outputdirPhyloOutput'] + "{patient}/{sample}/" + "trees.zip", zip, patient=PATIENTS, sample=SAMPLES)

rule submit_pwgs:
	input:
		params_json =lambda wildcards: config["outputdirPhyloInput"] + "{patient}/{sample}.params.json",
		cnv_parsed = lambda wildcards: config["outputdirPhyloInput"] + "{patient}/{sample}.cnvs.txt",
		ssm_parsed = lambda wildcards: config["outputdirPhyloInput"] + "{patient}/{sample}.ssm.txt"
	params:
		output_dir = config['outputdirPhyloOutput'] + "{patient}/{sample}",
		pwgs_python_directory = config["pwgsPythonDir"],
		n_chains = config["n_chains"],
		chain_starts = make_chains(config["n_chains"])
	output:
		config['outputdirPhyloOutput'] + "{patient}/{sample}/" + "trees.zip"
	threads:
		5
	shell:
		"python2 {params.pwgs_python_directory}multievolve.py -O {params.output_dir} {params.chain_starts} --num-chains {params.n_chains} --ssms {input.ssm_parsed} --cnvs {input.cnv_parsed} --params {input.params_json}"
