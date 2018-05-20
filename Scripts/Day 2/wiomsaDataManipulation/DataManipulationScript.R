###############################################
##### Script for "Data manipulation in R" #####
###############################################

# originally prepared by David Nipperess
# modified by Matthew Kosnik

##### Preliminary 1: Set up workspace ###########
#################################################

# Set up a new project in R Studio
# Where is your working directory?
# Are the files you need in your working directory?

##### Preliminary 2: Data objects in R ##########
#################################################

# this should all be review from yesterday, but it is a good review as. it is important.

# define a vector of the numerical values 1 to 27 and assign to an object called x
## @knitr DM1
x <- 1:27
x
## @knitr end DM1

# define a matrix (assign to y) with 9 rows and 3 columns using the data in x
## @knitr DM2
y <- matrix(data=x, nrow=9, ncol=3)
y
## @knitr end DM2

# extract a vector from y using the numerical indices in x
## @knitr DM3
y[x]  # referencing an object with another object
## @knitr end DM3

# define a 3-dimensional array (assign to z) with 3 rows, 3 columns and 3 layers, using the data in x
## @knitr DM4
z <- array(data=x,dim=c(3,3,3))
z
## @knitr DM5
z[1,,]
## @knitr DM6
z[x]
## @knitr end DM6
# extract a reversed vector from z using x
## @knitr DM7
z[rev(x)]
## @knitr end DM7
# QUESTION: What does the function rev() do? 
# QUESTION: How can you find out?

# browse the datasets available in R, find Edgar Anderson's Iris data and load it as a dataframe 
# 50 replicate measurements for each of 3 species of Iris
## @knitr DM8
data()
## @knitr DM9
data(iris)
## @knitr end DM9
# QUESTION: what does head() do?
## @knitr DM10
head(iris)
## @knitr end DM10

# QUESTION: what does dim() do?
## @knitr DM11
dim(iris)
## @knitr end DM11

# QUESTION: what does mode() do?
## @knitr DM12
mode(iris)
## @knitr end DM12

# use as.matrix() to convert the iris dataset to a matrix and use head() & mode() to check the data
## @knitr DM13
iris2 <- as.matrix(iris)
head(iris2)		# Question: why quotes?
mode(iris2)		# Question: character?
## @knitr end DM13

# QUESTION: what happens when you try to take the mean of iris2[,'Sepal.Length']
## @knitr DM14
mean(iris2[,'Sepal.Length'])		# Problem...
## @knitr end DM14

# use as.matrix() to convert only the numeric columns of iris dataset. Check the data.
## @knitr DM15
iris3 <- as.matrix(iris[,1:4])
head(iris3)
mode(iris3)
## @knitr end DM15

# QUESTION: what is the mean sepal length?
## @knitr DM16
mean(iris3[,'Sepal.Length'])				# Answer...
## @knitr end DM16

# QUESTION: how might we work around this issue, hint: as.numeric()?
## @knitr DM17
mean(as.numeric(iris2[,'Sepal.Length']))	# Work around.
## @knitr end DM17

## using matrices instead of data frames 

# when data is all numbers (except for row and column names), I normally use matrices rather than dataframes
# if you have row names in your data file, and you want to convert to a matrix, you will need to specify which column has the row names (see the row.names argument in the read.table function)

##### Exercise 1: Reading data ##################
#################################################

##	 Use the read.table (and related functions) to read in datafiles: "carbonateMetaData.txt", "carbonateMassData.csv", "carbonateSynonomy.csv"

## ABOUT THESE DATA: These are sediment samples from Heron Reef. Students were instructed to sort the sediment into the organisms that created it, and to report the weight of each taxonomic group in grams. "carbonateMassData.csv" contains the mass by taxonomic group data. "carbonateMetaData.txt" contains metadata - information aboit the sample provided to the students. "carbonateSynonomy.csv" is a list of spelling corrections and synonomies that I use to harmonise the data without changing the original data.

##	TIP: always inspect your data BEFORE attempting to import into R 

# use read.table() to read carbonateMetaData.txt. read.table() is the generic function
## @knitr DM18
setwd("/Users/stephdagata/Documents/GitHub/MQE-WORKSHOP-R-2018b/Scripts/Day 2/wiomsaDataManipulation/")
cMeta <- read.table("./data/carbonateMetaData.txt", header=TRUE, sep="\t", as.is=TRUE)
## @knitr end DM18

# read.delim() is read.table(), but will default values set for tab-delimited files
# use it to read ./data/carbonateMetaData.txt
## @knitr DM19
setwd("/Users/stephdagata/Documents/GitHub/MQE-WORKSHOP-R-2018b/Scripts/Day 2/wiomsaDataManipulation/")
cMeta <- read.delim("./data/carbonateMetaData.txt")
## @knitr end DM19

# read.table() is the generic function and can read csv files...
## @knitr DM20
setwd("/Users/stephdagata/Documents/GitHub/MQE-WORKSHOP-R-2018b/Scripts/Day 2/wiomsaDataManipulation/")
cMass <- read.table('./data/carbonateMassData.csv', header = TRUE, sep = ",", quote = "\"", fill = TRUE, comment.char = "", as.is=TRUE)
## @knitr end DM20

# read.csv() is read.table(), but will default values set for csv files
# use it to read: ./data/carbonateSynonomy.csv
## @knitr DM21
setwd("/Users/stephdagata/Documents/GitHub/MQE-WORKSHOP-R-2018b/Scripts/Day 2/wiomsaDataManipulation/")
cSyn <-read.csv('./data/carbonateSynonomy.csv', skip=5, as.is=TRUE)
## @knitr end DM21

#	QUESTION: What does 'as.is' do, and why might we want to use it?
#	QUESTION: What does 'skip' do, and why might we want to use it?

##	TIP: always inspect your data AFTER importing to make sure you have imported it correctly...
#	QUESTION: What do each of these functions: head(), tail(), nrow(), dims(), summary() do?
## @knitr DM22
head(cMass)
## @knitr DM23
tail(cMeta)
## @knitr DM24
nrow(cMeta)
## @knitr DM25
summary(cMass)
## @knitr end DM25

## DIFFERENT WAYS REFERENCE COLUMNS, SHOULD ALL WORK
## @knitr DM26
cMass[,"mass"]
## @knitr DM27
cMass[["mass"]]
## @knitr DM28
cMass$mass
## @knitr end DM28

##### Exercise 2: Subsetting data ###############
#################################################

## 	QUESTION: How many taxon occurences have a mass > 25 (in data frame cMass)?
## @knitr DM29
cMass[(cMass$mass>25),]			# this lists, but does not count, the taxon occurences
## @knitr end DM29
# QUESTION: What does (cMass$mass>25) return?
## @knitr DM30
length(cMass$mass>25) 
## @knitr end DM30
# QUESTION: Why is this not the answer we want?

## @knitr DM31
length(which(cMass$mass>25))	
## @knitr end DM31

# QUESTION: Why is this the answer we want?
# QUESTION: What does which() return?
## @knitr DM32
which(cMass$mass>25)
## @knitr end DM32
## 	QUESTION: How much carbonate is from taxon occurences having a mass > 25 (in data frame cMass)?
## @knitr DM33
sum(which(cMass$mass>25)) 					# does not work as intended... what does which return?
## @knitr DM34
sum(cMass[which(cMass$mass>25),'mass'])		# this is the answer we want.
## @knitr end DM34

##	QUESTION: What is the average mass of Gastropoda in these samples?
## @knitr DM35
mean(cMass$mass[(cMass$taxon == 'Gastropoda')])		# is this what we want?
## @knitr end DM35

#	LET'S DOUBLE CHECK THAT ALL THE "Gastropoda" will match "Gastropoda
## @knitr DM36
unique(cMass$taxon)
## @knitr DM37
unique(sort(cMass$taxon))		# what do each of these functions do?
## @knitr end DM37

# A strict match is not what we want... We could manually list all the row numbers...
## @knitr DM38
cMass[c(9,21,32),] 					# but we would need to list all the rows with gastropod data
## @knitr DM39
mean(cMass[c(9,21,32),'mass'])		# will work but painfully and inflexible.
## @knitr end DM39

# A more robust solution (we will get to an even better solution later)
## @knitr DM40
?grep
## @knitr DM41
grep("Gastropod", cMass$taxon, ignore.case=TRUE)
## @knitr DM42
cMass[grep("Gastropod", cMass$taxon, ignore.case=TRUE),]
## @knitr end DM42

# Since we know taxon names are case insentitive...
## @knitr DM43
cMass$taxon <- tolower(cMass$taxon)
## @knitr DM44
mean(cMass$mass[grep("gastropod", cMass$taxon)])
## @knitr end DM44

# EXERCISE: what is the biggest bivalve mass?
# Hint: max(),grep()


##### Exercise 3: Aggregating data ##############
#################################################

# use aggregate() produce a table of the total idenfied mass from each sample
## @knitr DM45
?aggregate
## @knitr DM46
( sampleMass <- aggregate(cMass$mass,by=list(cMass$sample),FUN=sum) )
colnames(sampleMass) <- c('ID','massIdentified')
head(sampleMass)
## @knitr end DM46
# Now we have a summary table tellling us how much sample they were able to identify
# You can aggregate multiple data columns at one time (using the same function).


##### Exercise 4: Matching data #################
#################################################

# Since I know how much sample they had to start with - how much of sample did they identify?
## @knitr DM47
?merge
## @knitr DM48
( mergedSamples <- merge(cMeta,sampleMass) )		# What does the extra set of () do?
## @knitr end DM48
# now we have the original sample mass and the identified sample mass in the same dataframe.
## @knitr DM49
mergedSamples$proID <- mergedSamples$massIdentified / mergedSamples$mass
## @knitr end DM49
# now we have the proportion of each sample identified, did big samples have less identified?
## @knitr DM50
plot(mergedSamples$proID ~ mergedSamples$mass)	#no, but we have found a couple of lazy students!
## @knitr end DM50
# We can also use merge to clean up our names
# Let's clean up our names - are we missing any names from our synonomy list?
## @knitr DM51
cMass[!(cMass$taxon%in%cSyn$badName),]
## @knitr DM52
cMass[!((cMass$taxon%in%cSyn$badName)|(cMass$taxon%in%cSyn$taxonName)),]
## @knitr DM53
cMass2 <- merge(cMass,cSyn, by.x='taxon',by.y='badName')
head(cMass2)
## @knitr DM54
cMass2[(cMass2$taxon=='cirripedia'),]					# here lies the biggest danger of merge
## @knitr DM55
nrow(cMass)
## @knitr DM56
nrow(cMass2)											# we lost data
## @knitr DM57
cMass[cMass$sample =='E01',]							# compare sample 1 in the oringal data
## @knitr DM58
cMass2[cMass2$sample =='E01',]							# compare sample 1 in the merged data
## @knitr DM59
cMass2 <- merge(cMass,cSyn, by.x='taxon',by.y='badName', all.x=TRUE) 	# the fix
## @knitr DM60
nrow(cMass) == nrow(cMass2)
## @knitr DM61
cMass[cMass$sample =='E01',]							# compare sample 1 in the oringal data
## @knitr DM62
cMass2[cMass2$sample =='E01',]							# compare sample 1 in the merged data
## @knitr DM63
cMass2[is.na(cMass2$taxonName),]
## @knitr DM64
cMass2[is.na(cMass2$taxonName),'taxonName'] <- cMass2[is.na(cMass2$taxonName),'taxon']
## @knitr DM65
cMass2[cMass2$sample =='E01',]							# see sample 1 in the merged data
## @knitr end DM65
# now we have nice dataset that we can use, but we have a strict record of the changes we made to the orignal data.
# we could download the data again and be able to quickly repeat our analyses without a lot of painfil edits.

##### Exercise 5: Tabulating data ###############
#################################################

##	NEW DATA!
##	sames of larger benthic forams from Heron Island, Great Barrier Reef.
## @knitr DM66
setwd("/Users/stephdagata/Documents/GitHub/MQE-WORKSHOP-R-2018b/Scripts/Day 2/wiomsaDataManipulation/")
forams <- read.csv('./data/2017foramAnon.csv')
foramNames <- read.csv('./data/codesForams.csv')
## @knitr end DM66

# produce an incidence (presence/absence) matrix of species for all samples
## @knitr DM67
?table
## @knitr DM68
incidence_table <- table(forams$sample, forams$taxonCode)
incidence_table		# give us the number of rows for each foram at each site... (abundance)
## @knitr end DM68
# make it a presence/absence matrix 
## @knitr DM69
incidence_table[incidence_table>1] <- 1
## @knitr end DM69
# ifelse(incidence_table>0,yes=1,no=0) # an alternative way to do find and replace
## @knitr DM70
incidence_table
## @knitr end DM70
## imagine the data in a slightly different format.... ((review of aggregate))
##	use aggregate() to determine the abundance of foram taxa by sample and taxonCode. hint: length()
## @knitr DM71
foramAbundance <- aggregate(forams$taxonCode,by=list(forams$sample, forams$taxonCode),FUN=length)
colnames(foramAbundance) <- c('sample','taxonCode','abundance')
## @knitr end DM71

## use merge() to add the taxon names to the file
## @knitr DM72
foramAbundance <- merge(foramAbundance, foramNames, by.x='taxonCode', by.y='code')
## @knitr end DM72
## check the merged file to make sure it is what we want it to be
## @knitr DM73
head(foramAbundance)
## @knitr end DM73
# produce an abundance matrix of all foram species for all sites

# produce an abundance matrix of all foram species for all sites using foramAbundance
# hint: use tapply() & sum()
## @knitr DM74
?tapply
## @knitr DM75
abundance_table <- tapply(foramAbundance$abundance,list(foramAbundance$sample, foramAbundance$name),FUN="sum")
## @knitr end DM75
# check to make sure that it looks like it should...
## @knitr DM76
abundance_table[1:5,1:5]
## @knitr DM77
is.na(abundance_table[1:5,1:5])
## @knitr end DM77
# how do we change the NA to 0? NA can be a pain!
## @knitr DM78
abundance_table[is.na(abundance_table)] <- 0
## @knitr end DM78
# check to make sure that it looks like it should...
## @knitr DM79
abundance_table[1:5,1:5] # now an absence is what we want it to be (0) instead of NA.
## @knitr end DM79
##### Exercise 6: Custom tabulation #############
#################################################

# using an apply function on the abundance table

# first let's define an inverse simpson function
# sum of the proportional abundances squared
# https://en.wikipedia.org/wiki/Diversity_index#Inverse_Simpson_index

# convert the matrix to proportional abundances
## @knitr DM80
p <- abundance_table/sum(abundance_table) # this doesn't work
## @knitr DM81
sum(p) # this is why it doesn't work
## @knitr DM82
p <- abundance_table[1,]/sum(abundance_table[1,])
p
## @knitr DM83
sum(p)
## @knitr DM84
simp <- sum(p^2)
simp
## @knitr DM85
isimp <- 1/sum(p^2)
isimp
## @knitr end DM85

# lets wrap that as a function
# needs: x a list of abundances
# returns: inverse simpson index
## @knitr DM86
invsimp <- function(x) {
	p <- x/sum(x)
	invsimp <- 1/sum(p^2)
}
## @knitr end DM86
# double check that this works
## @knitr DM87
isimp2 <- invsimp(abundance_table[1,])
isimp2
## @knitr end DM87

# get site diversity for every site with just one line of code!
# use: apply() and invsimp()
## @knitr DM88
site_diversity <- apply(abundance_table,MARGIN=1,FUN=invsimp)
site_diversity
## @knitr end DM88

##### Exercise 6: Sorting data ##################
#################################################

# use sort() to sort the foramAbundance data by decreasing abundance
## @knitr DM89
?sort
## @knitr DM90
sort(foramAbundance$abundance, decreasing = TRUE) # simple option for vectors
## @knitr end DM90

# QUESTION: how is order() different than sort()
# this returns index numbers instead of values. 
# order() is useful if you need to sort a dataframe or matrix by the values in one column.
## @knitr DM91
order(foramAbundance$abundance, decreasing = TRUE) 
## @knitr end DM91
# EXERCISE: use order() to sort foramAbundance by decreasing abundance
## @knitr DM92
foramAbundance[order(foramAbundance$abundance, decreasing = TRUE),]
## @knitr end DM92

##### Exercise 7: Random sampling of data #######
#################################################
## @knitr DM93
?sample
## @knitr DM94
sample(1:100,size=5,replace=FALSE)
## @knitr end DM94
# EXERCISE: produce a 5x5 submatrix from the abundance table using random sampling
# hint: nrow() & ncol() can help
## @knitr DM95
submat <- abundance_table[sample(1:nrow(abundance_table),size=5),sample(1:ncol(abundance_table),size=5)]
submat # note that everyone will get a different matrix!
