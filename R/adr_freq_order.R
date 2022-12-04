library(tidyr)
library(dplyr)
library(arules)

paxlovid <- read.csv("paxlovid.csv")
ritonavir <- read.csv("ritonavir.csv")



#####################
# remove reference ##
#####################

id0= which(paxlovid$Literature.Reference=="-")
all1=paxlovid[id0,]
dim(all1)

id0= which(ritonavir$Literature.Reference=="-")
all1=ritonavir[id0,]
dim(all1)


#######################
#single case
#######################
mydf=data.frame(all1[,1],tolower(all1[,5]))
colnames(mydf)=c("V1","V2")
head(mydf)
mydf1=mydf %>% mutate(V2 = strsplit(as.character(V2), ";")) %>% unnest(V2)
adr_all=data.frame(unlist(mydf1[,1]),unlist(mydf1[,2]))
colnames(adr_all)=c("caseid","ADR")
head(adr_all)
adr_freq=table(adr_all[,2])
adr_freq_order=sort(adr_freq,decreasing=TRUE)
adr_freq_order[1:10]
#write.csv(adr_freq_order,file="paxlovid_adr_freq_order.csv")


