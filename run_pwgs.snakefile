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
		r1 = random.randint(1,1000),
		r2 = random.randint(1,1000),
		r3 = random.randint(1,1000),
		r4 = random.randint(1,1000),
		r5 = random.randint(1,1000)
	output:
		config['outputdirPhyloOutput'] + "{patient}/{sample}/" + "trees.zip"
	threads:
		5
	shell:
		"python2 {params.pwgs_python_directory}multievolve.py -O {params.output_dir} -r {params.r1} {params.r2} {params.r3} {params.r4} {params.r5} --num-chains {params.n_chains} --ssms {input.ssm_parsed} --cnvs {input.cnv_parsed} --params {input.params_json}"
