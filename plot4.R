#
#
# read dataframes

dfcodes  <- readRDS("Source_Classification_Code.rds", refhook = NULL)
df       <- readRDS("summarySCC_PM25.rds", refhook = NULL )

library(sqldf)

# Q4
# Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?


lcodes <- dfcodes[grep(".*[cC]oal.*",dfcodes$EI.Sector),]

dfs <- sqldf("select sum(Emissions) as totalE, year from df,lcodes where df.SCC = lcodes.SCC group by year  ")

png(filename = "plot4.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white", res = NA, family = "", restoreConsole = TRUE)


p <- qplot(year,totalE,data=dfs) + 
        geom_smooth(method = "loess", size = 1.5) +
        labs(title = "Total emissions from coal sources (National level, by year)") +
        labs(x = "Years", y = "Total Emissions")

print(p)

dev.off()