#
#
# read dataframes

dfcodes  <- readRDS("Source_Classification_Code.rds", refhook = NULL)
df       <- readRDS("summarySCC_PM25.rds", refhook = NULL )

library(sqldf)

# Q6
# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County
# California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?


lcodes <- dfcodes[grep("^(.*)[mM]obile(.*)[rR]oad(.*)$", as.character(dfcodes$EI.Sector)),]

dfs <- sqldf("select fips, sum(Emissions) as totalE, year 
             from df,lcodes 
             where df.SCC = lcodes.SCC and (fips = '24510' or fips = '06037') 
             group by year  ")

png(filename = "plot6.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white", res = NA, family = "", restoreConsole = TRUE)

p <- qplot(year,totalE,data=dfs,color=fips) + 
        geom_smooth(method = "lm")+
        labs(title = "Baltimore vs Los Angeles - Total emissions by year") +
        labs(x = "Years", y = "Total Emissions")

print(p)

dev.off()