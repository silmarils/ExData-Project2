#
#
# read dataframes

dfcodes  <- readRDS("Source_Classification_Code.rds", refhook = NULL)
df       <- readRDS("summarySCC_PM25.rds", refhook = NULL )

library(sqldf)

# Q1
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from all sources
# for each of the years 1999, 2002, 2005, and 2008.

dfs <- sqldf("select sum(Emissions) as totalE, year from df group by year")

png(filename = "plot1.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white", res = NA, family = "", restoreConsole = TRUE)

plot(dfs$year,dfs$totalE,pch = 20,main="Total emissions by year",xlab = "Year",ylab = "Total emissions")
model <- lm(dfs$totalE~dfs$year,dfs)
abline(model, lwd = 2)

dev.off()