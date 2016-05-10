library(dplyr)
## Reading the data
if (!(any(grepl("NEI",ls()))|any(grepl("SCC",ls())))) {
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
}
NEI<-transform(NEI, year=factor(year))
SCCcoal<- SCC[grepl("Veh",SCC$Short.Name),]
NEISCC1<- subset(NEI, NEI$SCC %in% SCCcoal$SCC)
NEISCCBal<- subset(NEISCC1, fips == "24510")
NEISCCLos<- subset(NEISCC1, fips == "06037")


NEItabelLos<- as.matrix(tapply(NEISCCLos$Emissions,NEISCCLos$year,sum))
yearLos<- as.numeric(rownames(NEItabelLos))

NEItabelBal<- as.matrix(tapply(NEISCCBal$Emissions,NEISCCBal$year,sum))
yearBal<- as.numeric(rownames(NEItabelBal))

par(mfrow=c(1,2))
par(mar=c(4,4,4,2))
par(oma=c(0,0,2,0))


plot(yearBal,NEItabelBal, xlab="Year", ylab = "Annual PM25 emission (tons)", main="Baltimore", col="red", pch=20)
model<- lm(NEItabelBal~yearBal)
abline(model, lwd=2, col="red")

plot(yearLos,NEItabelLos, xlab="Year", ylab = "Annual PM25 emission (tons)", main="Los Angeles", col="blue", pch=20)
model<- lm(NEItabelLos~yearLos)
abline(model, lwd=2, col="blue")

mtext("Temporal evolution of PM25 emission from motor vehicles", outer=TRUE)

