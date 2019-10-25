# regiswaterlyticsco

The purpose of this project is to explore the HB 1051 data with a dual focus: on water leakage as well as water production by population size. The data can be obtained from the [CWCB Water Efficiency Data Portal](http://cowaterefficiency.com/unauthenticated_home) with permission. Once in the portal, all report years (2013-2017) were selected as well as all water providers.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine.

### Prerequisites

[R](https://www.r-project.org/) and [RStudio](https://www.rstudio.com/products/rstudio/download/). 

[Download and Install R and RStudio here](https://courses.edx.org/courses/UTAustinX/UT.7.01x/3T2014/56c5437b88fa43cf828bff5371c6a924/)

Once R and RStudio are installed, the following R packages are required:
* sqldf
* data.table
* dplyr
* tidyr
* ggplot2
* rlist
* lubridate  

Install and load these packages using the following commands in RStudio:
```
install.packages("<package_name>")
library(<package_name>)
```

### Installing/Downloading

*TODO*

## File Descriptions

**leak2.rmd** & **leak2.pdf** -  The purpose of this file is to explore the HB1051 data with emphasis on water leakage. Files were merged to create water leakage reporting by water provider and year. Data is displayed graphically and recommendations are provided for cleaning up potential reporting errors. The .rmd contains the raw markdown file, the pdf is just a printed version of this. This report uses overview.csv & foundational_09_balance_data.csv from the HB 1051 data

**meterGreaterDistributedChart.PNG**  - This chart shows which cities during which years have metered water greater than distributed water.

**ngrams.rmd** & **n.grams.pdf** - The purpose of this file is to conduct text analysis on the leak_detection_field_technology column in the foundational_06a_loss_and_leak_detection file. Distributions of time between testing and age to replace small meters in years are shown. Recommendations for reporting are suggested to leverage this information. The .rmd file contains the raw markdown file, the pdf is just a printed version of this. This report uses foundation_06a_loss_and_leak_detection_technology.csv.

**Statistical Analysis Water Loss.R** - The purpose of this file is to analyze how AWWA policy adherence relates to water loss. Percent water loss was calculated for each municipality.  Once the data was cleaned for outliers a Wilcoxon Rank Sum test was performed on percent water loss versus municipalities that were AWWA policy adherence on their potable treated water.  We found that municipalities that were AWWA policy adherent had significantly more percent water loss than municipalities that were not AWWA policy adherence.

**waterByCity.rmd** & **waterByCity.pdf** - The purpose of this file is to explore the HB 1051 data with an emphasis on population and water production projections. Files were merged to create datasets of with population and water production in one place, separated by water type (i.e. potable, non-potable raw, and non-potable reuse). A linear model was fit to potable water production based on populatio nserved. Population data by county/municipality was also used to create population projections by county until the year 2050. These population projections were used to anticipate necessary potable water production per county until the year 2050. This report uses overview.csv, normalizing_03_population.csv, water_use_02_production.csv, & [Historical Census Data](https://demography.dola.colorado.gov/population/data/historical_census/)

## Built With

* [RStudio](https://www.rstudio.com/) - The IDE used to analyze all data and generate R Markdown files

## Authors

* **Cynthia Mann** - *Data Visualization* - [jambel77](https://github.com/jambel77)
* **David Sciacca** - *Water Production Projection Model; README.md* - [dsciacca](https://github.com/dsciacca)
* **Kellen Sorauf** - *Population Projection Model; AWWA Adherance Analysis* - [mrsnellek](https://github.com/Mrsnellek)
* **Lolita Mannik** - *Leak Analysis; Powerpoint Presentation* - [ChihuaWars](https://github.com/ChihuaWars)
* **Yekaterina Bardash** - *Leak Data Preparation and Analysis; N-grams Analysis* - [ybardashRegis](https://github.com/ybardashRegis)

See also the list of [contributors](https://github.com/ybardashRegis/regiswaterlyticsco/graphs/contributors) who participated in this project.

## Acknowledgments

* The Colorado Governor’s Office of Information Technology for putting on the *Smart Data Analytics Challenge - Addressing Colorado’s Critical Issues*

