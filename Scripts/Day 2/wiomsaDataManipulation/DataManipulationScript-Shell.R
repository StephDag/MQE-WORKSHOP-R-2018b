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
## @knitr end DM1

# define a matrix (assign to y) with 9 rows and 3 columns using the data in x
## @knitr DM2
y <- matrix()
## @knitr end DM2

# extract a vector from y using the numerical indices in x



# define a 3-dimensional array (assign to z) with 3 rows, 3 columns and 3 layers, using the data in x
## @knitr DM3
z <- array(,dim=c())
## @knitr end DM3

# extract a reversed vector from z using x
 
# QUESTION: What does the function rev() do? 
# QUESTION: How can you find out?

# browse the datasets available in R, find Edgar Anderson's Iris data and load it as a dataframe 
# 50 replicate measurements for each of 3 species of Iris
## @knitr DM4
data()
data(iris)
## @knitr end DM4

# QUESTION: what does head() do?
## @knitr DM5
head(iris)

# QUESTION: what does dim() do?
## @knitr DM6
dim(iris)

# QUESTION: what does mode() do?
## @knitr DM7
mode(iris)

# use as.matrix() to convert the iris dataset to a matrix and use head() & mode() to check the data
## @knitr DM8
iris2 <- as.matrix()
## @knitr end DM8
		# Question: why quotes?
		# Question: character?
		
# QUESTION: what happens when you try to take the mean of iris2[,'Sepal.Length']


# use as.matrix() to convert only the numeric columns of iris dataset. Check the data.
## @knitr DM9
iris3 <-
  ## @knitr end DM9
# QUESTION: what is the mean sepal length?

# QUESTION: how might we work around this issue, hint: as.numeric()?


## using matrices instead of data frames 

# when data is all numbers (except for row and column names), I normally use matrices rather than dataframes
# if you have row names in your data file, and you want to convert to a matrix, you will need to specify which column has the row names (see the row.names argument in the read.table function)

##### Exercise 1: Reading data ##################
#################################################

##	 Use the read.table (and related functions) to read in datafiles: "carbonateMetaData.txt", "carbonateMassData.csv", "carbonateSynonomy.csv"

## ABOUT THESE DATA: These are sediment samples from Heron Reef. Students were instructed to sort the sediment into the organisms that created it, and to report the weight of each taxonomic group in grams. "carbonateMassData.csv" contains the mass by taxonomic group data. "carbonateMetaData.txt" contains metadata - information aboit the sample provided to the students. "carbonateSynonomy.csv" is a list of spelling corrections and synonomies that I use to harmonise the data without changing the original data.

##	TIP: always inspect your data BEFORE attempting to import into R 

# use read.table() to read carbonateMetaData.txt. read.table() is the generic function

## @knitr SET

## @knitr DM10
setwd("/Users/stephdagata/Documents/GitHub/MQE-WORKSHOP-R-2018b/Scripts/Day 2/wiomsaDataManipulation/")
cMeta <- read.table("./data/carbonateMetaData.txt", header=TRUE, sep="\t", as.is=TRUE)
## @knitr end DM10

# read.delim() is read.table(), but will default values set for tab-delimited files
# use it to read ./data/carbonateMetaData.txt
## @knitr DM11
cMeta <- read.delim()
## @knitr end DM11

# read.table() is the generic function and can read csv files...
## @knitr DM12
setwd("/Users/stephdagata/Documents/GitHub/MQE-WORKSHOP-R-2018b/Scripts/Day 2/wiomsaDataManipulation/")
cMass <- read.table('./data/carbonateMassData.csv', header = TRUE, sep = ",", quote = "\"", fill = TRUE, comment.char = "", as.is=TRUE)
## @knitr end DM12
# OR: read.csv() is read.table(), but will default values set for csv files
# use it to read: ./data/carbonateSynonomy.csv
## @knitr DM13
cSyn <-read.csv()
## @knitr end DM13

## @knitr DM13a
setwd("/Users/stephdagata/Documents/GitHub/MQE-WORKSHOP-R-2018b/Scripts/Day 2/wiomsaDataManipulation/")
cSyn <-read.csv("./data/carbonateSynonomy.csv", header = TRUE, sep = ",", quote = "\"", fill = TRUE, comment.char = "", as.is=TRUE)
## @knitr end DM13a

#	QUESTION: What does 'as.is' do, and why might we want to use it?
#	QUESTION: What does 'skip' do, and why might we want to use it?

##	TIP: always inspect your data AFTER importing to make sure you have imported it correctly...
#	QUESTION: What do each of these functions: head(), tail(), nrow(), dims(), summary() do?






## DIFFERENT WAYS REFERENCE COLUMNS, SHOULD ALL WORK
## @knitr DM14
cMass[,"mass"]
## @knitr DM15
cMass[["mass"]]
## @knitr DM16
cMass$mass
## @knitr end DM16

##### Exercise 2: Subsetting data ###############
#################################################

## 	QUESTION: How many taxon occurences have a mass > 25 (in data frame cMass)?
## @knitr DM17
cMass[(cMass$mass>25),]			# this lists, but does not count, the taxon occurences
## @knitr end DM17

# QUESTION: What does (cMass$mass>25) return?
## @knitr DM18
length(cMass$mass>25)
## @knitr end DM18

# QUESTION: Why is this not the answer we want?
## @knitr DM19
length(which(cMass$mass>25))	
## @knitr end DM19

# QUESTION: Why is this the answer we want?
# QUESTION: What does which() return?
## @knitr DM20
which(cMass$mass>25)
## @knitr end DM20

## 	QUESTION: How much carbonate is from taxon occurences having a mass > 25 (in data frame cMass)?
## @knitr DM21
sum(which(cMass$mass>25)) 					# does not work as intended... what does which return?
## @knitr DM22
sum(cMass[which(cMass$mass>25),'mass'])		# this is the answer we want.
## @knitr end DM22

##	QUESTION: What is the average mass of Gastropoda in these samples?
## @knitr DM23
mean(cMass$mass[(cMass$taxon == 'Gastropoda')])		# is this what we want?
## @knitr end DM23

#	LET'S DOUBLE CHECK THAT ALL THE "Gastropoda" will match "Gastropoda
## @knitr DM24
unique(cMass$taxon)
## @knitr DM25
unique(sort(cMass$taxon))		# what do each of these functions do?
## @knitr end DM25

# A strict match is not what we want... We could manually list all the row numbers...
## @knitr DM26
cMass[c(9,21,32),] 					# but we would need to list all the rows with gastropod data
## @knitr DM27
mean(cMass[c(9,21,32),'mass'])		# will work but painfully and inflexible.
## @knitr end DM27
# A more robust solution (we will get to an even better solution later)
## @knitr DM28
?grep
## @knitr DM29
grep("Gastropod", cMass$taxon, ignore.case=TRUE)
## @knitr DM30
cMass[grep("Gastropod", cMass$taxon, ignore.case=TRUE),]
## @knitr end DM30
# Since we know taxon names are case insentitive...
## @knitr DM31
cMass$taxon <- tolower(cMass$taxon)

## @knitr DM32
mean(cMass$mass[grep("gastropod", cMass$taxon)])
## @knitr end DM32

# EXERCISE: what is the biggest bivalve mass?
# Hint: max(),grep()


##### Exercise 3: Aggregating data ##############
#################################################

# use aggregate() produce a table of the total idenfied mass from each sample
## @knitr DM33
?aggregate
## @knitr DM34
( sampleMass <- aggregate(cMass$mass,by=list(cMass$sample),FUN=sum) )
colnames(sampleMass) <- c('ID','massIdentified')
head(sampleMass)
## @knitr end DM34

# Now we have a summary table tellling us how much sample they were able to identify
# You can aggregate multiple data columns at one time (using the same function).


##### Exercise 4: Matching data #################
#################################################

# Since I know how much sample they had to start with - how much of sample did they identify?
## @knitr DM35
?merge
## @knitr DM36
( mergedSamples <- merge(cMeta,sampleMass) )		# What does the extra set of () do?
# now we have the original sample mass and the identified sample mass in the same dataframe.
## @knitr DM37
mergedSamples$proID <- mergedSamples$massIdentified / mergedSamples$mass
## @knitr end DM37

# now we have the proportion of each sample identified, did big samples have less identified?
## @knitr DM38
plot(mergedSamples$proID ~ mergedSamples$mass)	#no, but we have found a couple of lazy students!
## @knitr end DM38

# We can also use merge to clean up our names
# Let's clean up our names - are we missing any names from our synonomy list?
## @knitr DM39
cMass[!(cMass$taxon%in%cSyn$badName),]
## @knitr DM40
cMass[!((cMass$taxon%in%cSyn$badName)|(cMass$taxon%in%cSyn$taxonName)),]
## @knitr DM41
cMass2 <- merge(cMass,cSyn, by.x='taxon',by.y='badName')
## @knitr DM42
head(cMass2)
## @knitr DM43
cMass2[(cMass2$taxon=='cirripedia'),]					# here lies the biggest danger of merge
## @knitr DM44
nrow(cMass)
## @knitr DM45
nrow(cMass2)											# we lost data
## @knitr DM46
cMass[cMass$sample =='E01',]							# compare sample 1 in the oringal data
## @knitr DM47
cMass2[cMass2$sample =='E01',]							# compare sample 1 in the merged data
## @knitr DM48
cMass2 <- merge(cMass,cSyn, by.x='taxon',by.y='badName', all.x=TRUE) 	# the fix
## @knitr DM49
nrow(cMass) == nrow(cMass2)
## @knitr DM50
cMass[cMass$sample =='E01',]							# compare sample 1 in the oringal data
## @knitr DM51
cMass2[cMass2$sample =='E01',]							# compare sample 1 in the merged data
## @knitr DM52
cMass2[is.na(cMass2$taxonName),]
## @knitr DM53
cMass2[is.na(cMass2$taxonName),'taxonName'] <- cMass2[is.na(cMass2$taxonName),'taxon']
## @knitr DM54
cMass2[cMass2$sample =='E01',]							# see sample 1 in the merged data
## @knitr end DM54

# now we have nice dataset that we can use, but we have a strict record of the changes we made to the orignal data.
# we could download the data again and be able to quickly repeat our analyses without a lot of painfil edits.

##### Exercise 5: Tabulating data ###############
#################################################

##	NEW DATA!
##	sames of larger benthic forams from Heron Island, Great Barrier Reef.
## @knitr DM55
forams <- read.csv('./data/2017foramAnon.csv')
foramNames <- read.csv('./data/codesForams.csv')
## @knitr end DM55

# produce an incidence (presence/absence) matrix of species for all samples
## @knitr DM56
?table
## @knitr DM57
incidence_table <- 
incidence_table		# give us the number of rows for each foram at each site... (abundance)
## @knitr end DM57

# make it a presence/absence matrix 
## @knitr DM58
incidence_table <- 
incidence_table
## @knitr end DM58

## imagine the data in a slightly different format.... ((review of aggregate))
##	use aggregate() to determine the abundance of foram taxa by sample and taxonCode. hint: length()
## @knitr DM59
foramAbundance <- aggregate()
colnames(foramAbundance) <- c('sample','taxonCode','abundance')
## @knitr end DM59

## use merge() to add the taxon names to the file
## @knitr DM60
foramAbundance <- merge(foramAbundance,)
## @knitr end DM60

## check the merged file to make sure it is what we want it to be

# produce an abundance matrix of all foram species for all sites using foramAbundance
# hint: use tapply() & sum()
## @knitr DM61
?tapply
## @knitr DM62
abundance_table <- tapply()
## @knitr end DM62

# check to make sure that it looks like it should...

# how do we change the NA to 0? NA can be a pain!

# check to make sure that it looks like it should...


##### Exercise 6: Custom tabulation #############
#################################################

# using an apply function on the abundance table

# first let's define an inverse simpson function
# sum of the proportional abundances squared
# https://en.wikipedia.org/wiki/Diversity_index#Inverse_Simpson_index

# convert the matrix to proportional abundances
## @knitr DM63
p <- abundance_table/sum(abundance_table) # this doesn't work
## @knitr DM64
sum(p) # this is why it doesn't work
## @knitr DM65
p <- abundance_table[1,]/sum(abundance_table[1,])
p
## @knitr DM66
sum(p)
## @knitr DM67
simp <- sum(p^2)
simp
## @knitr DM68
isimp <- 1/sum(p^2)
isimp
## @knitr end DM68

# lets wrap that as a function
# needs: x a list of abundances
# returns: inverse simpson index
## @knitr DM69
invsimp <- function(x) {
	p <- x/sum(x)
	invsimp <- 1/sum(p^2)
}
## @knitr end DM69

# double check that this works
## @knitr DM70
isimp2 <- invsimp(abundance_table[1,])
isimp2
## @knitr end DM70

# get site diversity for every site with just one line of code!
# use: apply() and invsimp()
## @knitr DM71
site_diversity <- apply(abundance_table,)
site_diversity
## @knitr end DM71

##### Exercise 6: Sorting data ##################
#################################################

# use sort() to sort the foramAbundance data by decreasing abundance
## @knitr DM72
?sort
## @knitr DM73
sort() # simple option for vectors
## @knitr end DM73

# QUESTION: how is order() different than sort()
# order() is useful if you need to sort a dataframe or matrix by the values in one column.

# EXERCISE: use order() to sort foramAbundance by decreasing abundance 



##### Exercise 7: Random sampling of data #######
#################################################
## @knitr DM74
?sample
## @knitr DM75
sample(1:100,size=5,replace=FALSE)
## @knitr end DM75

# EXERCISE: produce a 5x5 submatrix from the abundance table using random sampling
# hint: nrow() & ncol() can help
## @knitr DM76
submat <-
submat # NOTE: that everyone will get a different matrix!
## @knitr end DM76
