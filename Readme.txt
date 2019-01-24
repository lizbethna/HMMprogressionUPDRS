##################################################

Paper: 
A hidden Markov model addressing measurement errors in the response 
and replicated covariates for continuous nondecreasing processes

Authors:
Lizbeth Naranjo (1), Carlos J. Pérez (2),
Ruth Fuentes-García (1), Jacinto Martin (2)

(1) Universidad Nacional Autónoma de México, Mexico
(2) Universidad de Extremadura, Spain


Published in Biostatistics

##################################################

The following are the instructions to run the codes in R and JAGS. 
The codes reproduce the analysis presented in Section 5 ‘Application to the AHTD database’ of the paper. 

##################################################

##################################################
FILES 

The file ‘UPDRSprogression.R’ contains the R code. 

The JAGS codes are running from this R file.

The file ’HMMmodel.bug’ contains the JAGS model. 

The file ’HMMmodelSex.bug’ contains the JAGS model by sex.

The file ‘UPDRSdata.txt’ contains the data used in the paper. 

These data are a subset of the original data presented by Tsanas et al. (2010), which are available online in the AHTD database at the
UCI Machine Learning Repository (https://archive.ics.uci.edu/ml/datasets/Parkinson+Telemonitoring. The AHTD study was presented by Goetz et al. (2009).

##################################################

To run the files, do the following.
 
1.- Download JAGS from www.mcmc-jags.sourceforge.net/

2.- Install the packages necessary to run the R file. 
These are indicated in the R file. 

3.- Change the address indicated in ‘setwd()’. 
setwd("HERE"). This is the address where the files ‘HMMmodel.bug’ and “HMMmodelSex.bug’ are in.

4.- Read the data. The data file should be located in the indicated address.

6.- To fit the model for the complete data, use the file ‘HMMmodel.bug’.

7.- To fit the model by sex, use the file ‘HMMmodelSex.bug’.

##################################################
References

* Goetz, C. G., Stebbins, G. T., Wolff, D., DeLeeuw, W., Bronte-Stewart, H., Elble, R., Hallett, M., Nutt, J., Ramig, L., Sanger, T., Wu, A. D., Kraus, P. H., Blasucci, L. M., Shamim, E. A., Sethi, K. D., Spielman, J., Kubota, K., Grove, A. S., Dishman, E. and others. (2009). 
Testing objective measures of motor impairment in early Parkinson’s disease: Feasibility study of an at-home testing device. 
Movement Disorders 24(4), 551–556. 

* Tsanas, A., Little, M. A., McSharry, P. E. and Ramig, L. O. (2010). 
Accurate telemonitoring of Parkinson’s disease progression by non-invasive speech tests. IEEE Transactions Biomedical Engineering 57(4), 884–893. 

##################################################


