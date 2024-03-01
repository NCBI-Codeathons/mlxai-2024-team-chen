## This file shows an example to run Random Forest approach for your data
## This is an R script

############## Biowulf #################
## to run this on biowulf, in swarm file(myswarmfile), have the line as following
#--------------------
# R --no-save --args /lscratch/$SLURM_JOB_ID/ < rscp_example_rf.R > rout_rf.rout
#--------------------

## submit your jobs
## swarm -f myswarmfile --module R --time=12:00:00 --gres=lscratch:50 -t 4 -g 20
############## Biowulf ------------------

## For RF package ranger, https://cran.r-project.org/web/packages/ranger/index.html


library("stringr")
library(ranger)

args = commandArgs(TRUE)
print(paste(args, collaps="; "))

scrachDir = args[[1]]  ## tmp directory to keep output files

print("input variables.....")
print(scratchDir) 
print("input variables_____")


################# INPUT #######################
## first column is Y, following columns are predictors
dd.ori = read.table("../example/pheno_toRF_data.txt", header=T, sep=" ",  as.is=T)

## setup the input file
dd.ori[,1] = dd.ori[,1]-1  ## change Y from (1,2) to (0,1) $$ Y has to be 1 or 0

## TESTING, TESTING on small dataset
dd.test = dd.ori 
dd.test = dd.ori[, 1:4001]  ##!!!!@@ Be sure to commend out this line for real RUN!!!!

## rename the feature name (indepdent variables, predictors, covariates) using index
colct = ncol(dd.test) -1
colnames(dd.test)=c("Y", paste("v_", 1:colct, sep=""))
################# INPUT -------------------



################# OUTPUT #######################
## Set up output file to keep the RF results
prefix = "firstRF"

out.split = paste(scrachDir, prefix, "_rf_split.csv", sep="")
out.pred  = paste(scrachDir, prefix, "_rf_pred.csv", sep="")
out.impor = paste(scrachDir, prefix, "_rf_impor.csv", sep="")

colnames.reImpor = c("ranSeed", "treeP", "mtry", "splitVar", "importance")
colnames.rePred = c("ranSeed", "treeP", "mtry", "predErr")
colnames.reSplit = c("ranSeed", "treeP", "mtry", "treeId", "splitVar", "splitVal")

## clean the workplace of output 
#file.remove(c(out.impor, out.pred, out.split))

cat( paste(colnames.reImpor, collapse=","), file=out.impor, fill=T, append=FALSE)
cat( paste(colnames.rePred, collapse=","), file=out.pred, fill=T, append=FALSE)
cat( paste(colnames.reSplit, collapse=","), file=out.split, fill=T, append=FALSE)
################# OUTPUT -------------------


################# RUN-RUN ##################
seed.base = 10^6+12300

##$$$$!!!!!! Random Forest parameter !!!!$$$$$$
## term: features: indepdent variables, predictors, covariates
## need to experience with tuning parameters
## treeCt -> parameter num.tree, # number of trees, how many times to run the classification tree
## tryCt -> parameter mtry, # of features to pull in each run, for laeege number of features usually set as sqrt(n),
## where n is the nubmer of features in the original dataset.

treeCt = 8000
mtry = 100 ## put a small number to start
forest = ranger( dependent.variable.name="Y", data = dd.test, classification=T, importance="impurity",num.tree=treeCt, mtry=tryCt)

## extract tree info for downstream analysis
## report split values for splitting variables for each tree
for( tt in 1:treeCt){
    infoM = treeInfo(forest, tree =tt)
    maSplit = cbind(seed.base+it, treeCt, tryCt, tt, infoM$splitvarName, infoM$splitval)
    maSplit = maSplit[ !is.na(maSplit[,6]), ,drop=F]
    if(nrow(maSplit)>0){
        write.table(maSplit, out.split, col.names=FALSE, row.names=FALSE, append=T, sep=",", quote=FALSE)
    }
    #reSplit = rbind(reSplit, maSplit)
}
## write out the predition error for the forest
sum_prediction = c(seed.base, treeCt,  tryCt, forest$prediction.error)
## just need to write out the line in the output file
cat( paste(sum_prediction, collapse=","), file=out.pred, append=T, fill=T)

## write out the var importance for the forest
f.impor = forest$variable.importance
sum_impor = cbind(seed.base, treeCt, tryCt, names(f.impor), f.impor)
write.table(re.impor, out.impor, col.names=FALSE, row.names=FALSE, append=T, sep=",", quote=FALSE)


################# RUN-RUN ------------------------

## move the output from scratch dir to current directory
print(list.files(scrachDir))
file.copy(from =c(out.impor, out.pred, out.split), to=".")

