import pandas as pd

def getPurity(wildcard):

    data = pd.read_csv(wildcard, nrows=1)
    return(float(data["Purity"]))

def getPatient(wildcard):
	return(DATA.loc[DATA['sample'] == wildcard,"patient"].values[0])

def getFileType(wildcard):
	return(DATA.loc[DATA['sample'] == wildcard,"cnv_file_type"].values[0])

def getTumorBam(wildcard):
	return(DATA.loc[DATA['sample'] == wildcard,"tumor_bam"].values[0])

def getNormalBAM(wildcard):
	return(DATA.loc[DATA['sample'] == wildcard,"normal_bam"].values[0])

def getVCFFILE(wildcard):
    return(DATA.loc[DATA['sample'] == wildcard,"vcf_file"].values[0])

def getParsedVCFs(wildcard, phyloInput):
    samp = DATA.loc[DATA['patient'] == wildcard,"sample"].values.tolist() 
    r = [phyloInput + s +".passed.somatic.snvs_indels_snpEff_on_exome_combined.vcf" for s in samp]
    return(r, samp)

#returns 2 lists of matched parsed cnv files and  given the patient as input    
def getParsedCNVs(wildcard, phyloInput):
    samp = DATA.loc[DATA['patient'] == wildcard,"sample"].values.tolist() 
    r = [phyloInput + wildcard + "/" + s +"_cnvInput.txt" for s in samp]
    return(r, samp)
#returns 2 lists of matched sample vcf type given the patient as input    
def getVCFtypes(wildcard):
    samp = DATA.loc[DATA['patient'] == wildcard,"sample"].values.tolist() 
    r = [DATA.loc[DATA['sample'] == s,"vcf_file_type"].values[0] for s in samp]
    return(r, samp)

def makeCNVparam(wildcard, phyloinputdir):
    cmd = []
    
    cnv, samps = getParsedCNVs(wildcard, phyloinputdir)
    for idx, s in enumerate(cnv):
        cmd += ['--cnvs', '%s=%s' % (samps[idx], s)]

    return(cmd)

def makeVCFparam(wildcard, phyloinputdir):
    cmd = []
    
    vcfs, samps = getParsedVCFs(wildcard, phyloinputdir)
    for idx, s in enumerate(vcfs):
        cmd += ['%s=%s' % (samps[idx], s)]

    return(cmd)


def makeVCFtypesParam(wildcard):
    cmd = []
    
    vcf_types, samps = getVCFtypes(wildcard)
    for idx, s in enumerate(vcf_types):
        cmd += ['--vcf-type', '%s=%s' % (samps[idx], s)]
    return(cmd)


#this function is for taking our unique vcf input type, which is a combined Strelka file of both indels and point mutations, and writing it into something which the added class to the parser can read
def writePrettyVCFs(wildcard, phyloInput, sample):

    (wc_path,) = wildcard
    current = pd.read_csv(wc_path, sep = "\t")
    df1 = current[['CHROM','POS',"ID","REF","ALT","REF_TUMOR","ALT_TUMOR"]]
    #t_alt_count=83;t_ref_count=143
    df1['INFO'] = "t_alt_count=" + df1['ALT_TUMOR'].astype(str) + ";t_ref_count=" + df1['REF_TUMOR'].astype(str)
    df1 = df1.drop(['ALT_TUMOR', 'REF_TUMOR'], axis=1)
    df1["QUAL"] = "."
    df1["FILTER"] = "."
    df1 = df1.rename(columns={"CHROM": "#CHROM"})
    filePath = "{phyloInput}/{sample}.passed.somatic.snvs_indels_snpEff_on_exome_combined.vcf".format(sample=sample, phyloInput=phyloInput)
    df1 = df1[['#CHROM', 'POS', 'ID', 'REF', 'ALT',"QUAL","FILTER","INFO"]]

    df1.to_csv(filePath, sep = "\t", index=False)
    return(df1)
