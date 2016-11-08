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


