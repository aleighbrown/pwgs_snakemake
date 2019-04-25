configfile: "config.yaml"

include: "helpers.py"
#include: "facets.snakefile"
# if config["multisample"] == True:
#         include: "phyloWGSparsing_multi.snakefile"
# else:
#         include: "phyloWGSparsing.snakefile"

# include: "run_pwgs.snakefile"


DATA = pd.read_csv(config["sampleCSVpath"])

PATIENTS = DATA['patient'].tolist()
SAMPLES = DATA["sample"].tolist()

print(PATIENTS)

rule all:
        input:
               expand(config["outputdirWitness"] + "{patient}/{sample}.mutass.zip", zip, patient=PATIENTS, sample=PATIENTS),
               expand(config["outputdirWitness"] + "{patient}/{sample}.muts.json",zip, patient=PATIENTS, sample=PATIENTS),
               expand(config["outputdirWitness"] + "{patient}/{sample}.summ.json", zip, patient=PATIENTS, sample=PATIENTS)

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
               config["outputdirWitness"] + "{patient}/{sample}.mutass.zip",
               config["outputdirWitness"] + "{patient}/{sample}.muts.json",
               config["outputdirWitness"] + "{patient}/{sample}.summ.json"

        run:
                shell("mkdir -p {params.witness_fold}")
                shell("cp `find {params.pwgs_fold}{wildcards.patient} -name '*.gz' -print` {params.witness_fold}")
                shell("cp `find {params.pwgs_fold}{wildcards.patient} -name '*.mutass.zip' -print` {params.witness_fold}")

                shell("gunzip -f {params.witness_fold}{wildcards.sample}*.gz")

                shell("python2 /data/browna6/evolution/pwgs/pwgs_output/witness/index_data.py")
