# Provides the sources and steps required to collect data to input into R
2016-02-07
B. Sutherland (Lab Bernatchez, U. Laval)

*Note*: Follow steps exactly to ensure compatibility with the formatting script in R.

The following species will be collected for the final analysis:
Coho Salmon O. kisutch (Kodama et al. 2014)
Chinook Salmon O. tshawytscha (Brieuc et al. 2014)
Rainbow Trout O. mykiss (Palti et al. 2015)
Chum Salmon O. keta (Waples et al. 2015)
Sockeye Salmon O. nerka (Larson et al. 2016)
Brook Charr S. fontinalis (Sutherland et al. current work)
Atlantic Salmon S. salar (Lien et al. 2011)
Lake Whitefish C. clupeaformis (Gagnaire et al. 2013)
Northern Pike E. lucius (Rondeau et al., 2014)


1. Coho Salmon O. kisutch (Kodama et al. 2014)
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


2. Chinook Salmon O. tshawytscha (Brieuc et al. 2014)
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


3. Rainbow Trout O. mykiss (Palti et al. 2015)
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

###

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

###
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

#######

4. Chum Salmon O. keta (Waples et al. 2015) (note: still to complete documentation on data collection; specifically the sequence file; currently using: Map2-revised.txt)
Go to the following website for supplemental files:
http://onlinelibrary.wiley.com/doi/10.1111/1755-0998.12394/suppinfo
Download:
File Appendix S3 Linkage mapping. (men12394-sup-0003-AppendixS3.zip) and decompress
Rename and save Map2.txt: 02_raw_data/waples_etal2015_map.csv

File (to be added)
map file = waples_etal2015_map2-revised.txt 
# seq file = waples2015_loci-P1_consensus.csv

# This collection description will have to be added at a later date


5. Sockeye Salmon O. nerka (Larson et al. 2016)
Go to 
Download:
Map and seq file in one file: Table S1
larson_etal2015_table_s1_male_and_female_map_info.csv
Remove NAs and rename:
grep -vE 'NA|reviously' larson_etal2015_table_s1_male_and_female_map_info.csv > larson_etal2015_map_and_seq.csv


6. Brook Charr S. fontinalis (Sutherland et al. present study)
Go to the following website for supplemental files, includes map and seq:
additional_fileS2_sfon_female_map.csv


7. Atlantic Salmon S. salar (Lien et al. 2011)
Go to the following website:
http://bmcgenomics.biomedcentral.com/articles/10.1186/1471-2164-12-615
Download Additional file 1 (12864_2011_3813_MOESM1_ESM.xls)
Open and save out sheet one that contains both map position and seq as lien_etal2011_map_and_seq.csv
Then remove PC newline character
flip -u lien_etal2011_map_and_seq.csv


8. Lake Whitefish C. clupeaformis (Gagnaire et al. 2013)
Both the map file and the seq file can be found at:
http://onlinelibrary.wiley.com/doi/10.1111/mec.12127/full
Download: Table S2
mec12127-sup-0004-TableS2.xls

Open in excel, delete lines up to the header, then save out as:
gagnaire_etal2013_map_and_seq.csv


10. E. lucius microsatellite (Rondeau et al., 2014)
Go to the following website and download
http://journals.plos.org/plosone/article?id=10.1371/journal.pone.0102089#s5
Table S7. doi:10.1371/journal.pone.0102089.s009
Delete the first line leaving the first line as the header, and save out the sheet as
rondeau_etal2014_map_and_seq.csv


Finally, move all files containing either *map* or *seq* into the 03_prepared_data/ folder
cp 02_raw_data/01_collecting_from_websites/*map* ./03_prepared_data/
cp 02_raw_data/01_collecting_from_websites/*seq* ./03_prepared_data/