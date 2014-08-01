
# This example shows how to use the fivethirtyeight ggplot 2 theme for 
# visualizing some baseball data. More precisely, we will plot the number of 
# trades in Major League Baseball in the current century as a time series plot
# using the Batting dataset from the Lahman package

# Loading libraries and source additional files --------------------------------

library(Lahman)
library(dplyr)
library(ggplot2)
library(extrafont)
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

# Data plotting ----------------------------------------------------------------

ggplot(trades_by_year, aes(yearID, numb_of_trades, colour = lgID)) +
  geom_line(size = 0.75) +
  ggtitle("Number of trades in Major League Baseball (2000 - 2012)") +
  annotate('text', x = -Inf, y = -Inf, label = 'American League', hjust = -1.8,
           vjust = -18, colour = '#FE2700', fontface = 'bold') +
  annotate('text', x = Inf, y = Inf, label = 'National League', hjust = 2, 
           vjust = 15, colour = '#008FD5', fontface = 'bold') +
  scale_color_manual(values = c('#FE2700', '#008FD5')) +
  scale_x_continuous(breaks = seq(2000, 2012, by = 2)) +
  scale_y_continuous(breaks = seq(140, 300, by = 50)) +
  theme_fivethirtyeight()





