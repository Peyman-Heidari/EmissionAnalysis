## Reading the data
if (!(any(grepl("NEI",ls()))|any(grepl("SCC",ls())))) {
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
}
NEI<-transform(NEI, year=factor(year))
NEI1<- subset(NEI, fips == "24510")
NEItabel<- as.matrix(tapply(NEI1$Emissions,NEI1$year,sum))
year<- as.numeric(rownames(NEItabel))
plot(year,NEItabel, xlab="Year", ylab = "Annual PM25 emission (tons)", main="Temporal evolution of PM25 emission in Baltimore", col="red", pch=20)
model<- lm(NEItabel~year)
abline(model, lwd=2)
dev.copy(png,"Plot2.png")
dev.off()