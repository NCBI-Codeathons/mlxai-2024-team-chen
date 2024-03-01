# Random Forest for Genomic Association Detection

List of participants and affiliations: - Weiping Chen (NIDDK) (Team Leader) - Guanjie Chen (NHGRI) (Tech Lead) - Qing Li (NHGRI) (Writer) - Chimenya Ntweya (Queen Elizabeth Central hospital, Blantyre, Malawi)

## Project Goals

Use Random Forest (RF) to detect high-order interaction among genomic, omic features associated with the phenotype.

## Approach

We use an example dataset with clinical phenotypes and rna-seq expression data for individuals. We apply RF to find the important features. Then, for downstream data exploration, we map the features using gene annotation in NCBI databases and create network representations for the interactions.

1.  Apply Random Forest approach to identify genomic, omic features associated with traits such as COVID and hypertension.
2.  Explore different modeling approach to test the perdition from the model and robust inference about top predictors.
3.  Query the GWAS catalogue and STRING-DB to generate gene network related to hypertension.

## Introduction of our study of interests

Since the start of the COVID pandemic, scientist and clinicians have struggled to understand COVID, and identified risk factors, such as age, obesity, sex, hypertension, and diabetes. Machine learning is widely used in biomedical research. Researchers used machine learning identified over 1000 genes related COVID-19.

### Study samples

Individuals with RNA-seq data are selected from a large hypertension study. During pandemic, requested telephone interview for COVID questions. RNA-seq data were based on blood tissue from 328 unrelated African American individuls from the Wasthington D.C. area. All the clinical and RNA-seq data are filter and passed quality control. Out of 34,885 genes, We restricted our analysis to 30,839 genes(protein coding or non-coding genes with nonzero median expression)

## Results

The performance of feature selections / prediction module will be evaluated based on prediction error. 

### RF results for COVID risk  

1. Adjust for gender, age, BMI, hypertension (binary) , and Type II diabetes status in the RF model. 

2. Number of RNA-seq = 30,839 

3. Prediction error= 0.411 (num.tree=17000, mtry=150)
For details, please refer to RandomForest_CovidModel.md

### RF results for hypertension risk

1. Adjust for gender, age, BMI, covid (binary) , and Type II diabetes status in the RF model.
2. Number of RNA-seq = 30,839
3. Prediction error= 0.216 (num.tree=17000, mtry=200)
For details, please refer to RandomForest_HTNModel.md

### Network results
Visualization of the gene networks or protein networks is done using Cytoscape. (<https://cytoscape.org/>)
For details, please refer to PhenoGenoI_analysis.md


## Lessons learned on RF
In term of modelling, it is highly recommended to includ the known risk factors and confounders as covariates. For the majority of RNA-seq, its prediction is poor on its own. 

It is necessary to fine turn the training parameters to increase model search space to detect interactions. Mutliple runs of RF may needed to evaluate the robustness of the results. 

We have to be creative to model joint effect of RNA-seq data from multiple genes. 

## Future Work

### Streamline integration of metadata from other databases
Use API and automation extraction tools to mapped genomic variants with annotation, with other databases such as GEO, GTEx databases to perform enrichment, and other statistical functional validation

### Extension of RF 
1. For BigData, we may need to integrate diversified data type as predictors 
2. Test out cloud predictive model for large samples, but have to propertly adjusted for relatedness in the sample

## NCBI Codeathon Disclaimer

This software was created as part of an NCBI codeathon, a hackathon-style event focused on rapid innovation. While we encourage you to explore and adapt this code, please be aware that NCBI does not provide ongoing support for it.

For general questions about NCBI software and tools, please visit: [NCBI Contact Page](https://www.ncbi.nlm.nih.gov/home/about/contact/)
