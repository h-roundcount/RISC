---
title: "R Notebook"
output: html_notebook
---

```{r setup, include = FALSE}

library(tidyverse)  # Data Manipulation
#install.packages(haven)
library(haven)      # Read Stata Files - need it to zap labels later - for Krista, this was necessary for rendering but not for running interactively
#install.packages(sf) # Spatial Data - install once
library(ggplot2)
library(dplyr)
library(ERT)


ert <- read.csv("ert.csv")
```

```{r}

ert_df <- data.frame(ert) |>
  select(country_name, country_text_id, year, dem_ep, row_regch_event, reg_type, dem_ep_termination, dem_ep_outcome_agg, dem_pre_ep_year, aut_ep_termination,v2x_polyarchy, aut_ep_prch)
view(ert_df)

```

```{r}
library(htmlwidgets)
library(plotly)
labels <- c("Censored", "Stasis", "Year Drop", "Cumulative Drop", "Closed or Breakdown")

dep_term_plot <- ggplot(ert)+
  geom_histogram(aes(x=dem_ep_termination), bins = 10, fill = "lightblue") + theme_bw() +
  xlab("Termination Type") + scale_x_continuous(labels = labels) + ggtitle("Frequency of Type of Termination of a Democratic Episode")

dep_term_plot

saveWidget(ggplotly(dep_term_plot), file = "dep_term_plot.html")
```

```{r}
labels <- c("Censored", "Stasis", "Year Increase", "Cumulative Increase", "Democratic Episode")

aut_term_plot <- ggplot(ert)+
  geom_histogram(aes(x=aut_ep_termination), bins = 10, fill = "coral") + theme_bw() +
  xlab("Termination Type") + scale_x_continuous(labels = labels) + ggtitle("Frequency of Type of Termination of an Autocratic Episode")

aut_term_plot

saveWidget(ggplotly(aut_term_plot), file = "aut_term_plot.html")
```

```{r}
ert_df_country <- ert_df |>
  filter(country_name == "Mexico")



dem_index_plot <- ggplot(data = ert_df_country, aes(x=year, y=v2x_polyarchy))+
  geom_line(color = "darkslategray") +
   geom_smooth( orientation= "x", color = "darkslategray1") +
  xlab("Year") + ylab("EDI Score") +
  ggtitle("Mexico's Electoral Democracy Index (EDI) Scores Over Time") + theme_bw() + scale_x_continuous(n.breaks = 10)

dem_index_plot

saveWidget(ggplotly(dem_index_plot), file = "dem_index_plot.html")

```
