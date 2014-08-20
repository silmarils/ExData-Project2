#
#
# read dataframes

dfcodes  <- readRDS("Source_Classification_Code.rds", refhook = NULL)
df       <- readRDS("summarySCC_PM25.rds", refhook = NULL )

library(sqldf)

# Q5
# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?


lcodes <- dfcodes[grep("^(.*)[mM]obile(.*)[rR]oad(.*)$", as.character(dfcodes$EI.Sector)),]

dfs <- sqldf("select sum(Emissions) as totalE, year 
             from df,lcodes 
             where df.SCC = lcodes.SCC and fips = '24510' 
             group by year  ")

png(filename = "plot5.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white", res = NA, family = "", restoreConsole = TRUE)


p <- qplot(year,totalE,data=dfs) + 
        geom_smooth(method = "loess", size = 1.5) +
        labs(title = "Total emissions from motor vehicle sources in Baltimore (by year)") +
        labs(x = "Years", y = "Total Emissions")

print(p)

dev.off()