# Random Forest for Genomic Association Detection

List of participants and affiliations:
- Weiping Chen (NIDDK) (Team Leader)
- Guanjie Chen (NHGRI) (Tech Lead)
- Qing Li (NHGRI) (Writer)
- Chimenya Ntweya (Queen Elizabeth Central hospital, Blantyre, Malawi)

## Project Goals
Use Random Forest (RF) to detect high-order interaction among genomic, omic features associated with the phenotype. 

## Approach
We use an example dataset with clinical phenotypes and rna-seq expression data for individuals. We apply RF to find the important features. Then, for downstream data exploration, we map the features using gene annotation in NCBI databases and create network representations for the interactions. 

## Results
The performance of feature selections / prediction module will be evaluated based on prediction error. Visualization of the gene networks or protein networks is done using Cytoscape. 

## Future Work
Add more omic features to improve the prediction of our RF model. 

## NCBI Codeathon Disclaimer
This software was created as part of an NCBI codeathon, a hackathon-style event focused on rapid innovation. While we encourage you to explore and adapt this code, please be aware that NCBI does not provide ongoing support for it.

For general questions about NCBI software and tools, please visit: [NCBI Contact Page](https://www.ncbi.nlm.nih.gov/home/about/contact/)

