library(reshape)
library(ggplot2)
## Reading the data
if (!(any(grepl("NEI",ls()))|any(grepl("SCC",ls())))) {
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
}
NEI<-transform(NEI, type=factor(type))
NEI<-transform(NEI, year=factor(year))
NEItabel<- with(NEI, tapply(Emissions, list(year, type), sum))
year<- as.matrix(as.numeric(rownames(NEItabel)))
PMDF<- melt(NEItabel, id="year")
colnames(PMDF)<- c("year", "type", "pm25")
PMDF<- transform(PMDF, type=factor(type))
g<- ggplot(PMDF, aes(year,pm25))
 g+ geom_point(col="blue") + facet_grid(.~type) + geom_smooth(method="lm", se=FALSE, col="steelblue") +
  labs(x="year", y="Annual PM25 emission (tons)", title="The effect of type of emission on annual PM25 emission")
 
 dev.copy(png,"Plot3.png")
 dev.off()