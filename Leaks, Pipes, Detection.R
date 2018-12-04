library(data.table)
library(dplyr)
library(tidyr)
library(ggplot2)
library(rlist)
library(lubridate)

#This is Kat's water loss file (a merge of overview.csv and foundational_09_balance.data)
filepath = "C:/Users/admin/OneDrive - Regis University/WaterLytics/TotalLossYear.csv" 
dt <- read.csv(filepath, sep = ',', header = TRUE)
summary(dt)

#Change index to factor for upcoming joins
dt$ce_annual_ndx <- as.factor(dt$ce_annual_ndx)
str(dt)

#read PercentLossValuesNoOutliers.xlsx (Cleaned water data)
CleanPercLoss <- read.csv('C:/Users/admin/OneDrive - Regis University/WaterLytics/PercentLossValuesNoOutliers.csv', sep = ',', header = TRUE)
str(CleanPercLoss)

#Rename columns to create ce_annual_ndx for joins
CleanPercLoss$ce_annual_ndx <- CleanPercLoss$ï..Row.Labels
CleanPercLoss$cleaned_loss_values <- CleanPercLoss$Sum.of.perc_loss_values
CleanPercLoss$ï..Row.Labels <- NULL
CleanPercLoss$Sum.of.perc_loss_values <- NULL
str(CleanPercLoss)

#Join cleaned %loss column from PercentLossValuesNoOutliers with Kat's file
dt1 <- right_join(CleanPercLoss, dt, by = c('ce_annual_ndx'))
str(dt1)

#Read more files, Foundational 6a, 
Found6a <- read.csv('C:/Users/admin/OneDrive - Regis University/WaterLytics/foundational_06a_loss_and_leak_det.csv', sep = ',', header = TRUE)
Found6a$ce_annual_ndx <- as.factor(Found6a$ce_annual_ndx)

#Join Found6a to base file dt1
dt2 <- right_join(Found6a, dt1, by = c('ce_annual_ndx'))
str(dt2)

#Read more files, Foundational 6b, Leak Detection Types
Found6b <- read.csv('C:/Users/admin/OneDrive - Regis University/WaterLytics/LeakDetTypes.csv', sep = ',', header = TRUE)
Found6b$ce_annual_ndx <- as.factor(Found6a$ce_annual_ndx)
str(Found6b)
Found6b$ï..ce_annual_ndex  <- NULL
str(Found6b)

#Join Found6b to base file dt2
dt3 <- right_join(Found6b, dt2, by = c('ce_annual_ndx'))
str(dt3)

#Ready for some stats!!
#Select the columns I want to use to create Loss dt, rename columns
dt3 <- as.data.table(dt3) # convert data to data table
Loss <- dt3[ , .(dt3$ce_annual_ndx, dt3$cleaned_loss_values, dt3$pctannual_pipe_replaces, dt3$pctannual_leak_inspection,
                dt3$replace_age_small_meters_years, dt3$time_between_tests_largemeters_years, 
                dt3$awwa_policy_adherence, dt3$meter_test_program, dt3$Reactive, dt3$Other, dt3$None, dt3$Active.Field.Testing,
                dt3$Active.Accounting, dt3$report_year)]
colnames(Loss) <- c('Index', 'Cleaned_Loss_Values', 'Pipe_Replace', 'Leak_Inspection', 
                    'Small_Meter_Replace', 'Time_BTW_Test',  
                    'AWWA_Compliance', 'Meter_Test_Program', 'Reactive', 'Other', 'None', 'Active_Field_Testing', 
                    'Active_Accounting_Testing', 'Year')
str(Loss)

#Analysis  
fit = lm(Cleaned_Loss_Values ~ Pipe_Replace + Leak_Inspection + Small_Meter_Replace + Time_BTW_Test +  
             + Meter_Test_Program + AWWA_Compliance, data=Loss)
summary(fit)
#Water loss looks correlated with the age at which the provider replaces small meters
plot(Loss$Cleaned_Loss_Values ~ Loss$Small_Meter_Replace)

#Clean dummy variables for Leak Detection Types
#Convert NAs to 0
Loss$Reactive[is.na(Loss$Reactive)] <- 0
Loss$Other[is.na(Loss$Other)] <- 0
Loss$None[is.na(Loss$None)] <- 0
Loss$Active_Accounting_Testing[is.na(Loss$Active_Accounting_Testing)] <- 0
Loss$Active_Field_Testing[is.na(Loss$Active_Field_Testing)] <- 0
str(Loss)

#Look at dummy variables for Leak Detection Type  
#Use aov 
fit3 <- aov(Cleaned_Loss_Values ~ Reactive + Other + None + Active_Field_Testing + Active_Accounting_Testing, data=Loss)
summary(fit3)

