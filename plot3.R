#
#
# read dataframes

dfcodes  <- readRDS("Source_Classification_Code.rds", refhook = NULL)
df       <- readRDS("summarySCC_PM25.rds", refhook = NULL )

library(sqldf)

# Q3
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources
# have seen decreases in emissions from 1999-2008 for Baltimore City? 
# Which have seen increases in emissions from 1999-2008? 
# Use the ggplot2 plotting system to make a plot answer this question.

dfs <- sqldf("select sum(Emissions) as totalE, type, year from df where fips = '24510' group by type,year  ")

png(filename = "plot3.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white", res = NA, family = "", restoreConsole = TRUE)


p <- qplot(year,totalE,color=type,data=dfs) + 
        geom_smooth(method = "loess", size = 1.5) +
        labs(title = "Total emissions in Baltimore (by type by year)") +
        labs(x = "Years", y = "Total Emissions")

print(p)
dev.off()