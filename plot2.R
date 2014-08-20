#
#
# read dataframes

dfcodes  <- readRDS("Source_Classification_Code.rds", refhook = NULL)
df       <- readRDS("summarySCC_PM25.rds", refhook = NULL )

library(sqldf)

# Q2
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.

dfs <- sqldf("select sum(Emissions) as totalE, year from df where fips = '24510' group by year  ")

png(filename = "plot2.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white", res = NA, family = "", restoreConsole = TRUE)


plot(dfs$year,dfs$totalE,pch = 20,main="Total Baltimore emissions by year",xlab = "Year",ylab = "Total emissions")
model <- lm(dfs$totalE~dfs$year,dfs)
abline(model, lwd = 2)

# all data
#> coef(model)
#(Intercept)     dfs$year 
# 1314.2000536   -0.6531415 



dev.off()