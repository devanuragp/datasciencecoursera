About the Data
--------------

It is now possible to collect a large amount of data about personal
movement using activity monitoring devices such as a Fitbit, Nike
Fuelband, or Jawbone Up. These type of devices are part of the
“quantified self” movement – a group of enthusiasts who take
measurements about themselves regularly to improve their health, to find
patterns in their behavior, or because they are tech geeks. But these
data remain under-utilized both because the raw data are hard to obtain
and there is a lack of statistical methods and software for processing
and interpreting the data.

Loading and Preprocessing Data
------------------------------

First we’ll have to read the dataset which is in csv format and assign
it to a variable using ‘read.csv()’ fuction. We’ll name the variable as
‘activitydf’. Then we’ll print the head of that dataframe using
‘head()’.

    activitydf <- read.csv("activity.csv")
    head(activitydf)

    ##   steps       date interval
    ## 1    NA 2012-10-01        0
    ## 2    NA 2012-10-01        5
    ## 3    NA 2012-10-01       10
    ## 4    NA 2012-10-01       15
    ## 5    NA 2012-10-01       20
    ## 6    NA 2012-10-01       25

Now we’ll check the dimension of the dataframe and its structure

    dim(activitydf)

    ## [1] 17568     3

    str(activitydf)

    ## 'data.frame':    17568 obs. of  3 variables:
    ##  $ steps   : int  NA NA NA NA NA NA NA NA NA NA ...
    ##  $ date    : chr  "2012-10-01" "2012-10-01" "2012-10-01" "2012-10-01" ...
    ##  $ interval: int  0 5 10 15 20 25 30 35 40 45 ...

The variables included in this dataset are:

1.  steps: Number of steps taking in a 5-minute interval (missing values
    are coded as NA)
2.  date: The date on which the measurement was taken in YYYY-MM-DD
    format
3.  interval: Identifier for the 5-minute interval in which measurement
    was taken

We can see that the date variable is of character type, so we’ll convert
it into Date type using function ‘as.Date()’

    activitydf[,2] <- as.Date(activitydf$date, format = "%Y-%m-%d")
    summary(activitydf)

    ##      steps             date               interval     
    ##  Min.   :  0.00   Min.   :2012-10-01   Min.   :   0.0  
    ##  1st Qu.:  0.00   1st Qu.:2012-10-16   1st Qu.: 588.8  
    ##  Median :  0.00   Median :2012-10-31   Median :1177.5  
    ##  Mean   : 37.38   Mean   :2012-10-31   Mean   :1177.5  
    ##  3rd Qu.: 12.00   3rd Qu.:2012-11-15   3rd Qu.:1766.2  
    ##  Max.   :806.00   Max.   :2012-11-30   Max.   :2355.0  
    ##  NA's   :2304

Mean Total Number of steps taken per day
----------------------------------------

The data is collected from the device in 5-minute interval over 2 months
time. This means for any single day we’ll have the number of steps
walked, for every 5 minute interval. So the total number of steps taken
in that day will be number of steps taken every 5 minute over the period
of 24 hours.

To find the total steps per day we’ll use the tapply() function.

    total_steps_per_day <- tapply(activitydf$steps,
                                  as.factor(activitydf$date),sum)

The variable total\_steps\_per\_day stores an array of total number of
steps per day. We’ll plot a histogram for this variable using hist()
function.

    hist(total_steps_per_day, xlab = "Steps per day",
         main = "Histogram of steps per day" )

![](PA1_template_files/figure-markdown_strict/Histogram%20plot-1.png)

From the plot we can see that the frequency of step per day is maximum
for the range 10000 - 15000. So, we can say that our mean falls
somewhere in that range. To check that lets calculate the mean and
median of total\_steps\_per\_day.

    mean(total_steps_per_day, na.rm = TRUE)

    ## [1] 10766.19

    median(total_steps_per_day, na.rm = TRUE)

    ## [1] 10765

As seen above the mean & median total steps per day recorded for an
anonymous individual in the months of October and November is 10766.19 &
10765 respectively.

Average daily activity pattern
------------------------------

To find average daily activity pattern we’ll plot a time series graph of
5-minute intervals vs the average number of steps taken for that
interval in two months

    mean_steps_per_interval <- tapply(activitydf$steps, 
                                      as.factor(activitydf$interval),
                                      function(x){mean(x, na.rm = TRUE)})
    interval <- unlist(dimnames(mean_steps_per_interval))

Now we have average of values recorded over two months for every
interval.We’ll now make a time series plot.

![](PA1_template_files/figure-markdown_strict/Average%20Daily%20activity%20pattern-1.png)

From the plot we can see that maximum number of steps are found between
the interval 500 & 1000. After having a close look at the plot we can
say that maximum steps are found at little more than the middle of the
two interval. So we can say max number of steps are found in any 5
minute interval in range 800-850.

Imputing missing values
-----------------------

Calculating total number of missing values(NA) in the dataset. That is
total number of rows with missing values.

    lapply(activitydf, function(x){sum(is.na(x))})

    ## $steps
    ## [1] 2304
    ## 
    ## $date
    ## [1] 0
    ## 
    ## $interval
    ## [1] 0

We can see that the steps variable has a total of 2304 missing values
where as the variables date and interval have 0 missing values. So we
can conclude that there are 2304 rows of missing data.

To fill the rows with missing data we’ll use number of average steps for
that particular interval

    missing_activitydf <- activitydf[!complete.cases(activitydf),]

We’ll create a custom function to replace all NA values in the missing
activity dataset with their respective mean values

    imputefun <- function(x){
      missing_activitydf[missing_activitydf$interval==x,][1] <- mean_steps_per_interval[as.character(x)]
         missing_activitydf
    }

Now we’ll use a for loop to iterate over all interval values in missing
activity dataset and replace them using imputefun()

    for(x in unique(missing_activitydf$interval)){
      missing_activitydf <- imputefun(x)
    }
    new_activitydf <- rbind(activitydf[complete.cases(activitydf),],
                            missing_activitydf)

We have a new data frame named new\_activitydf which has in it filled
values of the NAs in activitydf. To check this we’ll run the dim() on
both the data frames.

    dim(activitydf)

    ## [1] 17568     3

    dim(new_activitydf)

    ## [1] 17568     3

Now that we have a dataset with all the missing values filled, we will
compute the total steps for each day and its mean and median. Lets see
how much difference do this values make when compared to the original
calculation where NA’s were ignored.

    new_tspd <- tapply(new_activitydf$steps,
                                  as.factor(new_activitydf$date),sum)

Lets Plot a Histogram and inspect the differences.

    hist(new_tspd, xlab = "Steps per day",
         main = "Histogram of steps per day" )

![](PA1_template_files/figure-markdown_strict/New%20histogram%20plot-1.png)

Computing the mean & median total number of steps per day

    mean(new_tspd, na.rm = TRUE)

    ## [1] 10766.19

    median(new_tspd, na.rm = TRUE)

    ## [1] 10766.19

These new values derived out of the dataset with no missing values
doesn’t show any difference when compared to the values derived from the
original dataset with 2304 rows of missing values. The mean & median of
the new dataset is 10766.19 and 10766.19 respectively whereas the mean &
median of the old dataset is 10766.19 and 10765 respectively.

Differences in activity patterns between weekdays and weekends
--------------------------------------------------------------

For this part of our analysis we will make a new variable(column) in our
dataset and name it dayofweek. This will be a factor variable with 2
levels “weekday” and “weekend”

    new_activitydf$dayofweek <- NA
    new_activitydf[weekdays(new_activitydf$date) == "Monday" |
                     weekdays(new_activitydf$date) == "Tuesday" |
                     weekdays(new_activitydf$date) == "Wednesday" |
                     weekdays(new_activitydf$date) == "Thursday" |
                     weekdays(new_activitydf$date) == "Friday", ][4] <- "weekday"
    new_activitydf[weekdays(new_activitydf$date) == "Saturday"|
                     weekdays(new_activitydf$date) == "Sunday",][4] <- "weekend"

Now we’ll convert the dayofweek variable into a factor variable. Lets
convert it and take a look at the summary of the dataframe.

    new_activitydf$dayofweek <-as.factor(new_activitydf$dayofweek)
    summary(new_activitydf)

    ##      steps             date               interval        dayofweek    
    ##  Min.   :  0.00   Min.   :2012-10-01   Min.   :   0.0   weekday:12960  
    ##  1st Qu.:  0.00   1st Qu.:2012-10-16   1st Qu.: 588.8   weekend: 4608  
    ##  Median :  0.00   Median :2012-10-31   Median :1177.5                  
    ##  Mean   : 37.38   Mean   :2012-10-31   Mean   :1177.5                  
    ##  3rd Qu.: 27.00   3rd Qu.:2012-11-15   3rd Qu.:1766.2                  
    ##  Max.   :806.00   Max.   :2012-11-30   Max.   :2355.0

Now we’ll import the lattice package to make panel plot. We have to make
a panel plot containing a time series plot of the 5-minute interval and
the average number of steps taken, averaged across all weekday days or
weekend days.

    library(lattice)

To do that we will subset the latest dataset into 2 parts weekday and
weekend, then we’ll find the mean of steps for each interval over
weekday or weekend and then combine both the results into one data frame
for plotting purposes.

    weekday_sub <-subset(new_activitydf, new_activitydf$dayofweek == "weekday",
                          c("steps","interval","dayofweek"))
    weekday_sub <-tapply(weekday_sub$steps, as.factor(weekday_sub$interval),mean)


    weekend_sub <-subset(new_activitydf, new_activitydf$dayofweek == "weekend",
                          c("steps","interval","dayofweek"))
    weekend_sub<-tapply(weekend_sub$steps, as.factor(weekend_sub$interval),mean)

We have the means of each interval over weekdays and weekend now to plot
the graph in lattice plotting system we’ll have to combine the results
into one data frame

    weekday_sub <- data.frame(weekday_sub, "weekday", interval)
    names(weekday_sub) <- c("steps","dayofweek","interval")

    weekend_sub <- data.frame(weekend_sub,"weekend",interval)
    names(weekend_sub) <- c("steps","dayofweek","interval")

    tot_weekdays <- rbind(weekday_sub,weekend_sub)

Now everything is ready to plot the graphs

    xyplot(steps~as.numeric(interval)|dayofweek ,
           data = tot_weekdays, type = 'l',layout=c(1,2),
           xlab = "Intervals", ylab = "number of steps",
           main= "Time series plot of 5-minute interval vs number of steps")

![](PA1_template_files/figure-markdown_strict/Time%20series%20new%20plot-1.png)
