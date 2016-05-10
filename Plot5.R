library(dplyr)
## Reading the data
if (!(any(grepl("NEI",ls()))|any(grepl("SCC",ls())))) {
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
}
NEI<-transform(NEI, year=factor(year))
SCCcoal<- SCC[grepl("Veh",SCC$Short.Name),]
NEISCC1<- subset(NEI, NEI$SCC %in% SCCcoal$SCC)
NEISCC<- subset(NEISCC1, fips == "24510")
NEItabel<- as.matrix(tapply(NEISCC$Emissions,NEISCC$year,sum))
year<- as.numeric(rownames(NEItabel))
plot(year,NEItabel, xlab="Year", ylab = "Annual PM25 emission (tons)", main="Temporal evolution of PM25 emission from motor vehicles in Baltimore", col="red", pch=20)
model<- lm(NEItabel~year)
abline(model, lwd=2)
dev.copy(png,"Plot5.png")
dev.off()