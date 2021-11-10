############
# Lavaan tutorial for R-thritis session 21.5.21
# James Gwinnutt
############


##### Install package and set up libraries ####

# clear the workspace
rm(list=ls())

# install packages and call lavaan
# install.packages("lavaan")
library(lavaan)

# lavaan plot
# lavaanPlot has been removed from CRAN, you can download using this code
# or from the CRAN archive
# devtools::install_github("alishinski/lavaanPlot")
library(lavaanPlot)

# install psych
# install.packages("psych")
library(psych)

# and tidyverse
# install.packages("tidyverse")
library(tidyverse)

# foreign to open spss dataset from the web
# install.packages("foreign")
library(foreign)


##### Defining a model ####
data("PoliticalDemocracy")
head(PoliticalDemocracy)
describe(PoliticalDemocracy)
?PoliticalDemocracy

model <- '
          # measurment model
          ind60 =~ x1 + x2 + x3
          dem60 =~ y1 + y2 + y3 + y4
          dem65 =~ y5 + y6 + y7 + y8
          # regressions
          dem60 ~ ind60
          dem65 ~ ind60 + dem60
          '
fit <- cfa(model, data=PoliticalDemocracy, std.lv=F)
summary(fit, fit.measures=TRUE, standardized= TRUE, rsquare=TRUE, ci=TRUE)

# lavaan plot - make sure the model you fitted is correct
lavaanPlot(model= fit, 
           node_options = list(shape = "box", fontname = "Helvetica"), 
           edge_options = list(color = "grey"), 
           coefs = TRUE, stand = FALSE)


##### Path analysis #####

# create the mediation data
# open iris data
rm(list=ls())
data(iris)
df <- iris
# simulate a mediator
# code from here: https://towardsdatascience.com/doing-and-reporting-your-first-mediation-analysis-in-r-2fe423b92171

# simulate 'attractiveness to bees'
set.seed(200)
df$random1=runif(nrow(df),min=min(df$Sepal.Length),max=max(df$Sepal.Length))
df$mediator=df$Sepal.Length*0.35+df$random1*0.65

# simulate 'liklihood to be pollinated
df$random2=runif(nrow(df),min=min(df$mediator),max=max(df$mediator))
df$dv=df$mediator*0.35+df$random2*0.65

# rename the variables
df <- df %>% rename(attractiveness = mediator)
df <- df %>% rename(pollinated = dv)

# linear regression to see total effect
lm <- lm(pollinated ~ Sepal.Length, data=df)
summary(lm)

# code the mediation in lavaan
bee_model <- ' # regressions
                attractiveness ~ a*Sepal.Length
                pollinated ~ b*attractiveness
                pollinated ~ c*Sepal.Length

                # indirect effect (a*b)
                sepal_attract := a*b
                # total effect
                total := c + (a*b)
                '

# fit and inspect the model
fit_bee <- cfa(model = bee_model, data = df)
summary(fit_bee, fit.measures=TRUE, standardized= TRUE, rsquare=TRUE, ci=TRUE)

# plot
lavaanPlot(model= fit_bee, 
           node_options = list(shape = "box", fontname = "Helvetica"), 
           edge_options = list(color = "grey"), 
           coefs = TRUE, stand = FALSE)


##### Confirmatory factor analysis #####

# example from here: https://stats.idre.ucla.edu/r/seminars/rcfa/
rm(list=ls())
dat <- read.spss("https://stats.idre.ucla.edu/wp-content/uploads/2018/05/SAQ.sav",
                 to.data.frame=TRUE, use.value.labels = FALSE)
class(dat$q01)
head(dat)

# first 8
dat2 <- dat[,1:8]
describe(dat2)

#correlation
cor.plot(cor(dat2))


one_factor2 <-'spss_anx =~ q01 + q02 + q03 + q04 + q05 + q06 + q07 + q08'
one_factor_cfa <- cfa(model = one_factor2, data = dat2, std.lv=T)
summary(one_factor_cfa, fit.measures=TRUE, standardized=TRUE) 

# plot
lavaanPlot(model= one_factor_cfa, 
           node_options = list(shape = "box", fontname = "Helvetica"), 
           edge_options = list(color = "grey"), 
           coefs = TRUE, stand = FALSE)


# 2 factor model
# as we have a factor with only 2 indicators, we need to constrain the
# factor loadings to be the same, for identification purposes
two_factor <- 'spss_anx =~ q01 + q03 + q04 + q05 + q08
                tech_fear =~ a*q06 + a*q07'

two_factor_cfa <- cfa(model = two_factor, data = dat2, std.lv=T)
summary(two_factor_cfa, fit.measures=TRUE, standardized=TRUE) 

# plot
lavaanPlot(model= two_factor_cfa, 
           node_options = list(shape = "box", fontname = "Helvetica"), 
           edge_options = list(color = "grey"), 
           coefs = TRUE, stand = FALSE)






##### SEM ####
rm(list=ls())
dat <- read.csv("https://stats.idre.ucla.edu/wp-content/uploads/2021/02/worland5.csv")

# dataset of various factors related to student's background and academic acheivement:

# Adjustment
# motiv = Motivation
# harm = Harmony
# stabi = Stability

# Risk
# ppsych = (Negative) Parental Psychology
# ses = SES
# verbal = Verbal IQ

# Achievement
# read = Reading
# arith = Arithmetic
# spell = Spelling

# Question - what is the assocaition between adjustment & risk on school achievement

# first, define the model
model <- '# measurement model
          adjust =~ motiv + harm + stabi
          risk =~ verbal + ppsych + ses
          achieve =~ read + arith + spell
          
          # regressions
          achieve ~ adjust + risk
          '
# fit model
fit <- sem(model, data=dat)

summary(fit, fit.measures=TRUE, standardized=TRUE) 

# plot
lavaanPlot(model= fit, 
           node_options = list(shape = "box", fontname = "Helvetica"), 
           edge_options = list(color = "grey"), 
           coefs = TRUE, stand = FALSE)

# does adjustment mediate the relationship between risk and achievement?
model2 <- '# measurement model
          adjust =~ motiv + harm + stabi
          risk =~ verbal + ppsych + ses
          achieve =~ read + arith + spell
          
          # regressions
          achieve ~ b*adjust + c*risk
          adjust ~ a*risk
          
          # indirect effect (a*b)
          risk_achieve := a*b
          # total effect
          total := c + (a*b)
          '
fit2 <- sem(model2, data=dat)

summary(fit2, fit.measures=TRUE, standardized=TRUE) 

# plot2
lavaanPlot(model= fit2, 
           node_options = list(shape = "box", fontname = "Helvetica"), 
           edge_options = list(color = "grey"), 
           coefs = TRUE, stand = FALSE)


