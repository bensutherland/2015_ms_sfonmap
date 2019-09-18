# Websites and directions to obtain raw data  
2016-02-07
B. Sutherland (Lab Bernatchez, U. Laval)  

This is the first step from the README.md  

*Note*: Follow steps exactly to ensure compatibility with the formatting script in R.  

##Citations
The following species will be collected for the final analysis, please cite the following papers if you use the data:  
**Coho Salmon** *O. kisutch*  
Kodama M, Brieuc MSO, Devlin RH, Hard JJ, Naish KA. 2014. Comparative mapping between Coho Salmon (Oncorhynchus kisutch) and three other salmonids suggests a role for chromosomal rearrangements in the retention of duplicated regions following a whole genome duplication event. G3 - Genes|Genomes|Genetics. 4:1717–1730. doi: 10.1534/g3.114.012294.  
**Chinook Salmon** *O. tshawytscha*  
Brieuc et al. 2014. A dense linkage map for Chinook Salmon (Oncorhynchus tshawytscha) reveals variable chromosomal divergence following an ancestral whole genome duplication event. G3 - Genes|Genomes|Genetics. 4(3) pp. 447-460. ttps://doi.org/10.1534/g3.113.009316 
Naish KA et al. 2013. Comparative genome mapping between Chinook Salmon (Oncorhynchus tshawytscha) and Rainbow Trout (O. mykiss) based on homologous microsatellite loci. G3 - Genes|Genomes|Genetics. 3:2281–2288. doi: 10.1534/g3.113.008003.  
**Rainbow Trout** *O. mykiss*  
Palti Y et al. 2015. Detection and validation of QTL affecting bacterial cold water disease resistance in Rainbow Trout using restriction-site associated DNA sequencing Wang, H, editor. PLoS ONE. 10:e0138435. doi: 10.1371/journal.pone.0138435.  
**Chum Salmon** *O. keta*  
Waples RK, Seeb LW, Seeb JE. 2016. Linkage mapping with paralogs exposes regions of residual tetrasomic inheritance in Chum Salmon (Oncorhynchus keta). Mol. Ecol. Resour. 16:17–28. doi: 10.1111/1755-0998.12394.  
**Sockeye Salmon** *O. nerka*  
Larson WA et al. 2015. Identification of Multiple QTL Hotspots in Sockeye Salmon (Oncorhynchus nerka) Using Genotyping-by-Sequencing and a Dense Linkage Map. J. Hered. doi: 10.1093/jhered/esv099.  
**Brook Charr** *S. fontinalis*  
Sutherland BJG et al. 2016. Novel Method for Comparing RADseq Linkage Maps Reveals Chromosome Evolution in Salmonids. doi: 10.1101/039164.  
**Atlantic Salmon** *S. salar*  
Lien S et al. 2011. A dense SNP-based linkage map for Atlantic Salmon (Salmo salar) reveals extended chromosome homeologies and striking differences in sex-specific recombination patterns. BMC Genomics. 12:615. doi: 10.1186/1471-2164-12-615.  
**Lake Whitefish** *C. clupeaformis*  
Gagnaire P-A, Normandeau E, Pavey SA, Bernatchez L. 2013. Mapping phenotypic, expression and transmission ratio distortion QTL using RAD markers in the Lake Whitefish (Coregonus clupeaformis). Mol. Ecol. 22:3036–3048. doi: 10.1111/mec.12127.  
**Northern Pike** *E. lucius*  
Rondeau EB et al. 2014. The genome and linkage map of the Northern Pike (Esox lucius): conserved synteny revealed between the salmonid sister group and the Neoteleostei. PLoS ONE. 9:e102089. doi: 10.1371/journal.pone.0102089.  


## Directions for downloading data
### Coho Salmon O. kisutch (Kodama et al. 2014)  
Go to following website for supplemental files:  
http://www.g3journal.org/content/4/9/1717/suppl/DC1  
Download:  
File S1: Reference database of RAD loci for coho salmon  
File S2: Linkage maps  

Add 'kodama_etal2014_' to each filename to identify.  

Open kodama_etal2014_FileS1.xlsx and save out the first sheet:  
S1.1 - Non-duplicated_Loci  
as 'kodama_etal2014_seq.csv'  

Open kodama_etal2014_FileS2.xlsx and save out the first sheet:  
S2.1-Female (Haploid)  
as 'kodama_etal2014_map.csv'  


### Chinook Salmon O. tshawytscha (Brieuc et al. 2014)
Go to following website for supplemental files:  
http://www.g3journal.org/content/4/3/447/suppl/DC1  
Download:  
File S2: Database of RAD loci for Chinook salmon  
File S3: Linkage maps and mapped loci  

Add 'brieuc_etal2014_' to each filename to identify.  

Open brieuc_etal2014_FileS2.xlsx and save out the first sheet:  
S1.1 - Non-duplicated loci  
as 'brieuc_etal2014_seq.csv'  

Open brieuc_etal2014_FileS3.xlsx and save out the first sheet:  
S2.1 Consensus haploid map  
as 'brieuc_etal2014_map.csv'  


### Rainbow Trout O. mykiss (Palti et al. 2015)  
Go to following website for supplemental files:  
http://journals.plos.org/plosone/article?id=10.1371/journal.pone.0138435#sec018  
Note: this one is a little trickier:  
Download  
S1 File. Family 2009070 marker chromosome assignments and genetic maps.  
Rename as palti_etal2015_journal.pone.0138435.s001.XLSX  
The challenge here is that each linkage group is saved into a separate sheet in the excel document. To get around this, we will use the Virtual Basic Code given here:  
http://www.extendoffice.com/documents/excel/2972-excel-save-export-convert-multiple-all-sheets-to-csv-text.html  
Specifically, the section on 'Save, export or convert all sheets to csv or txt'  
As follows:

```
Sub ExportSheetsToCSV()
    Dim xWs As Worksheet
    Dim xcsvFile As String
    For Each xWs In Application.ActiveWorkbook.Worksheets
        xWs.Copy
        xcsvFile = xWs.Name & ".csv"
        Application.ActiveWorkbook.SaveAs Filename: = xcsvFile, _
        FileFormat: = xlCSV, CreateBackup: = False
        Application.ActiveWorkbook.Saved = True
        Application.ActiveWorkbook.Close
    Next
End Sub
```

Rename the following sheets:  
mv 1\)\ Map\ Summary.csv 01_map_summary.csv  
mv 2\)\ LGs_2-Point.csv 02_LGs_2_point.csv  
mv 3\)\ RAD\ SNP\ Sequences.csv palti_etal2015_seq.csv  

Then move all sheets (now .csv) to folder called 'palti_etal_separated_sheets'  

Use 'flip' to change from microsoft to linux form:  
flip -u *.csv  

Launch utility script to format the csv files into one map file:  
bash ./01_scripts/utility_scripts/prepare_palti.sh  

Now copy the necessary files back into the above directory and rename:  
cp 02_raw_data/01_collecting_from_websites/palti_etal_separated_sheets/palti_etal_map.csv ./02_raw_data/01_collecting_from_websites/palti_etal2015_map.csv  
cp 02_raw_data/01_collecting_from_websites/palti_etal_separated_sheets/03_RAD_SNP_sequences.csv ./02_raw_data/01_collecting_from_websites/palti_etal2015_seq.csv  

In conclusion, the data that will be used is:  
Sequence file: palti_etal2015_seq.csv  
Map file: palti_etal2015_map.csv  


### Chum Salmon O. keta (Waples et al. 2015)  
Go to the following website for supplemental files:  
http://onlinelibrary.wiley.com/doi/10.1111/1755-0998.12394/suppinfo  
Download:  
men12394-sup-0004-AppendixS4.zip  
then open P1_consensus.fasta, turn it into a .csv file with fasta name and fasta seq on the same line for each record. Save out as 'waples_etal2015_seq.csv'  

men12394-sup-0003-AppendixS3.zip  
then rename Map1.txt as 'waples_etal2015_map.txt'  

### Sockeye Salmon O. nerka (Larson et al. 2016)  
Go to  
Download:
Map and seq file in one file: Table S1
larson_etal2015_table_s1_male_and_female_map_info.csv
Remove NAs and rename:
grep -vE 'NA|reviously' larson_etal2015_table_s1_male_and_female_map_info.csv > larson_etal2015_map_and_seq.csv


### Brook Charr S. fontinalis (Sutherland et al. present study)  
Go to the following website for supplemental files, includes map and seq:  
additional_fileS2_sfon_female_map.csv


### Atlantic Salmon S. salar (Lien et al. 2011)  
Go to the following website:  
http://bmcgenomics.biomedcentral.com/articles/10.1186/1471-2164-12-615  
Download Additional file 1 (12864_2011_3813_MOESM1_ESM.xls)  
Open and save out sheet one that contains both map position and seq as lien_etal2011_map_and_seq.csv  
Then remove PC newline character  
flip -u lien_etal2011_map_and_seq.csv  


### Lake Whitefish C. clupeaformis (Gagnaire et al. 2013)  
Both the map file and the seq file can be found at:  
http://onlinelibrary.wiley.com/doi/10.1111/mec.12127/full  
Download: Table S2  
mec12127-sup-0004-TableS2.xls  

Open in excel, delete lines up to the header, then save out as:  
gagnaire_etal2013_map_and_seq.csv  


### E. lucius microsatellite (Rondeau et al., 2014)  
Go to the following website and download  
http://journals.plos.org/plosone/article?id=10.1371/journal.pone.0102089#s5  
Table S7. doi:10.1371/journal.pone.0102089.s009  
Delete the first line leaving the first line as the header,  
and Delete the other blocks of data under the first large block (should not be total of 526 records and a header), and save out the sheet as  
rondeau_etal2014_map_and_seq.csv  


## Final preparation of files    
move all files containing either *map* or *seq* into the 02_formatting_collected_data/ folder  
cp 02_raw_data/01_collecting_from_websites/*map* ./02_raw_data/02_formatting_collected_data/  
cp 02_raw_data/01_collecting_from_websites/*seq* ./02_raw_data/02_formatting_collected_data/  

Now move to the next step, as described in the README.md
