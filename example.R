
# This example shows how to use the fivethirtyeight ggplot 2 theme for 
# visualizing some baseball data. More precisely, we will plot the number of 
# trades in Major League Baseball in the current century as a time series plot
# using the Batting dataset from the Lahman package

# Loading libraries and source additional files --------------------------------

library(Lahman)
library(dplyr)
library(ggplot2)
source('theme_fivethirtyeight.R')


# Data processing --------------------------------------------------------------

trades_by_year <- Batting %>% 
  select(playerID, yearID, teamID, lgID) %>%
  filter(lgID %in% c('NL', 'AL'), yearID %in% 1999:2012) %>% 
  group_by(playerID) %>%
  mutate(
    trade_year = teamID != lag(teamID),
    trade_year = ifelse(is.na(trade_year), FALSE, trade_year)
    ) %>%
  ungroup %>% 
  filter(yearID != 1999, trade_year == TRUE) %>%
  group_by(yearID, lgID) %>%
  summarize(
    numb_of_trades = n()
    )



