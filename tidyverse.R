## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, include = TRUE, fig.align = "center", out.width = "600px")
require(tidyverse)
require(broom)
require(modelr)

## ---- echo = FALSE-------------------------------------------------------
knitr::include_graphics("images/tidy-1.png")

## ---- echo = FALSE-------------------------------------------------------
knitr::include_graphics("images/data-science.png")

## ---- echo = FALSE-------------------------------------------------------
knitr::include_graphics("images/data-science-wrangle.png")

## ---- out.width = "100px", fig.align = "center", echo = FALSE------------
knitr::include_graphics("images/RStudio_Hex_readr.png")

## ------------------------------------------------------------------------
colnames(who) <- gsub("newrel", "new_rel", colnames(who))
who

## ---- out.width = "100px", fig.align = "center", echo = FALSE------------
knitr::include_graphics("images/RStudio_Hex_tidyr.png")

## ---- echo=FALSE---------------------------------------------------------
knitr::include_graphics("images/tidyr.jpg")

## ------------------------------------------------------------------------
## wide to long
gather(who)

who_long <- gather(who, group, cases, -country, -iso2, -iso3, -year)
who_long <- na.omit(who_long)

## long to wide
spread(who_long, key = group, value = cases)

## separate
separate(who_long, col = group, sep = "_", into = c("new", "pos", "patient"))

who_long <- separate(who_long, col = group, sep = "_", into = c("new", "pos", "patient"), remove = FALSE)


## ---- out.width = "100px", fig.align = "center", echo = FALSE------------
knitr::include_graphics("images/RStudio_Hex_dplyr.png")

## ------------------------------------------------------------------------
filter(who_long, year <= 2000)
filter(who_long, year <= 2000, country == "Afghanistan")

arrange(who_long, cases)
arrange(who_long, desc(cases))

select(who_long, country, cases, year)
select(who_long, country, number = cases, year)
select(who_long, -group)
select(who_long, starts_with("p"))

mutate(who_long, log_cases = log(1 + cases), cases2 = exp(log_cases) - 1)

summarise(who_long, m = mean(cases))

who_long <- mutate(who_long, gender = substr(patient, 1, 1))


who_long_by_country <- group_by(who_long, country)
summarise(who_long_by_country, m = mean(cases))
summarise(who_long_by_country, m = mean(cases), number = n())
summarise(who_long_by_country, m = mean(cases), log_mean = log(m))

who_long_by_country_gender <- group_by(who_long, country, gender)
summarise(who_long_by_country_gender, m = mean(cases))


## ---- out.width = "100px", fig.align = "center", echo = FALSE------------
knitr::include_graphics("images/RStudio_Hex_pipe.png")

## ---- out.width = "400px", fig.align = "center", echo = FALSE------------
knitr::include_graphics("images/magrittr_idea.png")

## ------------------------------------------------------------------------
who_long %>% group_by(country) %>% summarise(number = n(), m = mean(cases))

who_long %>% 
    filter(year <= 2000) %>% 
    group_by(country) %>% 
    summarise(number = n(), m = mean(cases))

## ------------------------------------------------------------------------
who_long %>% lm(cases ~ gender, data = .)

## ------------------------------------------------------------------------
iris %>% select(-Species) %>% map(mean)
iris %>% select(-Species) %>% map_df(mean)
iris %>% select(-Species) %>% map_dbl(mean)
iris %>% map_if(is.numeric, mean)

## ------------------------------------------------------------------------
who_long %>% 
    filter(year <= 2000) %>% 
    group_by(gender) %>% 
    summarise(number = n()) %>% 
    ggplot(aes(x = gender, y = number, fill = gender)) + geom_bar(stat = "identity")

## ---- out.width = "600px", fig.align = "center", echo = FALSE------------
knitr::include_graphics("images/data-science-model.png")

## ---- out.width = "100px", fig.align = "center", echo = FALSE------------
knitr::include_graphics("images/rstudio-hex-broom.png")

## ------------------------------------------------------------------------
mod <- lm(Sepal.Length ~ Petal.Length, data = iris)
glance(mod)
tidy(mod)
augment(mod) %>% head

## ------------------------------------------------------------------------
## by group
mod_by_sp <- iris %>% group_by(Species) %>% do(fit = lm(Sepal.Length ~ Petal.Length, data = .)) 
mod_by_sp
mod_by_sp %>% glance(fit)
mod_by_sp %>% tidy(fit)
mod_by_sp %>% augment(fit)

## ------------------------------------------------------------------------
iris %>% add_residuals(mod) %>% add_predictions(mod) %>% head

## ---- out.width = "100px", fig.align = "center", echo = FALSE------------
knitr::include_graphics("images/RStudio_Hex_stringr.png")

## ---- out.width = "100px", fig.align = "center", echo = FALSE------------
knitr::include_graphics("images/RStudio_Hex_lubridate.png")

