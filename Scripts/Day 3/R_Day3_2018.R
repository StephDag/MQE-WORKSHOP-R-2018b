# Exercise 1
?rnorm
x <- rnorm()
length(x)
pnorm()


?Distributions


# Exercise 2
?pgamma
pgamma()
?pexp
pexp()


# Exercise 3
?pbirthday
pbirthday()


# Exercise 4
shells <- read.csv('shells.csv') # import data into dataframe
head(shells)                     # prints out the first few rows
names(shells)                    # names of columns in dataframe
summary(shells)                  # summary of values in dataframe
levels(shells$type)              # levels of categorical variable
?t.test                          # help on the t test function
?wilcox.test                     # help on the wilcoxon function

# MC randomization test related to Exercise 4
exposed   <- shells$length[shells$type=='exposed']
sheltered <- shells$length[shells$type=='sheltered']
diff      <- mean(exposed) - mean(sheltered)
combined  <- c(exposed, sheltered)
rand_r    <- c() # vector to store differences in means
for(i in 1:1e4) {
  #random permutation of full set of samples
  sample_r    <- sample(combined, size = length(combined), replace = FALSE)
  # allocation of samples to exposed group
  exposed_r   <- sample_r[1:length(exposed)]
  # allocation of samples to sheltered group
  sheltered_r <- sample_r[(length(exposed)+1):length(sample_r)]
  # difference in means for permuted samples
  rand_r[i]   <- mean(exposed_r) - mean(sheltered_r)
}
hist(rand_r) # plot of differences under null model
diff         # empirically observed difference in means
# p values under different null hypotheses
length(rand_r[abs(diff) <= abs(rand_r)])/1e4

# bootstrap 95% CI for shell data related to Exercise 4
boot_r <- c()          # vector to store bootstrap values
for(i in  1:10000) {   # sets up loop
  # random draw of exposed samples
  exposed_r <- sample(exposed, size = length(exposed), replace = TRUE)
  # random draw of sheltered samples
  sheltered_r <- sample(sheltered, size = length(sheltered), replace = TRUE)
  # bootstrap difference in means
  boot_r[i] <- mean(exposed_r) - mean(sheltered_r)
}
hist(boot_r)
boot_r <- sort(boot_r)  # sort values from smallest to largest
boot_r[250]             # lower 95% CI
boot_r[9750]            # upper 95% CI


# Exercise 5
tapply(shells$length,shells$type,mean)                # mean for each group
delta <- diff(tapply(shells$length,shells$type,mean)) # difference in means
tapply(shells$length,shells$type,var)                 # var for each group
sqrt(mean(tapply(shells$length,shells$type,var)))     # pooled standard deviation estimate (equal sample sizes)
?power.t.test
power.t.test(n=,delta=,sd=,power=NULL)
power.t.test(n=NULL,delta=,sd=,power=0.80)


# Exercise 6
gala <- read.table('gala.txt',header=TRUE,row.names=1)
head(gala)      # prints out the first few rows
names(gala)     # names of columns in dataframe
summary(gala)   # summary of values in dataframe


# Exercise 7



# Exercise 8
gala$log.nearest <- log10(gala$Nearest)


# Exercise 9
mangroves <- read.csv('mangroves.csv')
mangroves$treatment.f <- 
  lm1 <-
  lm2 <-
  
  
  

