#### Preamble ####
# Purpose: Clean the survey data downloaded from Open data Toronto
# Author: Xuetong Tang
# Data: 3 January 2021
# Contact: louis.tang@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# - Need to have downloaded the ACS data and saved it to inputs/data
# - Don't forget to gitignore it!
# - Change these to yours
# Any other information needed?


#### Workspace setup ####
# Use R Projects, not setwd().
library(tidyverse)
library(kableExtra)
library(opendatatoronto)
library(dplyr)

# get package
package <- show_package("ac77f532-f18b-427c-905c-4ae87ce69c93")
package

# get all resources for this package
resources <- list_package_resources("ac77f532-f18b-427c-905c-4ae87ce69c93")

# identify datastore resources; by default, Toronto Open Data sets datastore resource format to CSV for non-geospatial and GeoJSON for geospatial resources
datastore_resources <- filter(resources, tolower(format) %in% c('csv', 'geojson'))

# load the first datastore resource as a sample
data <- filter(datastore_resources, row_number()==1) %>% get_resource()
data

#data cleaning#
cleaned_data <- data %>% filter(!is.na(data))%>%
  mutate(total_enter=returned_from_housing+newly_identified+returned_to_shelter, total_leave=no_recent_shelter_use+moved_to_housing)%>%
  mutate(year=substr(`date(mmm-yy)`, 5, nchar(`date(mmm-yy)`)))%>%
  select(year,`date(mmm-yy)`, population_group, population_group_percentage,actively_homeless, newly_identified, total_enter,total_leave,`date(mmm-yy)`)

         

#### What's next? ####



         