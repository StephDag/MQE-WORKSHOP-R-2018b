################################  FILE LICENSE  ################################
#
#	This file is copyright (C) 2018 Matthew Kosnik
#
#	This program is free software; you can redistribute it and/or modify it 
#	under the terms of version 2 the GNU General Public License as published 
#	by the Free Software Foundation.
#
#	This program is distributed in the hope that it will be useful, but WITHOUT
#	ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or 
#	FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for 
#	more details.
#
#	To view a copy of the license go to:
#	http://www.fsf.org/copyleft/gpl.html
#	To receive a copy of the GNU General Public License write the Free Software
# 	Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
#
################################################################################

###############################  ABOUT THIS CODE  ##############################
#
#	This file contains R code for "Day 3 in R" session
#		based on material by: Andrew Allen
#		modified by Matthew Kosnik
#		last modified 2018.11.12
#
################################################################################

##	Topic 1: Statistical distributions
################################################################################
# R has functions to work with statistical distributions including functions
# for density, distribution function, quantile function and random generation
# the normal distribion is abbreviated "norm"
? dnorm()

# Probability density function, e.g. the height of the curve at x
# EXAMPLE: what is the height of the curve at 0.3?
dnorm(0.3)
# QUESTION: what distribution parameters are used for this calculation?
# IMPORTANT: many functions have default arguments, make sure you check

# Cumulative distribution function, e.g., how much area is under the curve?
# EXAMPLE: what probability of a value less than or equal to 0.3?
pnorm(0.3)

# EXERCISE: what is the probability of a value greater than 0.3?
pnorm(0.3, lower.tail=FALSE)


# Quantile function, e.g., what value has a probability of x?
# EXAMPLE: what value correspond with the 95% confidence interval?
qnorm(0.95)

# Random variates from a normal distribution
rnorm(10)

# EXERCISE: plot a histogram of 100 random numbers drawn from a normal distribution
hist(rnorm(100))

# EXERCISE: what is the mean of 100 random numbers drawn from a normal distribution
mean(rnorm(100))

# EXERCISE: what is the standard deviation of 100 random numbers drawn from a normal distribution
sd(rnorm(100))

# NOTE: everyone will get slightly different answers.
# NOTE: you will likely not get a mean of 0 or a sd of 1 (or whatever values you used)
# NOTE: the more random numbers you draw the closer you will get to the x & sd specified
# NOTE: beware of default values... are they the values you want?

# EXERCISE: assign to vector a random sample of 1000 numbers drawn from a normal distribtion with a mean of 10 and standard deviation of 5.
rn <- rnorm(1000, mean=10, sd=5)

# EXERCISE: in that vector what proportion of values are less than 5?
length(rn[rn<5]) / length(rn)

# EXERCISE: use pnorm to calculate the predicted fracion
pnorm(q=5, mean=10, sd=5)

# NOTE: everyone will get slightly different answers.
# NOTE: you will likely not get a mean of 10 or a sd of 5
# NOTE: the more random numbers you draw the closer you will get to the x & sd specified

# QUESTION: what other distributions are built into base R?
? Distributions

################################################################################
# A random asside on packages, citations and "found code"
#
# NOTE: "Base R" refers to those packages, functions, data installed by default.
# - You should always cite R and the version, TIP: citation()
# NOTE: If you load additional packages then you should cite them too...
# - citation('packageName') will give you the prefered citation. include version.
# NOTE: anyone can write packages, so quality varies...
# - I recommend using base R if possible (highest quality control).
# - If not base R then use the most well used & documented package you can find.
# - always double check and understand any code you "find" and use... quality varies.
################################################################################

# EXERCISE: What is the probability that a random variate from a gamma distribution with a shape parameter = 3 and scale parameter = 1 is > 0.68, hint: pgamma()?
pgamma(0.68, shape=3, scale = 1, lower.tail=F)
1 - pgamma(0.68, shape=3, scale = 1)

# EXERCISE: What is the probability that a random variate from an exponential distribution with rate = 0.05 lies between 1 and 10, hint: pexp()?
pexp(10, rate=0.05) - pexp(1, rate=0.05)

# EXERCISE: What is the probability that 2 people in this room share the same birthday
? pbirthday()

# An asside / tips on specification of function arguements
# - can specify names or R will assume that position matches the documentation
# - it is typically okay to use position for common / familiar functions
# - it is safer to use names for functions with more arguments

# EXAMPLE: 1,2,3 give the same answer, but 4 does not...
pbirthday(15,365,2)
pbirthday(n = 15, classes = 365, coincident = 2)
pbirthday(classes = 365, coincident = 2, n = 15)
pbirthday(365,2,15)


##	Topic 2: Simulations
################################################################################
# for example: a simple random walk similation is easy to do

# EXAMPLE: a random walk of 500 steps
steps <- rnorm(n=5000, mean=0, sd=1)
distance.from.origin <- cumsum(steps)
plot(distance.from.origin,type='l')

# EXAMPLE: replicate random walks of 500 steps
plot(1:1,ylim=c(-250,250),xlim=c(0,length(steps)), type='n')
for (i in 1:100) {
	
	steps <- rnorm(n=5000, mean=0, sd=1)
	distance.from.origin <- cumsum(steps)
	lines(distance.from.origin, lwd=0.5, col=rgb(0.3,0.3,0.3,0.3))
	
}

# A random asside on random variates
#	- always get something different, which can be a pain.
#	- but computers are only pseudorandom, based on a starting "seed value"
#	- set.seed() is a function that enables setting the same seed.
#	- set.seed() means everyone gets the same result everytime... very good for debugging.

# EXAMPLE: everyone gets the same answer...
set.seed(1)
plot(1:1,ylim=c(-250,250),xlim=c(0,length(steps)), type='n')
for (i in 1:100) {
	steps <- rnorm(n=5000, mean=0, sd=1)
	distance.from.origin <- cumsum(steps)
	lines(distance.from.origin, lwd=0.5, col=rgb(0.3,0.3,0.3,0.3))
}


##	Topic 3: Summary stats
################################################################################
# not exciting, but R can calculate all the summary stats you might expect
summary(steps)

# also... min(), max(), range(), mean(), median(), quantile(), IQR(), var(), sd(), fivenum()

quantile(steps)

# Random asside: Why I love R documentation
# - how complicated can something like quantiles be?
# - this is why sometimes different programs give different answers.
? quantile()

# also... boxplot()
boxplot(steps)

# QUESTION: In the box plot - what are the thick horizontal line, the box, the whiskers?
? boxplot()

# QQ (quantile-quantile) plot, useful for testing assumptions of normality...
# HINT: if the assumption is correct we should get a straight line
qqnorm(steps)
qqline(steps)
 
# EXERCISE: most of us have a lot less than 5000 samples, so how about a qq plot for n=50
# NOTE: it can be disturbing to see how much noise we should expect to see
x <- rnorm(50)
qqnorm(x)
qqline(x)

# TIP: streamline repetitive tasks...
# apply(), useful for generating the same summary statistic for all rows / columns
# tapply(), useful for generating the a summary statistic for groups of rows / columns
# EXAMPLE: using iris data.
data(iris)
apply(iris[,1:4], MARGIN=2, FUN=mean)
tapply(X=iris$Sepal.Length, INDEX=iris$Species, FUN=median)

# EXERCISE: what is the maxiumum sepal width by species?
tapply(X=iris$Sepal.Width, INDEX=iris$Species, FUN=max)


##	Topic 4: t-tests, Wilcoxon test and related
################################################################################
# This is not a stats class, but an introduction to doing statistical tests in R
# I assume you know about William Gosset, his employer, and the probable error of a mean
? t.test()

## DATA (I am not sure where Drew sourced these data)
# - shell size data in mm from Trunk Reef (Great Barrier Reef, Australia)
# - two sites: wave exposed and sheltered

# EXERCISE: load data in './data/shells.csv', verify that is okay
shells <- read.csv('./data/shells.csv', row.names=1) 
summary(shells)

# EXERCISE: plot length ~ site to get a sense for the data. bonus: add points.
plot(length ~ site, data=shells, col='grey')
points(length ~ site, data=shells, pch=19)

## FORMULA NOTATION: BASICS
########################
# (response ~ predictor, dataframe)
# (dependent ~ independent, dataframe)
# - can be used lots of places...

# EXAMPLE: two-sample t-test: Does mean shell size differ between the two sites?
t.test(length ~ site, shells)

# QUESTIONS: 
# - What is the mean difference in shell length between the two sites?
# - What is the 95% confidence interval for the difference? 
# - Is the difference significant at the P = 0.05 level for the two-tailed test?

# EXERCISE: Welch? Run a Student's t.test()
t.test(length ~ site, shells, var.equal=TRUE)

# EXERCISE: One-sample t-test: The mean shell size is 14
t.test(shells$length, mu=14)

# QUESTIONS: 
#	- Is the difference significant at the P = 0.05 level?
#	- What is the 95% confidence interval for the mean? 

# Wilcoxon Rank Sum Test, e.g., non-Parametric t-test equivalent
########################
# - does not assume the distribution from which the samples are drawn
# - non-parametrics are good for non-normal data
# - assumptions:
#	  random sample of the population from which they are drawn
#	  independence within samples and mutual independence between samples
#	  measurement scale is at least ordinal	
wilcox.test(length ~ site, shells)

# QUESTION: 
# - Is the difference significant at the P = 0.05 level for the two-tailed test?

# Monte Carlo methods
########################
# broad class of computational methods that use random sampling to solve problems
# useful for sample permutations.
# shuffle data, split randomly to ensure the same number of samples per group as original data. repeat to generate a distribtion of expected differences in mean.
# if people want we can come back to this... MC can be super useful

# Power... critical to planning research
########################
# Power is the conditional probability of rejecting the null hypothesis given that it is really false
# 1 - Power = Type II error.
# depends on:
#	alpha: significance level
#	effect size: how big is the difference?
#	sample size: a given effect is easier to detect with larger sample sizes
#	estimated variance: it is harder detect effects between more variable populations

? power.t.test()

 # QUESTION: what is the smallest of the two groups (n)?
 # QUESTION: what is the difference between the two groups (delta)?
 # QUESTION: what is the sd of dataset (sd)?
 # EXERCISE: what is the power of the shell dataset?
 power.t.test(n=51, delta = 2.2, sd=4.4)

 # EXERCISE: what is the sample size required for a power of 0.80?
 # NOTE: there is nothing magical about a power of 0.8, but it is a good starting point
 # SUGGESTION: play around with delta & sd to see how it changes the required sample size
 power.t.test(delta = 2.2, sd=4.4, power=0.80)
 
 
##	Topic 5: linear models and related
################################################################################
# This is not a stats class, but an introduction to doing statistical tests in R
# I assume you know at least a little about regresson models...

# Asside: assumptions of a linear regression:
# - Linearity of the relationship between dependent and independent variables
# - Independence of the errors (no serial correlation)
# - homoscedasticity (constant variance) of the errors
# - normality of the error distribution 
## DATA
# M.P. Johnson and P.H. Raven. 1973. Species number and endemism: The Galapagos Archipelago revisited. Science 179: 893-895
# Variables:
# - Species the number of plant species found on the island
# - Endemics the number of endemic species
# - Area the area of the island (km^2)
# - Elevation the highest elevation of the island (m)
# - Nearest the distance from the nearest island (km)
# - Scruz the distance from Santa Cruz island (km)
# - Adjacent the area of the adjacent island (square km)

# EXERCISE: load data in './data/gala.txt', verify that is okay
#	TIP: make values from "Island" the row names (you will notice later in the plot)
gala <- read.table('./data/gala.txt', header=TRUE, row.names=1) 
head(gala)

# EXERCISE: quick visualisation of the data using pairs()
pairs(gala)

# EXAMPLE: use lm() to look at the species area relationship.
gala.model <- lm(Species ~ Area, data=gala)

# QUESTION: what is in 'gala.model'
str(gala.model)

# that is everything and a bit ugly, but special fucntions can get what you want easily
summary(gala.model)
residuals(gala.model)
coef(gala.model)
anova(gala.model)
confint(gala.model)

# A quick way to look at how this model fits...
summary(gala.model)
plot(gala.model)

# EXERCISE: quick visualisation of the data using pairs() for log(gala)
pairs(log(gala))

# EXERCISE: log10 transform variables (Species & Area) and try again.
gala$logSpecies <- log10(gala$Species)
gala$logArea <- log10(gala$Area)
gala.model <- lm(logSpecies ~ logArea, data=gala)

summary(gala.model)
plot(gala.model)

# EXERCISE: plot the species area relation and put the regression line on it, hint: abline()
plot(logSpecies ~ logArea, data=gala)
abline(gala.model)

# multiple linear regression...
########################
# More on formula notation
# - lm(y~1, data). intercept only
# - lm(y~x-1, data). force-fit y versus x through the origin.
# - lm(y~x1+x2+x3, data). y is a function of x1 and x2 and x3
# - lm(y~., data). fit y versus all the variables in the dataframe
# - lm(y~.-x7, data). fit y versus all the variables in the dataframe, except x7
# - lm(y~x1*x2-1, data). fit y versus x and the interactions between x1 and x2

# EXAMPLE: add log10 transformed elevation and try again, put the model in a new object.
gala$logElevation <- log10(gala$Elevation)
gala.model2 <- lm(logSpecies ~ logArea + logElevation, data=gala)
anova(gala.model,gala.model2)

# stepwise model selection
# - Controversial among statisticians due to multiple comparisons problem, but still useful for exploration
# define an initial model, the full model as produced by lm()
# define a scope, a full model formula
? step()

# EXERCISE: add log10 transformed nearest, adjacent, Scruz+1 and fit again, put the model in a new object.
gala$logNearest <- log10(gala$Nearest)
gala$logScruz <- log10(gala$Scruz+1)
gala$logAdjacent <- log10(gala$Adjacent)

galaLog <- gala[,grep('log',colnames(gala))]

gala.model3 <- lm(logSpecies ~., data=galaLog)
# QUESTION: do all the extra variables improve the model?
summary(gala.model3)

# EXAMPLE: use step() to determine the best model
step(gala.model3,direction='backward')

# backwards step selection drops models to get the lowest possible AIC.

# QUESTION: what variables are included the best model?
#	- does that make biological sense?


##	Topic 5: ANOVA
################################################################################
# This is not a stats class, but an introduction to doing statistical tests in R
# I assume you know at least a little about analysis of variance...

## DATA
# Ellison et al. 1996, Cotelli & Ellison Ch 10.
# - Question: Are there effects of sponges on mangrove growth?
# - Experiment: Measured root growth in each of 4 treatments (n = 14):
# - 1 Bare roots (Control)
# - 2 Roots with artificial foam (Foam)
# - 3 Roots with red fire sponge (Tedania)
# - 4 Roots with Purple sponge (Haliclona)

# EXERCISE: load data in './data/mangroves.csv', verify that is okay
mangroves <- read.csv('./data/mangroves.csv', header=TRUE) 
head(mangroves)
summary(mangroves)

# make a factor treatment variable
mangroves$treatment.f <- as.factor(mangroves$treatment)

# EXERCISE: plot growth ~ treatment.f
plot(growth ~ treatment.f, mangroves, col='grey')
points(growth ~ treatment.f, mangroves, pch=19)

# EXERCISE: LM
mm <- lm(growth ~ treatment.f, mangroves)

summary(mm)

anova(mm)

# EXAMPLE: Which groups are signficiant?
TukeyHSD(aov(mm))