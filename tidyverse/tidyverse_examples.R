require(tidyverse)

colnames(who) <- gsub("newrel", "new_rel", colnames(who))

##################
## tibbles

who

##################
## tidyr

## wide to long
gather(who)

who_long <- gather(who, group, cases, -country, -iso2, -iso3, -year)
who_long <- na.omit(who_long)

## long to wide
spread(who_long, key = group, value = cases)

## separate
separate(who_long, col = group, sep = "_", into = c("new", "pos", "patient"))

who_long <- separate(who_long, col = group, sep = "_", into = c("new", "pos", "patient"), remove = FALSE)



##################
## dplyr

filter(who_long, year <= 2000)
filter(who_long, year <= 2000, country == "Afghanistan")

arrange(who_long, cases)
arrange(who_long, desc(cases))

select(who_long, country, cases, year)
select(who_long, country, number = cases, year)
select(who_long, -group)

mutate(who_long, log_cases = log(1 + cases), cases2 = exp(log_cases) - 1)

summarise(who_long, m = mean(cases))

who_long <- mutate(who_long, gender = substr(patient, 1, 1))


who_long_by_country <- group_by(who_long, country)
summarise(who_long_by_country, m = mean(cases))
summarise(who_long_by_country, m = mean(cases), number = n())
summarise(who_long_by_country, m = mean(cases), log_mean = log(m))

who_long_by_country_gender <- group_by(who_long, country, gender)
summarise(who_long_by_country_gender, m = mean(cases))

###################
## magrittr

who_long %>% group_by(country) %>% summarise(number = n(), m = mean(cases))

who_long %>% 
    filter(year <= 2000) %>% 
    group_by(country) %>% 
    summarise(number = n(), m = mean(cases))

####################
## ggplot2

who_long %>% 
    filter(year <= 2000) %>% 
    group_by(gender) %>% 
    summarise(number = n()) %>% 
    ggplot(aes(x = gender, y = number, fill = gender)) + geom_bar(stat = "identity")


