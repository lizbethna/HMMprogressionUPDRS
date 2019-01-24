##################################################
### A hidden Markov model addressing measurement 
### errors in the response and replicated covariates for 
### continuous nondecreasing processes 
###
### Lizbeth Naranjo (1), Carlos J. Perez (2), 
### Ruth Fuentes-Garcia (1), Jacinto Martin (2).
###
### (1) Universidad Nacional Autonoma de Mexico, Mexico
### (2) Universidad de Extremadura, Spain
###
### Submitted to Biostatistics
##################################################

##################################################
### R packages
###
### Instructions: 
### Load the R libraries
##################################################
library(rjags)

##################################################

##################################################
### READ DATA
###
### Instructions: 
### Change the address where the data and codes are located. 
### setwd("HERE")
##################################################

setwd("~/FileDirectory/")

UPDRSdata <- read.table("UPDRSdata.txt", sep=";")

summary(UPDRSdata)
dim(UPDRSdata)
head(UPDRSdata)
attach(UPDRSdata)

### Motor UPDRS
Y.motor <- tapply(UPDRSmotor,list(subject,time),mean,simplify=TRUE)

### Total UPDRS
Y.total <- tapply(UPDRStotal,list(subject,time),mean,simplify=TRUE)

### Gender
Z <- tapply(sex,subject,mean,simplify=TRUE)

### Replicated covariates
X = array(NA,dim=c(42,3,6,6)) ###(subject,time,replication,covariate)  
for(i in 1:756){
  X[subject[i],time[i],replication[i],1] = Jitter.Abs.[i]
	X[subject[i],time[i],replication[i],2] = Shimmer[i]
	X[subject[i],time[i],replication[i],3] = HNR[i]
	X[subject[i],time[i],replication[i],4] = RPDE[i]
	X[subject[i],time[i],replication[i],5] = DFA[i]
	X[subject[i],time[i],replication[i],6] = PPE[i]
}

##################################################

##################################################
### FIT DATA 
### Motor UPDRS or Total UPDRS
### 
### Instructions:
### Choose the response variable Y, Total or Motor.
### Y.motor: Motor UPDRS
### Y.total: Total UPDRS 
###
### In the list 'data.hmm': 
### For Total UPDRS, comment Yobs=Y.motor, and uncomment Yobs=Y.total   
##################################################

### Data
data.hmm <- list(
  Yobs = Y.motor , 
###  Yobs = Y.total , 
  Xrep = X , 
  Z = Z ,
  N = 42 , 
  K = 3 , 
  J = 6 ,
  p = 6 ,
  VV = diag(1,6) ,
  vv = 6 ,
  b0 = rep(0,6) ,
  B0 = diag(0.0001,6) ,
  zeros = rep(0,6) ,
  diagonal = diag(1,6)
)

### Parameters
param.hmm <- c(
  "Alpha","Beta", "Gamma", "sigma", "tau"
)

### Initial Values
inits.hmm <- function(){	list(
  "Alpha" = rnorm(1,0,0.1) ,
  "Beta" = rnorm(6,0,0.1) , 
  "Gamma" = rnorm(1,0,0.1) ,
  "invsigma2" = 1 ,
  "invtau2" = 1 ,
  "invLambda" = diag(1,6)  
)	}

### Fit Model
fit.hmm <- jags.model("HMMmodel.bug", data.hmm, n.chains=3)

update(fit.hmm,10000)

sample.hmm <- coda.samples(fit.hmm, param.hmm,  n.iter=20000, thin=10)

### Summary & Graphics
plot(sample.hmm)
summary(sample.hmm)

##################################################

##################################################
### FIT DATA by Sex
###
### Instructions:
### Choose the response variable Y, Total or Motor.
### Y.motor: Motor UPDRS
### Y.total: Total UPDRS 
###
### Choose the gender, men or women.
### sex==0, Z==0: men
### sex==1, Z==1: women
### 
### In the list 'data.hmmsex': 
### For Total UPDRS, comment Yobs=Y.motor[Z==0,], and uncomment Yobs=Y.total[Z==0,]   
### For Women, replace Z==0 by Z==1
##################################################

### Data
data.hmmsex <- list(
  Yobs = Y.motor[Z==0,] ,  
###  Yobs = Y.total[Z==0,] ,   
  Xrep = X[Z==0,,,] ,   
  N = sum(Z==0) ,  
  K = 3 , 
  J = 6 ,
  p = 6 ,
  VV = diag(1,6) ,
  vv = 6 ,
  b0 = rep(0,6) ,
  B0 = diag(0.0001,6) ,
  zeros = rep(0,6) ,
  diagonal = diag(1,6)
)

### Parameters
param.hmmsex <- c(
  "Alpha","Beta", "sigma", "tau"
)

### Initial Values
inits.hmmsex <- function(){	list(
  "Alpha" = rnorm(1,0,0.1) ,
  "Beta" = rnorm(6,0,0.1) , 
  "invsigma2" = 1 ,
  "invtau2" = 1 ,
  "invLambda" = diag(1,6)  
)	}

### Fit Model
fit.hmmsex <- jags.model("HMMmodelSex.bug", data.hmmsex, n.chains=3)

update(fit.hmmsex,10000)

sample.hmmsex <- coda.samples(fit.hmmsex, param.hmmsex,  n.iter=30000, thin=10)

### Summary & Graphics
plot(sample.hmmsex)
summary(sample.hmmsex)

##################################################

##################################################
