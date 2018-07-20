library(RCurl)
library(googleVis)

tb_dict <-
  read.csv(
    text = getURL(
      "https://raw.githubusercontent.com/datamustekeers/WHOtb_data_analysis/master/data/TB_data_dictionary_2018-07-04.csv"
    ),
    header = T
  )

tb_data <-
  read.csv(
    text = getURL(
      "https://raw.githubusercontent.com/datamustekeers/WHOtb_data_analysis/master/data/TB_burden_countries_2018-07-04.csv"
    ),
    header = T
  )


#choose east African countries/ based on region
East = c("Kenya", "Uganda")
c_year = c(2016,2015,2014,2013,2010)


country_data = subset(tb_data, year %in% c_year)
country_data = subset(country_data, country == "Kenya")


country_data  = country_data[, c("country", "year", "e_pop_num", "e_inc_num","e_inc_num_hi")]

Bubble <- gvisBubbleChart(country_data, idvar="country",xvar="e_inc_num", yvar="e_inc_num_hi",colorvar="year", sizevar= "e_pop_num")
