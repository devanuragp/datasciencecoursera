Synopsis
--------

Storms and other severe weather events can cause both public health and
economic problems for a country. Many severe events can result in
fatalities, injuries, and property damage and crop damage. Preventing
such outcomes to the extent possible is a key concern. This analysis
studies the U.S. National Oceanic and Atmospheric Administration’s
(NOAA) storm database and answer’s two important questions, “which
events are most harmful to population health ?” and “which events have
greatest consequences to the country’s economy ?”. The data in the
database is very untidy, and therefore requires proper processing to
enable us to perform calculations. In our analysis we calculated total
values of required variables for each event. We have created 2 plots
namely “Most harmful events in terms of population health” and “Events
with greatest economic consequences”

Loading and Summarizing Data
----------------------------

The data comes in the form of a comma-separated-value file compressed
via the bzip2 algorithm to reduce its size. We’ll store the download
link of this file into a variable and later use it to download the file.
Set your working directory before you download the file using
download.file() function.

    fileurl <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2"
    download.file(fileurl,"stormdata.csv.bz2")

Now we’ll load the data into a data frame. Lets call the data frame
“stormdf”.

    stormdf <- read.csv("stormdata.csv.bz2")
    head(stormdf)

    ##   STATE__           BGN_DATE BGN_TIME TIME_ZONE COUNTY COUNTYNAME STATE  EVTYPE
    ## 1       1  4/18/1950 0:00:00     0130       CST     97     MOBILE    AL TORNADO
    ## 2       1  4/18/1950 0:00:00     0145       CST      3    BALDWIN    AL TORNADO
    ## 3       1  2/20/1951 0:00:00     1600       CST     57    FAYETTE    AL TORNADO
    ## 4       1   6/8/1951 0:00:00     0900       CST     89    MADISON    AL TORNADO
    ## 5       1 11/15/1951 0:00:00     1500       CST     43    CULLMAN    AL TORNADO
    ## 6       1 11/15/1951 0:00:00     2000       CST     77 LAUDERDALE    AL TORNADO
    ##   BGN_RANGE BGN_AZI BGN_LOCATI END_DATE END_TIME COUNTY_END COUNTYENDN
    ## 1         0                                               0         NA
    ## 2         0                                               0         NA
    ## 3         0                                               0         NA
    ## 4         0                                               0         NA
    ## 5         0                                               0         NA
    ## 6         0                                               0         NA
    ##   END_RANGE END_AZI END_LOCATI LENGTH WIDTH F MAG FATALITIES INJURIES PROPDMG
    ## 1         0                      14.0   100 3   0          0       15    25.0
    ## 2         0                       2.0   150 2   0          0        0     2.5
    ## 3         0                       0.1   123 2   0          0        2    25.0
    ## 4         0                       0.0   100 2   0          0        2     2.5
    ## 5         0                       0.0   150 2   0          0        2     2.5
    ## 6         0                       1.5   177 2   0          0        6     2.5
    ##   PROPDMGEXP CROPDMG CROPDMGEXP WFO STATEOFFIC ZONENAMES LATITUDE LONGITUDE
    ## 1          K       0                                         3040      8812
    ## 2          K       0                                         3042      8755
    ## 3          K       0                                         3340      8742
    ## 4          K       0                                         3458      8626
    ## 5          K       0                                         3412      8642
    ## 6          K       0                                         3450      8748
    ##   LATITUDE_E LONGITUDE_ REMARKS REFNUM
    ## 1       3051       8806              1
    ## 2          0          0              2
    ## 3          0          0              3
    ## 4          0          0              4
    ## 5          0          0              5
    ## 6          0          0              6

Lets take a look at the dimension of our data frame and its structure.

    dim(stormdf)

    ## [1] 902297     37

    str(stormdf)

    ## 'data.frame':    902297 obs. of  37 variables:
    ##  $ STATE__   : num  1 1 1 1 1 1 1 1 1 1 ...
    ##  $ BGN_DATE  : chr  "4/18/1950 0:00:00" "4/18/1950 0:00:00" "2/20/1951 0:00:00" "6/8/1951 0:00:00" ...
    ##  $ BGN_TIME  : chr  "0130" "0145" "1600" "0900" ...
    ##  $ TIME_ZONE : chr  "CST" "CST" "CST" "CST" ...
    ##  $ COUNTY    : num  97 3 57 89 43 77 9 123 125 57 ...
    ##  $ COUNTYNAME: chr  "MOBILE" "BALDWIN" "FAYETTE" "MADISON" ...
    ##  $ STATE     : chr  "AL" "AL" "AL" "AL" ...
    ##  $ EVTYPE    : chr  "TORNADO" "TORNADO" "TORNADO" "TORNADO" ...
    ##  $ BGN_RANGE : num  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ BGN_AZI   : chr  "" "" "" "" ...
    ##  $ BGN_LOCATI: chr  "" "" "" "" ...
    ##  $ END_DATE  : chr  "" "" "" "" ...
    ##  $ END_TIME  : chr  "" "" "" "" ...
    ##  $ COUNTY_END: num  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ COUNTYENDN: logi  NA NA NA NA NA NA ...
    ##  $ END_RANGE : num  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ END_AZI   : chr  "" "" "" "" ...
    ##  $ END_LOCATI: chr  "" "" "" "" ...
    ##  $ LENGTH    : num  14 2 0.1 0 0 1.5 1.5 0 3.3 2.3 ...
    ##  $ WIDTH     : num  100 150 123 100 150 177 33 33 100 100 ...
    ##  $ F         : int  3 2 2 2 2 2 2 1 3 3 ...
    ##  $ MAG       : num  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ FATALITIES: num  0 0 0 0 0 0 0 0 1 0 ...
    ##  $ INJURIES  : num  15 0 2 2 2 6 1 0 14 0 ...
    ##  $ PROPDMG   : num  25 2.5 25 2.5 2.5 2.5 2.5 2.5 25 25 ...
    ##  $ PROPDMGEXP: chr  "K" "K" "K" "K" ...
    ##  $ CROPDMG   : num  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ CROPDMGEXP: chr  "" "" "" "" ...
    ##  $ WFO       : chr  "" "" "" "" ...
    ##  $ STATEOFFIC: chr  "" "" "" "" ...
    ##  $ ZONENAMES : chr  "" "" "" "" ...
    ##  $ LATITUDE  : num  3040 3042 3340 3458 3412 ...
    ##  $ LONGITUDE : num  8812 8755 8742 8626 8642 ...
    ##  $ LATITUDE_E: num  3051 0 0 0 0 ...
    ##  $ LONGITUDE_: num  8806 0 0 0 0 ...
    ##  $ REMARKS   : chr  "" "" "" "" ...
    ##  $ REFNUM    : num  1 2 3 4 5 6 7 8 9 10 ...

This data frame contains 902297 observations of 37 variables, that means
it has 902297 rows and 37 columns.

Data Processing
---------------

We have 37 variables each storing different type of data. We want to
understand the which events are very harmful in terms of human life
casualties and which events have greatest consequence on economy. So we
are only interested in columns providing information about fatalities
and economic damage along with the event type and its date. So we will
select the columns “BGN\_DATE”, “EVTYPE”, “FATALITIES”, “INJURIES”,
“PROPDMG”, “PROPDMGEXP”, “CROPDMG” and “CROPDMGEXP”.

To select this columns we will load the dplyr package as it makes the
task way easier.

    library(dplyr)

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

Now we’ll select only the required columns using the dplyr package’s
select() function.

    stormdf <- select(stormdf, BGN_DATE, EVTYPE, FATALITIES, INJURIES,
                      PROPDMG, PROPDMGEXP, CROPDMG, CROPDMGEXP)
    str(stormdf)

    ## 'data.frame':    902297 obs. of  8 variables:
    ##  $ BGN_DATE  : chr  "4/18/1950 0:00:00" "4/18/1950 0:00:00" "2/20/1951 0:00:00" "6/8/1951 0:00:00" ...
    ##  $ EVTYPE    : chr  "TORNADO" "TORNADO" "TORNADO" "TORNADO" ...
    ##  $ FATALITIES: num  0 0 0 0 0 0 0 0 1 0 ...
    ##  $ INJURIES  : num  15 0 2 2 2 6 1 0 14 0 ...
    ##  $ PROPDMG   : num  25 2.5 25 2.5 2.5 2.5 2.5 2.5 25 25 ...
    ##  $ PROPDMGEXP: chr  "K" "K" "K" "K" ...
    ##  $ CROPDMG   : num  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ CROPDMGEXP: chr  "" "" "" "" ...

We now have a data frame of 902297 rows and 8 columns. To make the data
useful for analysis we’ll process its columns. The “BGN\_DATE” column is
of “character” class, so using the as.Date() function we’ll convert the
variable to “Date” class.

    stormdf$BGN_DATE <- as.Date(stormdf$BGN_DATE,
                                format = "%m/%d/%Y %H:%M:%S")
    class(stormdf$BGN_DATE)

    ## [1] "Date"

On inspecting the “EVTYPE” variable we’ll see that some values are
lowercase some are only uppercase and some are sentence case. For ease
of use and to avoid the confusion we’ll convert all the values to
lowercase using the tolower() function.

    head(unique(stormdf$EVTYPE))

    ## [1] "TORNADO"               "TSTM WIND"             "HAIL"                 
    ## [4] "FREEZING RAIN"         "SNOW"                  "ICE STORM/FLASH FLOOD"

    stormdf$EVTYPE <- tolower(stormdf$EVTYPE)
    head(unique(stormdf$EVTYPE))

    ## [1] "tornado"               "tstm wind"             "hail"                 
    ## [4] "freezing rain"         "snow"                  "ice storm/flash flood"

According to the [Storm Data
Documentation](https://d396qusza40orc.cloudfront.net/repdata%2Fpeer2_doc%2Fpd01016005curr.pdf)
the only values allowed in the “EVTYPE” variable are : Astronomical Low
Tide, Avalanche, Blizzard, Coastal Flood, Cold/Wind Chill, Debris Flow,
Dense Fog, Dense Smoke, Drought, Dust Devil, Dust Storm, Excessive Heat,
Extreme Cold/Wind Chill, Flash Flood, Flood, Frost/Freeze, Funnel Cloud,
Freezing Fog, Hail, Heat, Heavy Rain, Heavy Snow, High Surf, High Wind,
Hurricane (Typhoon), Ice Storm, Lake-Effect Snow, Lakeshore Flood,
Lightning, Marine Hail, Marine High Wind, Marine Strong Wind, Marine
Thunderstorm Wind, Rip Current, Seiche, Sleet, Storm Surge/Tide, Strong
Wind, Thunderstorm Wind, Tornado, Tropical Depression, Tropical Storm,
Tsunami, Volcanic Ash, Waterspout, Wildfire, Winter Storm, Winter
Weather.

So we’ll filter the “EVTYPE” variable only with the values given above
and eliminate the rest of the values.

    allowedevents <- tolower(c("Astronomical Low Tide", "Avalanche", "Blizzard", "Coastal Flood", "Cold", "Wind Chill", "Debris Flow", "Dense Fog", "Dense Smoke", "Drought", "Dust Devil", "Dust Storm", "Excessive Heat", "Extreme Cold", "Flash Flood", "Flood", "Frost", "Freeze", "Funnel Cloud", "Freezing Fog", "Hail", "Heat", "Heavy Rain", "Heavy Snow", "High Surf", "High Wind", "Hurricane", "Typhoon", "Ice Storm", "Lake-Effect Snow", "Lakeshore Flood", "Lightning", "Marine Hail", "Marine High Wind", "Marine Strong Wind", "Marine Thunderstorm Wind", "Rip Current", "Seiche", "Sleet", "Storm Surge","Tide", "Strong Wind", "Thunderstorm Wind", "Tornado", "Tropical Depression", "Tropical Storm", "Tsunami", "Volcanic Ash", "Waterspout", "Wildfire", "Winter Storm", "Winter Weather","extreme cold/wind chill","cold/wind chill", "hurricane/typhoon", "frost/freeze", "Storm Surge/Tide")) 

    stormdf <- stormdf[stormdf$EVTYPE %in% allowedevents,]
    head(stormdf)

    ##     BGN_DATE  EVTYPE FATALITIES INJURIES PROPDMG PROPDMGEXP CROPDMG CROPDMGEXP
    ## 1 1950-04-18 tornado          0       15    25.0          K       0           
    ## 2 1950-04-18 tornado          0        0     2.5          K       0           
    ## 3 1951-02-20 tornado          0        2    25.0          K       0           
    ## 4 1951-06-08 tornado          0        2     2.5          K       0           
    ## 5 1951-11-15 tornado          0        2     2.5          K       0           
    ## 6 1951-11-15 tornado          0        6     2.5          K       0

    dim(stormdf)

    ## [1] 636775      8

The “PROPDMG” and “PROPDMGEXP” columns contains data regarding damage
caused by the event in monetary terms (USD). The “PROPDMG” columns
contains the numeric value of monetary damage and “PROPDMGEXP” contains
the multiplier value for “PROPDMG”. A similar thing is happening with
the columns “CROPDMG” and “CROPDMGEXP”. To get the actual value in USD
we need to multiply the value in both columns. But to do that we’ll need
to replace the value in “PROPDMGEXP” and “CROPDMGEXP” with their numeric
equivalent. The task to find the equivalent values is a bit difficult. I
referred
[this](https://github.com/flyingdisc/RepData_PeerAssessment2/blob/master/how-to-handle-PROPDMGEXP.md)
for my task.

Check the unique values in “PROPDMGEXP” and “CROPDMGEXP”

    unique(stormdf$PROPDMGEXP)

    ##  [1] "K" "M" ""  "B" "+" "0" "5" "m" "2" "4" "7" "?" "-" "6" "3" "1" "8" "H"

    unique(stormdf$CROPDMGEXP)

    ## [1] ""  "K" "M" "B" "0" "k"

Now we’ll create a common function for both the columns to replace the
values found above with their equivalent numeric value.

    expval <- function(temp){
        temp <- gsub("[0-9]","10",temp)
        temp <- gsub("K","1000",temp)
        temp <- gsub("k","1000",temp)
        temp <- gsub("M","1000000",temp)
        temp <- gsub("m","1000000",temp)
        temp <- gsub("H","100",temp)
        temp <- gsub("h","100",temp)
        temp <- gsub("B","1000000000",temp)
        temp
    }

We can see that this function does not address empty character and signs
like “+”, “-”, “?”. We’ll process them separately while processing the
individual columns.

First processing the “PROPDMGEXP” column

    stormdf$PROPDMGEXP <- expval(stormdf$PROPDMGEXP)
    stormdf$PROPDMGEXP[stormdf$PROPDMGEXP == ""] <- 0
    stormdf$PROPDMGEXP[stormdf$PROPDMGEXP == "+"] <- 0
    stormdf$PROPDMGEXP[stormdf$PROPDMGEXP == "?"] <- 0
    stormdf$PROPDMGEXP[stormdf$PROPDMGEXP == "-"] <- 0
    unique(stormdf$PROPDMGEXP)

    ## [1] "1000"       "1000000"    "0"          "1000000000" "10"        
    ## [6] "100"

Now processing the “CROPDMGEXP” column

    stormdf$CROPDMGEXP <- expval(stormdf$CROPDMGEXP)
    stormdf$CROPDMGEXP[stormdf$CROPDMGEXP == ""] <- 0
    stormdf$CROPDMGEXP[stormdf$CROPDMGEXP == "+"] <- 0
    stormdf$CROPDMGEXP[stormdf$CROPDMGEXP == "?"] <- 0
    stormdf$CROPDMGEXP[stormdf$CROPDMGEXP == "-"] <- 0
    unique(stormdf$CROPDMGEXP)

    ## [1] "0"          "1000"       "1000000"    "1000000000" "10"

Now to perform multiplication we will convert the columns “PROPDMGEXP”
and “CROPDMGEXP” to numeric class using as.numeric(function)

    stormdf$PROPDMGEXP <- as.numeric(stormdf$PROPDMGEXP)
    stormdf$CROPDMGEXP <- as.numeric(stormdf$CROPDMGEXP)

Creating two new columns containing actual property damage and crop
damage value, namely “ACTPROPDMG” and “ACTCROPDMG”

    stormdf$ACTPROPDMG <- stormdf$PROPDMG * stormdf$PROPDMGEXP
    stormdf$ACTCROPDMG <- stormdf$CROPDMG * stormdf$CROPDMGEXP

Data Analysis
-------------

Coming back to the questions asked above, about which events have
maximum effect on the human health and which events have maximum effect
on the country’s (USA) economy, we need to find the events with maximum
values of variables such as “FATALITIES”, “INJURIES”, “ACTPROPDMG” and
“ACTCROPDMG”.

For “FATALITIES”, we will create a new data frame containing the sum of
fatalities for each unique event. Then sorting the sum obtained in
descending order will give us the events which have caused maximum
deaths.

    fatality <- as.data.frame(tapply(stormdf$FATALITIES,
                                     as.factor(stormdf$EVTYPE), sum))
    names(fatality)[1] <- "fatalities"
    fatality$eventtype <- row.names(fatality)
    fatality <- select(fatality[order(fatality$fatalities,
                                      decreasing =  TRUE ),],eventtype,fatalities)
    print.data.frame(fatality, row.names = FALSE, max = 10 )

    ##       eventtype fatalities
    ##         tornado       5633
    ##  excessive heat       1903
    ##     flash flood        978
    ##            heat        937
    ##       lightning        816
    ##  [ reached 'max' / getOption("max.print") -- omitted 50 rows ]

Here we can see that the event “Tornado” has caused maximum fatalities,
to be precise 5633 fatalities over all the years in which data has been
collected. After tornado we have the event “Excessive heat” with 1903
fatalities. The gap between tornado and excessive heat is quite
significant.

Similarly, repeating the above chunk for variables “INJURIES”,
“ACTPROPDMG” and “ACTCROPDMG”.

    injury <- as.data.frame(tapply(stormdf$INJURIES,
                                   as.factor(stormdf$EVTYPE), sum))
    names(injury)[1] <- "injuries"
    injury$eventtype <- row.names(injury)
    injury <- select(injury[order(injury$injuries,
                                  decreasing = TRUE ),],eventtype,injuries)
    print.data.frame(injury, row.names = FALSE, max = 10)

    ##       eventtype injuries
    ##         tornado    91346
    ##           flood     6789
    ##  excessive heat     6525
    ##       lightning     5230
    ##            heat     2100
    ##  [ reached 'max' / getOption("max.print") -- omitted 50 rows ]

Even here, as seen with the number of fatalities, the event “Tornado”
has caused maximum injuries, to be precise 91346 fatalities over all the
years in which data has been collected. After tornado we have the event
“Flood” with 6789 injuries. The gap between tornado and flood is
massive.

    propertydamage <- as.data.frame(tapply(stormdf$ACTPROPDMG,
                                   as.factor(stormdf$EVTYPE), sum))
    names(propertydamage)[1] <- "propdamages"
    propertydamage$eventtype <- row.names(propertydamage)
    propertydamage <- select(propertydamage[order(propertydamage$propdamages,
                                  decreasing = TRUE ),],eventtype,propdamages)
    print.data.frame(propertydamage, row.names = FALSE, max = 10)

    ##          eventtype  propdamages
    ##              flood 144657709800
    ##  hurricane/typhoon  69305840000
    ##            tornado  56937162837
    ##        storm surge  43323536000
    ##        flash flood  16140815011
    ##  [ reached 'max' / getOption("max.print") -- omitted 50 rows ]

While talking about damages in terms of property we can see that the
event “Flood” has caused maximum damages, to be precise 144 Billion USD
over all the years data have been collected. After flood we have the
event “Hurricane/typhoon” with property damages worth 69 Billion USD.
The gap between flood and hurricane/typhoon is approximately 75 Billion
USD.

    cropdamage <- as.data.frame(tapply(stormdf$ACTCROPDMG,
                                   as.factor(stormdf$EVTYPE), sum))
    names(cropdamage)[1] <- "cropdamages"
    cropdamage$eventtype <- row.names(cropdamage)
    cropdamage <- select(cropdamage[order(cropdamage$cropdamages,
                                  decreasing = TRUE ),],eventtype,cropdamages)
    print.data.frame(cropdamage, row.names = FALSE, max = 10)

    ##  eventtype cropdamages
    ##    drought 13972566000
    ##      flood  5661968450
    ##  ice storm  5022113500
    ##       hail  3025954650
    ##  hurricane  2741910000
    ##  [ reached 'max' / getOption("max.print") -- omitted 50 rows ]

Here we are observing the damage caused to crops in terms of money in
USD. We can see that the event “Drought” has resulted in maximum
monetary loss, approx 14 Billion USD over all the years data have been
collected. After drought we have the event “Flood” with 5.6 Billion USD
worth of losses. The gap between drought and flood is worth noting.

Result
------

### Types of Events most harmful to population health

The events most harmful to the population health across USA, are
basically the events with maximum fatalities and injuries. We’ll plot a
graph to show the events with most fatalities and the events with most
injuries. We’ll only consider the top 5 event types in terms of
fatalities and injuries each, as we are inspecting the most harmful
events.

    par(mfrow = c(1,2), las = 3, bg = "lightgrey", cex = 0.7,
            omi = c(0.4,0.1,0.5,0.1))
    barplot(fatalities ~ eventtype, fatality[1:5,],
            col = "darkred", xlab = "", ylab = "Fatalities",
            main = "Fatalities by Events")
    barplot(injuries ~ eventtype, injury[1:5,],
            col = "steelblue", xlab = "", ylab = "Injuries",
            main = "Injuries by Events")
    mtext("Most harmful events in terms of population health",
            outer = TRUE, las = 1, cex = 1)

![](Storm-Data-Analysis_files/figure-markdown_strict/Plot%201-1.png)

We can see that “Tornado” has caused maximum fatalities and injuries,
therefore we can say that tornado is the most harmful event to
population health. Tornado is followed by “Excessive heat” in terms of
fatalities whereas it has caused marginally less number of injuries in
comparison to “Floods”. It is safe to conclude that the most harmful
events to population health are “Tornado”, “Excessive heat”, “Flash
flood”, “Floods”, “Heat” and “Lightning”.

### Events with greatest economic consequences

The events with greatest economic consequences can be determined by
inspecting the property and crops damage by those events. We’ll plot a
graph to show the events causing more property damage and crop damage.
Only the top 5 event types will be considered as we are interested in
the events with greatest economic consequence.

    par(mfrow = c(1,2), las = 3, bg = "lightgrey", cex = 0.7,
            omi = c(0.4,0.1,0.5,0.1))
    barplot(propdamages/1000000000 ~ eventtype, propertydamage[1:5,],
            col = "mediumseagreen", xlab = "", ylab = "US Dollars in Billions",
            main = "Property Damage by Events")
    barplot(cropdamages/1000000000 ~ eventtype, cropdamage[1:5,],
            col = "darkorange", xlab = "", ylab = "US Dollars in Billions",
            main = "Crop Damage by Events")
    mtext("Events with greatest economic consequences",
            outer = TRUE, las = 1, cex = 1)

![](Storm-Data-Analysis_files/figure-markdown_strict/Plot%202-1.png)

Here the events causing maximum property damages are Floods (144 Billion
USD), Hurricane/ Typhoon (69 Billion USD), Tornado (57 Billion USD),
Storm surge (43 Billion USD) and Flash Flood (16 Billion USD). Similarly
events having greatest impact on crops are Drought (14 Billion USD),
Flood (5.6 Billion USD), Ice Storm (5 Billion USD), Hail (3 Billion USD)
and Hurricane (2.7 Billion USD).
