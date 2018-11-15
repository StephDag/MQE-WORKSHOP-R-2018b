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
#	This file contains R code for "Data manipulation in R" session
#		created by David Nipperess
#		modified by Matthew Kosnik
#		last modified 2018.11.12
#
################################################################################

##	Preliminary: Set up workspace
################################################################################

#	Set up a new project in R Studio
#	Where is your working directory?
#	Are the files you need in your working directory?
#	- Data needs to be in a subdirectory "./data"

##	REVIEW: Data objects in R
################################################################################
# This should all be review from YESTERDAY, but it is good to review. It is important.

# EXERCISE: define a vector of the numerical values 1 to 27 and assign to an object called i
( i <- 1:27 )
# QUESTION: What do the "( )" do in this context?

# EXERCISE: define a vector of length 27, with values a-z and assign to an object called x
# HINT: use the constant "letters"
# QUESTION: Is there anything unexpected about the content of this vector?
( x <- letters[i] )

# EXERCISE: define a matrix (assign to y) with 3 rows and 9 columns using the data in x
( y <- matrix() )

# EXERCISE: extract a vector from y using the numerical indices in i


# EXERCISE: define a 3-dimensional array (assign to z) with 3 rows, 6 columns and 2 layers, using the data in x
z <- array(,dim=c())

# EXERCISE: select a row, a column and a layer from z




# EXERCISE: select from z using another variable (e.g., i)
# QUESTION: what does selecting using "-i" do, why?



# EXERCISE: extract a reversed vector from z using x, hint: use the function "rev()"


# QUESTION: What does the function rev() do? 
# QUESTION: How can you find out?

# names you CANNOT use for variables
?Reserved
# QUESTION: what characters cannot be used in variable names (hint: follow link to make.names())? 

# EXERCISE: browse the datasets available in R 
################################################################################
data()

# EXERCISE: load Edgar Anderson's Iris data 
data(iris)

# EXERCISE: explore the top few / bottom few rows Edgar Anderson's Iris data 
# QUESTION: what do the functions head() and tail() do?
# QUESTION: how can I get head() and tail() to display an arbritary number of rows?
head(iris)
tail(iris)

# QUESTION: what does the function summary() return?
summary(iris)

# QUESTION: what does the function dim() return?


# QUESTION: what does class() return?


# QUESTION: what does mode() return?
mode(iris)
mode(iris[1,])
mode(iris[,1])

# QUESTION: what does attributes() return?
attributes(iris)
attributes(iris[1,])
attributes(iris[,1])

# QUESTION: what does str() return?
str()

# NOTE: there is a fair bit of overlap in these functions.
# 	other related functions include typeof()

# EXERCISE: referencing columns...
iris[,1]
iris[,'Sepal.Length']
iris$Sepal.Length

# EXERCISE: use as.matrix() to convert the iris dataset to a matrix
iris2 <- as.matrix()

# EXERCISE: use head() or tail() to check the data
# QUESTION: why do the values have quotes?


# EXERCISE: use mode() to check the data
# QUESTION: why are they character?


# QUESTION: what happens when you try to take the mean() of iris2[,'Sepal.Length']


# QUESTION: how might we work around this issue, hint: as.numeric()?


# EXERCISE: use as.matrix() to convert only the numeric columns of iris dataset.
iris3 <-

# EXERCISE: Check the data



# QUESTION: what is the mean sepal length?


# EXERCISE: referencing columns...
iris3[,1]
iris3[,'Sepal.Length']
iris3$Sepal.Length

# HINT: it is better to write clearer / readable / flexible code
#	[ will you remember what values are in column 1 in an hour? ]
#	[ will your code still work if your dataset gets a new column or if the columns are reordered? ]

# SUGGESION:  matrices vs. data frames 
# in general dataframes are a bit more flexible
# when data is all numbers (except for row and column names), You can use matrices rather than dataframes
# if you have row names in your data file, you can specify which column has the row names (see the row.names argument in the read.table function)

##	TOPIC 1: Loading your own data
################################################################################
# Use read.table() (and related functions) to read in the datafiles: 
#		"carbonateMetaData.txt" 
#		"carbonateMassData.csv"
#		"carbonateSynonomy.csv"

# ABOUT THESE DATA: These are sediment samples from Heron Reef. Students were instructed to sort the sediment into the organisms that created it, and to report the weight (in grams) of each taxonomic group. "carbonateMassData.csv" contains the mass by taxonomic group data. "carbonateMetaData.txt" contains metadata - information aboit the sample provided to the students. "carbonateSynonomy.csv" is a list of spelling corrections and synonomies that I use to harmonise the data without changing the original data.

# TIP: always inspect your data BEFORE attempting to import into R 

# NOTE: column names must be valid varible names (or will be converted to valid variable names)!
# QUESTION: what happens to characters that cannot used in a valid variable name?
? make.names()

# read.table() is the generic function
# EXERCISE: use read.table() to read "./data/carbonateMetaData.txt". Check the data.
cMeta <- read.table("./data/carbonateMetaData.txt")

# QUESTION: what happened to our header row / column names?
# EXERCISE: try again and fix the header row / column names
# TIP: the up arrow key can reduce the amount of typing you need to do
cMeta <- read.table()

# read.delim() is read.table(), but with defaults set for tab-delimited files
# saves having to specify sep and header.
# EXERCISE: use read.delim() to read ./data/carbonateMetaData.txt
cMeta <- read.delim("./data/carbonateMetaData.txt")

# read.table() is the generic function and it can read csv files...
cMass <- read.table('./data/carbonateMassData.csv', header = TRUE, sep = ",", quote = "\"", fill = TRUE, comment.char = "", as.is=TRUE)

# read.csv() is read.table(), but will default values set for csv files
# saves having to specify header, sep, quote...
# EXERCISE: use read.csv() to read: ./data/carbonateSynonomy.csv
cSyn <-read.csv()

# QUESTION: Why did that fail and how can we 'skip' 5 lines of a datafile?
?read.csv()
cSyn <-read.csv()

# QUESTION: How did R treat the data, how can we get it to treat the strings 'as.is' and not as factors?
# TIP: factors can be a real pain, I suggest not using factors unless you need to.
cSyn <-read.csv()

# TIP: always inspect your data AFTER importing to make sure you have imported it correctly...
# QUESTION: What do each of these functions: head(), tail(), nrow(), dims(), summary(), mode(), class(), typeof(), attributes(), str() do?









##	EXERCISE: load & verify that you have 3 nice files with headers 




## DIFFERENT WAYS REFERENCE COLUMNS, SHOULD ALL WORK
cMass[,"mass"] 
cMass[["mass"]] 
cMass$mass


##	TOPIC 2: Subsetting data
################################################################################
# You can subset data using either logical values (true/false), or:
# specify index (row or column numbers / names)

# EXERCISE: Which taxon occurences have a mass > 25 (in dataframe cMass)?
(cMass$mass>25)

# EXERCISE: select the rows (in cMass) where the mass is more than 25
cMass[,]

# QUESTION: How many taxon occurences have a mass > 50 (in dataframe cMass)?
length(cMass$mass>50)

# QUESTION: Why is this not the answer we want? hint: two ways to specify columns

# QUESTION: What does which() return?
? which()
which(cMass$mass>50)

length(which(cMass$mass>50))	
# QUESTION: Why is this the answer we want?

# QUESTION: How much carbonate is from taxon occurences having a mass > 25 (in dataframe cMass)?
sum(which(cMass$mass>25))
# does not work as intended... what does which() return?

# EXERCISE: Use sum() and which() to get the answer
sum(cMass[which(cMass$mass>25),'mass'])

# EXERCISE: What is the average mass of Gastropoda in these samples?
mean(cMass$mass[(cMass$taxon == 'Gastropoda')])

# QUESTION: is this what we want?

# let's double check that all the "Gastropoda" will match "Gastropoda
# EXERCISE: use unique() to see the unique values of cMass$taxon
unique()

# EXERCISE: use unique() and sort() to get a more readable list of the unique values of cMass$taxon
unique(sort(cMass$taxon))

# a strict match is not what we want... We could manually list all the row numbers...
cMass[c(9,21,32),] 					# but we would need to list all the rows with gastropod data
mean(cMass[c(9,21,32),'mass'])		# will work but painfully and inflexible.

# a more robust solution (we will get to an even better solution later)
?grep
grep("Gastropod", cMass$taxon, ignore.case=TRUE)
cMass[grep("Gastropod", cMass$taxon, ignore.case=TRUE),]

# since we know taxon names are case insentitive...
cMass$taxon <- tolower(cMass$taxon)

mean(cMass$mass[grep("gastropod", cMass$taxon)])

# EXERCISE: what is the biggest bivalve mass?
# Hint: max(),grep()


##	TOPIC 3: Aggregating data
################################################################################
# R can easily compute summary statistics for subsets 
?aggregate

# EXERCISE: use aggregate() produce a table of the total idenfied mass from each sample
sampleMass <- aggregate(cMass$mass,by=list(cMass$sample),FUN=sum)
head(sampleMass, 3)

# add better column names
colnames(sampleMass) <- c('ID','massIdentified')
head(sampleMass)

# Now we have a summary table tellling us how much sample they were able to identify
# You can aggregate multiple data columns at one time (using the same function).


##	TOPIC 4: Merging data
################################################################################
# R can do merge dataframes like a relational database join...
?merge

# Since I know how much sample they had to start with - how much of sample did they identify?

# make a new dataframe with the original sample mass and the identified sample mass.
# NOTE: we do not have to specify the columns to match because they have the same name.
( mergedSamples <- merge(cMeta,sampleMass) )

# EXERCISE: calculate the proportion of each sample identified and store it in column "proID"
mergedSamples$proID <- 

# QUESTION: do bigger samples have a less of the sample identified? 
plot(mergedSamples$proID ~ mergedSamples$mass)

# We can also use merge to clean up our taxon names
# QUESTION: are we missing any names from our synonomy list?
cMass[!(cMass$taxon%in%cSyn$badName),]
cMass[!((cMass$taxon%in%cSyn$badName)|(cMass$taxon%in%cSyn$taxonName)),]

# make a new dataframe "cMass2" with the good name
# NOTE: must specify columns to match because the column names are not the same.
cMass2 <- merge(cMass,cSyn, by.x='taxon',by.y='badName')
head(cMass2, 2)

# NOTE/IMPORTANT: always check your data after a merge to make sure it worked as intended.
nrow(cMass) == nrow(cMass2)
cMass2[(cMass2$taxon=='cirripedia'),]					# here lies the biggest danger of merge

# EXERCISE: compare sample 'E01' from the two dataframes
cMass[,]
cMass2[,]
# QUESTION: are they the same?

# make a new dataframe "cMass2" with the good name - "left join"
cMass2 <- merge(cMass,cSyn, by.x='taxon',by.y='badName', all.x=TRUE)
nrow(cMass) == nrow(cMass2)

# EXERCISE: compare sample 'E01' from the two dataframes
cMass[cMass$sample =='E01',]
cMass2[cMass2$sample =='E01',]
# QUESTION: are they the same?

# a quick way to make sure that the good names are also in cMass2$taxonName
cMass2[is.na(cMass2$taxonName),]
cMass2[is.na(cMass2$taxonName),'taxonName'] <- cMass2[is.na(cMass2$taxonName),'taxon']

cMass2[cMass2$sample =='E01',]							# see sample 1 in the merged data

# NOTE: now we have 'clean' dataset that we can use and we have a record of the modifications.
# We could download the data again and be able to quickly repeat our analyses without a lot of painfil edits.


##	TOPIC 5: Tabulating data
################################################################################

##	NEW DATA!
##	larger benthic forams from Heron Island, Great Barrier Reef.
forams <- read.csv('./data/2017foramAnon.csv')
foramNames <- read.csv('./data/codesForams.csv')

# EXERCISE: make an contingency table (matrix species by sites)
?table
foramTable <- 

# QUESTION: what are the rows, columns, and cell values?
foramTable

# EXERCISE: make it a presence/absence matrix 
foramTable <-
# NOTE: ifelse() will also do this


# imagine the data in a slightly different format.... ((review of aggregate))
# EXERCISE: use aggregate() to determine the abundance of foram taxa by sample and taxonCode. hint: length()
foramAbundance <- aggregate(,by=list(),FUN=length)
colnames(foramAbundance) <- c('sample','taxonCode','abundance')

# EXERCISE: use merge() to add the taxon names to the file
foramAbundance <- merge(foramAbundance,)

# EXERCISE: check the merged file to make sure it is what we want it to be



# EXERCISE: produce an abundance matrix of all foram species for all sites using foramAbundance
# HINT: use tapply() & sum()
?tapply
abundance_table <- tapply()

# EXERCISE: check to make sure that it looks like it should...
# TIP: try only looking at the first 5 rows and first 5 columns



# QUESTION: how do we change the NA to 0? NA can be a pain!


# EXERCISE: check to make sure that it looks like it should...



##	TOPIC 6: Sorting data
################################################################################
?sort

# EXERCISE: use sort() to show foram abundance from most to least abundant
sort(foramAbundance$abundance, decreasing = TRUE)

# order() returns index numbers instead of values. 
# order() is useful if you need to sort a dataframe or matrix by the values in one column.
order(foramAbundance$abundance, decreasing = TRUE) 

# EXERCISE: use order() to sort foramAbundance from most to least abundant 
foramAbundance[order(foramAbundance$abundance, decreasing = TRUE),]


##	TOPIC 7: Random sampling of data
################################################################################

?sample
sample(1:100,size=5,replace=FALSE)

# EXERCISE: produce a 5x5 submatrix from the abundance table using random sampling
# HINT: nrow() & ncol() can help
# NOTE: that everyone will get a different matrix!
submat <-
submat 
