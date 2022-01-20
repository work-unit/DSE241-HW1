library(tidyverse)

# Reading in Data
urlfile="https://mas-dse.github.io/DSE241/data/olympics.csv"
mydata<-read_csv(url(urlfile))

data <- mydata %>% 
  select(Year, City, Sport, Country, Gender, Medal) %>% 
  mutate(Year = as.integer(Year))

# Selecting distinct years
years <- data %>% 
  distinct(Year)

# number of medals for each country-year-gender_sport combo
counts_by_gender <- data %>% 
  group_by(Sport,Country,Year,Gender) %>%
  summarise(medal_count = n()) 

# Ranking countries by # of total medals won

total_medals_by_country <- counts_by_gender %>% 
  group_by(Sport,Country) %>%
  summarise(num_medals_total = sum(medal_count)) %>%
  ungroup() %>%
  mutate(Rank = rank(num_medals_total, ties.method = c("first"))) %>%
  arrange(desc(Rank)) 

counts_by_gender <- counts_by_gender %>% 
  inner_join(total_medals_by_country) %>% 
  ungroup()

# Building Year-Gender-Sport-Country Skeleton (Cartesian Product)
Year <- years %>% 
  mutate(join_flag = 1)

Gender <- counts_by_gender %>% 
  distinct(Gender) %>% 
  mutate(join_flag = 1)

Sport <- counts_by_gender %>% 
  distinct(Sport) %>% 
  mutate(join_flag = 1)

Country <- counts_by_gender %>% 
  distinct(Country) %>% 
  mutate(join_flag = 1)

# Cartesian Product of Country, Year, Gender
plot_data_skeleton <- Year %>% 
  left_join(Gender) %>% 
  left_join(Country) %>% 
  left_join(Sport)

# filling in missing values with 0
plot_data <- plot_data_skeleton %>%
  left_join(counts_by_gender) %>% 
  select(-Rank,-num_medals_total) %>% 
  left_join(total_medals_by_country) %>% 
  replace(is.na(.), 0) %>% 
  select(Year, Gender, Sport,Country, medal_count, Rank)

# Calculating cumulative medal count for line chart
plot_data <- plot_data %>% 
  arrange(Sport,Country, Gender, Year) %>% 
  group_by(Sport,Country,Gender) %>% 
  mutate(cumulative_medals = cumsum(medal_count))

gender_cum_medals = plot_data %>% 
  group_by(Year, Gender) %>% 
  summarise(cumulative_medals = sum(cumulative_medals))

country_rank <- plot_data %>% 
  group_by(Country) %>% 
  summarise(country_rank = sum(medal_count)) %>% 
  arrange(desc(country_rank)) %>% 
  mutate(country_rank = rank(desc(country_rank), ties.method = c("first")))

n = 6

top_n_countries <- country_rank %>% 
  filter(country_rank<n) %>% 
  pull(Country)

# Finding minimum year
min_year = years %>%
  filter(Year == min(Year)) %>% 
  pull(Year)

# Finding maximum year
max_year = years %>%
  filter(Year == max(Year)) %>% 
  pull(Year)

# Filtering data to just those countries in top 5
gender_sport_country_facet_data <- plot_data %>% 
  # filter(Sport=='Ice Hockey') %>% 
  filter(Country %in% top_n_countries) %>% 
  group_by(Gender, Country) %>% 
  filter(sum(medal_count)>0) %>% 
  ungroup()

# Unique list of sports
sports_list <- gender_sport_country_facet_data %>% 
  distinct(Sport) %>% 
  pull()

# Unique list of countries
country_list <- gender_sport_country_facet_data %>% 
  distinct(Country) %>% 
  pull()