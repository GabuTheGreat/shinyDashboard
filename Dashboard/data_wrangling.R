library(dplyr)
library(ggplot2)

#load library and view dim
library(nycflights13)
dim(flights)

flights


#Using Filter
filter(flights, month == 1, day == 1)

#arranging using coloumn in R
arrange(flights, year, month, day)
#Use desc() to order a column in descending order:
desc = arrange(flights, desc(arr_delay))

#select(flights, year, month, day)
select(flights, year, month, day)

#select(flights, year:day)
select(flights, year:day)

#select(flights, -(year:day))
select(flights, -(year:day))

#rename(flights, tail_num = tailnum)
rename(flights, tail_num = tailnum)

#using mutate
mutate(flights,
       gain = arr_delay - dep_delay,
       speed = distance / air_time * 60
)

by_tailnum <- group_by(flights, tailnum)

by_tailnum <- group_by(flights, tailnum)
delay <- summarise(by_tailnum,
                   count = n(),
                   dist = mean(distance, na.rm = TRUE),
                   delay = mean(arr_delay, na.rm = TRUE))
delay <- filter(delay, count > 20, dist < 2000)

ggplot(delay, aes(dist, delay)) +
  geom_point(aes(size = count), alpha = 1/2) +
  geom_smooth() +
  scale_size_area()


