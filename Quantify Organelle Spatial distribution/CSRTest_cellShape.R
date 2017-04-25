

#take arguments
#args <- commandArgs(trailingOnly = T)

ca = commandArgs(TRUE)
print(ca)
arg1 = ca[1]

#arg2 = ca[2]
#dirFolder <- args[1]
#print(ca)
#dirFolder = ca[2]
#print(dirFolder)
#setwd(dirFolder)


#print(getwd())
#print("argument list")
#print (ca)
#print (strtoi(arg1))

arg1 = strtoi(arg1)
#setwd("C:/Users/GuruprasadR/Desktop/Box Sync/Fall'16 Research/14_Oct_16 (Ripley's K - arbit shape)")
#arg1 = 1040;

library(spatstat)

convCell= read.csv('convCell.txt', header=FALSE)
convNuc = read.csv('convNuc.txt', header=FALSE)
coordsOrg = read.csv('OrgCoordsInCell.txt', header=FALSE)

convCell[,2] = arg1 - convCell[,2];
convCell[,1] = rev(convCell[,1]);
convCell[,2] = rev(convCell[,2]);

cell <- owin(poly=list(x=convCell$V1, y=convCell$V2))

#cellwoNuc <- owin(poly=list(list(x=convCell$V1, y=convCell$V2), list(x=convNuc$v1, y=convNuc$V2)))

coordsOrg$V2 = arg1 - coordsOrg$V2;

lyso <- ppp(coordsOrg$V1,coordsOrg$V2,window=cell)

filesave <- "ArbitCellShape.eps"
#jpeg(filesave)
setEPS()
postscript(filesave)
plot(lyso, main="Arbit cell shape")
dev.off()


#Compare point patterns with CSR case (Ripley's K Function)
#filesave <- gsub('.{3}$', '', "CSR-Test")
filesave <- "Ripley'sK_CSR.eps"
#filesave <- paste(filesave, 'jpeg', sep="")
#jpeg(filesave)
setEPS()
postscript(filesave)
Kenvlipid <- envelope(lyso, Kest, nsim=99, nrank=2, transform = expression(. -pi*r^2))
plot(Kenvlipid, xlab='neighborhood radius (r)', ylab='K(r)', main="Ripley's K function")
dev.off()


filesave <- "Ripley'sL_CSR.eps"
#jpeg(filesave)
setEPS()
postscript(filesave)
Lenvlipid <- envelope(lyso, Kest, nsim=99, nrank=2, transform = expression(sqrt(./pi)))
plot(Lenvlipid, xlab='neighborhood radius (r)', ylab='L(r)', main="Ripley's L function")
dev.off()

