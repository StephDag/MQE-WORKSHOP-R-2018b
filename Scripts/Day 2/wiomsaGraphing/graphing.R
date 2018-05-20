## ORIGINALLY BASED ON WORK BY: JOSHUA MADIN
## http://acropora.bio.mq.edu.au/resources/introduction-to-r/graphing/
##
##	MODIFIED BY M. KOSNIK IN 2017.OCT

##	WE NEED SOME DATA TO PLAY WITH
#######################################
#	Individual bivalves collected from soft sediment at One Tree Reef with measurements.
#	This is a similified version of the data related to this research:
#
#	Julieta C. Martinelli, Matthew A. Kosnik, And Joshua S. Madin 
#	Passive Defensive Traits Are Not Good Predictors Of Predation For Infaunal Reef Bivalves 
#	PALAIOS, 2016, v. 31, 607–615 . http://dx.doi.org/10.2110/palo.2016.018  
#
#	Matthew A. Kosnik, Quan Hua, Darrell S. Kaufman, Atun Zawadzki 
#	Sediment accumulation, stratigraphic order, and the extent of time-averaging in lagoonal sediments: 
#	a comparison of 210Pb and 14C/amino acid racemization chronologies
#	Coral Reefs (2015) 34:215–229. http://dx.doi.org/10.1007/s00338-014-1234-2 

##	READ A TAB DELIMITED FILE './data/oti_measurements.txt'
## @knitr GR1
setwd("/Users/stephdagata/Documents/GitHub/MQE-WORKSHOP-R-2018b/Scripts/Day 2/wiomsaGraphing/")
otiShells <- read.delim('./data/oti_measurements.txt')
## @knitr end GR1

##	WHAT HAVE WE GOT HERE?
## @knitr GR2
head(otiShells)
summary(otiShells)		# ANYTHING FISHY?
## @knitr end GR2

# RE-IMPORT & CLEAN UP AS NEEDED
## @knitr GR3
setwd("/Users/stephdagata/Documents/GitHub/MQE-WORKSHOP-R-2018b/Scripts/Day 2/wiomsaGraphing/")
otiShells <- read.delim('./data/oti_measurements.txt', na.strings='\\N')
## @knitr GR4
otiShells <- otiShells[(otiShells$mass_mg > 0),]
otiShells <- otiShells[(otiShells$x_mm > 0),]
## @knitr end GR4

## REVIEW: DIFFERENT WAYS REFERENCE COLUMNS, SHOULD ALL WORK
## @knitr GR5
otiShells[1:10,"x_mm"] 
## @knitr GR6
otiShells[["x_mm"]][1:10]
## @knitr GR7
otiShells$x_mm[1:10]
## @knitr end GR7

## IF YOU ARE GOING TO USE IT A BUNCH - MAKE A NEW COLUMN FOR THE TRANSFORMED VARIABLE
## @knitr GR8
otiShells$crMass <- otiShells$mass_mg^(1/3)
## @knitr end GR8

#######################################
## HISTOGRAMS
#######################################
## @knitr GR9
? hist()
## @knitr end GR9

#################
## PLOT HISTOGRAM OF SHELL SIZE
## @knitr GR10
hist(otiShells$x_mm)
## @knitr end GR10

## LETS ADD BETTER AXIS LABELS
## @knitr GR11
hist(otiShells$x_mm, xlab='Shell size (mm)')
## @knitr end GR11

## LETS COLOUR OUR COLUMNS & ADD MAIN TITLE
## @knitr GR12
hist(otiShells$x_mm, xlab='Shell size (mm)', col='seagreen', main="Figure 1")
## @knitr end GR12

## ANOTHER WAY TO SPECIFY COLOURS
## @knitr GR13
hist(log(otiShells$mass_mg), xlab="log(Shell mass) (mg)", col=rgb(0,0.1,0.5), main="Figure 1")
## @knitr end GR13
# QUESTION: which log is this?

## WHAT ELSE CAN "hist()" DO?
## @knitr GR14
aHist <- hist(log2(otiShells[grep('Abranda',otiShells$taxonName),'mass_mg']), plot=FALSE)
## @knitr end GR14
# QUESTION: tell me about object aHist
## @knitr GR15
aHist
## @knitr end GR15

## MAKE A HISTOGRAM FOR LOG ABRANDA SHELL MASS... WITH NO AXES OR LABELS
## @knitr GR16
plot(aHist, col='seagreen', ann=FALSE, axes=FALSE)
## @knitr end GR16

## ADD Y axis() MANUALLY (ALLOWS FOR GREATER CONTROL)
## @knitr GR17a
? axis()
## @knitr GR17b
axis(side= 2)	# identical to what would have been drawn from hist()
## @knitr end GR17b

## SPECIFY A COMPLEX AXIS
## @knitr GR18
where <- seq(floor(min(aHist$breaks)),ceiling(max(aHist$breaks)),by=2)
what <- 2^where
axis(1, at=where, labels=what, lwd=2, lty=3, col='blue', font=3)	# specify details of line 
## @knitr end GR18

## ANOTHER WAY TO ADD MARGIN TEXT (AKA - LABEL)
## @knitr GR19
? mtext()
## @knitr GR20
mtext("Abranda", side=3, line=-2, font=4, adj=0.1, cex=2)	# big, italic font right side
## @knitr end GR20

# USE mtext() to add title to x-axis
## @knitr GR21
mtext("Shell mass (mg)", side=1, line=2)
## @knitr end GR21

## WHAT OTHER OPTIONS DOES HISTOGRAM HAVE?
## @knitr GR22
? hist()
## @knitr end GR22
## SET "breaks"
## @knitr GR23
aHist <- hist(otiShells[grep('Abranda',otiShells$taxonName),'x_mm'], plot=FALSE, breaks=0:28)
aHist
plot(aHist, col='seagreen', ann=FALSE, axes=TRUE, las=1)
## @knitr end GR23

## use mtext() to add labels & text...
## @knitr GR24
mtext("Abranda", side=3, line=-2, font=4, adj=0.1, cex=2)	# big, italic font right side
mtext("Shell length (mm)", side=1, line=2)
mtext("Frequency", side=2, line=2.5)
## @knitr end GR24

#######################################
## BIVARIATE PLOTS
#######################################
## @knitr GR25
? plot()
## @knitr end GR25

## subset the data to get only Pinguitellina
## @knitr GR26
pingData <- otiShells[grep('Pingui',otiShells$taxonName),]
## @knitr end GR26

## SPECIFY THE COLUMN WITH THE X DATA AND THE COLUMN WITH THE Y DATA
# plot() x_mm on the x-axis vs mass_mg on the y-axis
## @knitr GR27
plot(pingData$x_mm, pingData$mass_mg)
## @knitr end GR27

## ALTERNATIVELY, USE FORMULA NOTATION (SAME PLOT, BUT BETTER DEFAULT AXIS LABELS)
## @knitr GR28
plot(mass_mg ~ x_mm, pingData)
## @knitr end GR28

## PLOT IT WITH A CUBE ROOT TRANSFORM ON THE Y AXIS?
## @knitr GR29
plot((mass_mg)^(1/3) ~ x_mm, pingData) 
## @knitr end GR29

## LETS MAKE NICER AXIS LABELS USING xlab, ylab & col
## @knitr GR30
plot((mass_mg)^(1/3) ~ x_mm, pingData, xlab="Max length (mm)", ylab="cuberoot of mass (mg)", col='darkblue')
## @knitr end GR30
## LETS MAKE IT PLOT LINES INSTEAD (what other options are there?)
## @knitr GR31
plot((mass_mg)^(1/3) ~ x_mm, pingData, xlab="Max length, mm", ylab="cuberoot of mass (mg)", col='darkblue', type='l')
## @knitr end GR31

## LETS MAKE IT PLOT THE AXES, BUT NOT ANY POINTS!
## @knitr GR32
plot(crMass ~ x_mm, otiShells, xlab="Max length (mm)", ylab="cuberoot of mass (mg)", col='darkblue', type='n')
## @knitr end GR32
## ?? WHY WOULD WE WANT TO DO THAT??
## @knitr GR33
? points()
## @knitr end GR33

## LETS PLOT THE "Pinguitellina" as red circles
## @knitr GR34
points(crMass ~ x_mm, data= otiShells[grep('Pingui',otiShells$taxonName),], col="red", pch=21) 
## @knitr end GR34
## LETS PLOT THE "Abranda" as green squares
## @knitr GR35
points(crMass ~ x_mm, data= otiShells[grep('Abranda',otiShells$taxonName),], col="green", pch=21) 
## @knitr end GR35

## WHAT ELSE CAN WE SPECIFY FOR POINTS?

## PLOT IS SUPER GENERAL (IT WILL TRY TO PLOT ANYTHING). FACTORS DEFAULT TO BOXPLOTS...
## @knitr GR36
plot(crMass ~ siteName, otiShells)
## @knitr end GR36

#######################################
## BOX PLOTS
#######################################
## @knitr GR37
? boxplot()
## @knitr GR38
boxplot(pingData$x_mm, col='lightblue')
## @knitr end GR38
## SPLIT IT BY "siteName"?
## @knitr GR39
boxplot(x_mm ~ siteName, pingData, col='skyblue') 
## @knitr end GR39
## BETTER AXIS LABELS
## @knitr GR40
boxplot(x_mm ~ siteName, pingData, xlab="One Tree Reef Lagoon", ylab="Max shell length, mm") 
## @knitr end GR40
## ADD "notch"ES?
## @knitr GR41
boxplot(x_mm ~ siteName, pingData, xlab="One Tree Reef Lagoon", ylab="Max shell length, mm", notch = TRUE)
## @knitr end GR41
## ?? WHAT ARE THE "notch"es??

## OVERLAY THE POINTS? ( IT WORKS - IF WE MAKE Root.herbivore A FACTOR )
## @knitr GR42
boxplot(x_mm ~ siteName, pingData, xlab="One Tree Reef Lagoon", ylab="Max shell length, mm", notch = TRUE, col='lightgrey')
points(pingData$siteName, pingData$x_mm, cex=0.5)
## @knitr end GR42

#######################################
## EXPLORATORY PLOTTING
#######################################
## @knitr GR43
? pairs()
## @knitr end GR43

## A VERY COOL FUCNTION, BUT ONLY WORKS WITH NUMERIC DATA
## Great way to quickly access collinearity among variables
## @knitr GR44
pairs(pingData)
## @knitr end GR44

## WHICH COLUMNS HAVE NUMERIC DATA??
## @knitr GR45
names(pingData) 
comps <- names(pingData)[3:7]
comps
## @knitr end GR45

## PLOT ALL PAIR-WISE COMPARISONS FOR NUMERIC Pinguitellina DATA
## @knitr GR46
pairs(pingData[comps])
## @knitr end GR46

## and an explaination for why there are two relations instead of 1!

#######################################
## 3D PLOTTING
#######################################

# LETS USE THE BUILT IN volcano DATASET FOR THIS...
## @knitr GR47
?volcano
## @knitr end GR47

# TO GOOD BUILT IN FUNCTIONS ARE image() AND contour()
## @knitr GR48
image(volcano)
## @knitr GR49
contour(volcano)
## @knitr end GR49

## SPECIFY THE COLOUR GRADIENT
## @knitr GR50
image(volcano, col=terrain.colors(50))
## @knitr end GR50
## "ADD" CONTOURS OVER TOP OF image()
## @knitr GR51
contour(volcano, add=TRUE)
## @knitr end GR51

#	It is possible to read shape files, and do basic GIS type things in R.

#######################################
## BAR PLOTS
#######################################

# I PERSONALLY REALLY DISLIKE BARPLOTS, BUT THEY ARE COMMONLY USED
# R DOES NOT HAVE A STANDARD ERROR FUNCTION, BUT WE CAN WRITE ONE...
## @knitr GR52
standard.error <- function(x) { sd(x)/sqrt(length(x)) }
## @knitr end GR52
## REMEMBER ALL THE WAY BACK TO THE MORNING...
## USE "aggregate" TO GET THE mean otiShells['x_mm'] BY otiShells["taxonName"]
## TIP: USING otiShells["x_mm"] INSTEAD OF otiShells$x_mm GIVES YOU NICER COLUMN NAMES
## @knitr GR53
mn <- aggregate(otiShells['x_mm'], otiShells["taxonName"], mean) 
bp <- barplot(mn$x_mm)
## @knitr end GR53
## NOTE: BY ASSIGNING barplot() TO bp... WE CAN DO THE NEXT STEP

## USE "aggregate" TO GET THE standard.error
## @knitr GR54
se <- aggregate(otiShells['x_mm'], otiShells["taxonName"], standard.error)
## @knitr end GR54
## ADD THE STANDARD ERROR USING arrows
## @knitr GR55
arrows(bp, mn$x_mm + se$x_mm, bp, mn$x_mm - se$x_mm, code=3, angle=90, length=0.1, lwd=2)
## @knitr end GR55
## ?? DOESN'T QUITE LOOK RIGHT

## MAKE A BAR PLOT AND SPECIFY Y-AXIS "ylim" SO THAT THE WHOLE SE FITS IN...
## @knitr GR56
bp <- barplot(mn$x_mm, ylim=c(0, max(mn$x_mm + se$x_mm, na.rm=TRUE))) 
arrows(bp, mn$x_mm + se$x_mm, bp, mn$x_mm - se$x_mm, code=3, angle=90, length=0.1, lwd=2)
## @knitr end GR56

## ADD LABELS USING axis()
## @knitr GR57
axis(1, at=bp, labels=mn$taxonName, font=3) 
## @knitr end GR57
## STILL NOT WHAT WE WANT BECAUSE R DOES SKIPS LABELS THAT WOULD OVER WRITE
# try again but rotating the axis labels 90 degrees
## @knitr GR58
bp <- barplot(mn$x_mm, ylim=c(0, max(mn$x_mm + se$x_mm, na.rm=TRUE))) 
arrows(bp, mn$x_mm + se$x_mm, bp, mn$x_mm - se$x_mm, code=3, angle=90, length=0.1, lwd=2)
axis(1, at=bp, labels= mn$taxonName, las=2, font=3)
title("Getting it just right can be a pain...")
## @knitr end GR58

##  HOW DO WE FIX THE MARGIN SIZE...
##  SHOW ME HOW TO DO THAT CRAZY VOODOO THAT YOUDOO?
##  REMEMBER IF YOU DIG DEEP ENOUGH YOU CAN TINKER WITH ANYTHING IN R
##  Afraid? "You will be. You... will... be." (Yoda) 


#######################################
##  GLOBAL GRAPHIC PARAMETERS
#######################################
## @knitr GR59
?par
## @knitr end GR59
# NOTE: NO ONE REMEMBERS ALL OF THESE PARAMETERS BUT HOPEFULLY YOU WILL REMEMBER THAT ?par GETS YOU THE ANSWER
# NOTE: CLOSING YOUR GRAPHING WINDOW WILL RESET YOUR GLOBAL PARAMETERS (FOR GOOD AND BAD)
# TIP: YOU CAN SAVE PARAMETERS TO A VARIABLE TO RESTORE YOUR OLD ONES
# TIP: par() WILL TELL YOU WHAT THE CURRENT PARAMETERS ARE

# SAVE CURRENT / ORIGINAL PARAMETERS
## @knitr GR60
oldPar <- par()
## @knitr end GR60

## SO HOW CAN WE FIX OUR MARGIN ISSUE?
# use par() to set margin. hint: try 12 for margin 1
## @knitr GR61
par(mar=c(12, 4, 4, 2)) 
bp <- barplot(mn$x_mm, ylim=c(0, max(mn$x_mm + se$x_mm, na.rm=TRUE))) 
arrows(bp, mn$x_mm + se$x_mm, bp, mn$x_mm - se$x_mm, code=3, angle=90, length=0.1, lwd=2)
axis(1, at=bp, labels= mn$taxonName, las=2, font=3, cex=0.7)
mtext("Species", side=1, line=10) 
mtext("Shell length (mm)", side=2, line=3) 
title("... but it can be worth it?")
## @knitr end GR61

# RESTORE ORIGINAL PARAMETERS
## @knitr GR62
par(oldPar)
## @knitr end GR62


#######################################
## SAVING PLOTS
#######################################

# NOTE: YOU CAN SAVE OR "EXPORT" THE GRAPHING WINDOW TO SAVE YOUR PLOTS
# TIP: DON'T SAVE OR "EXPORT" THE GRAPHING WINDOW TO SAVE YOUR PLOTS
# TIP: ALWAYS USE A VECTOR FORMAT (I.E., PDF) SO THAT YOUR PLOTS LOOK GOOD WHEN SCALED
# TIP: IF YOU MUST USE A RASTER FORMAT USE PNG RATHER THAN JPEG
# TIP: SAVE YOUR PLOT FROM THE COMMAND LINE!
#       - TOTAL CONTROL OF PLOT SIZES, ETC TO MEET SPECIFIC JOURNAL REQUIREMENTS
#       - YOU CAN JUST RUN A SCRIPT TO REGENERATE ALL YOUR PLOTS IF (WHEN) YOUR DATA CHANGE OR YOUR SUPERVISOR WANTS IT TO LOOK A LITTLE DIFFERENT
#       - EVERYTIME THE SCRIPT RUNS YOU WILL ALWAYS GET THE EXACT SAME PLOT, REPRODUCIBILITY IS KEY TO GOOD SCIENCE

# TIP: MAKE A SUBDIRECTORY CALLED "figs" IN YOUR PROJECT DIRECTORY
## @knitr GR63
dir.create("./figs")
## @knitr end GR63

# NOTE: FANCY SCRIPT - ONLY CREATES THE DIRECTORY IF THE DIRECTORY IS NOT ALREADY THERE
# TIP: DEALING WITH THE UNEXPECTED WELL IS WHAT MAKES FLEXIBLE CODE (MOST CODE WE WRITE IT NOT FLEXIBLE)
## @knitr GR64
if(!("./figs") %in% list.dirs(".")) dir.create("./figs")
## @knitr end GR64

# START A PDF FILE TO WRITE TO
## @knitr GR65
pdf("./figs/my_barplot.pdf", width=5, height=5) 
## @knitr end GR65
# WHAT ARE THE UNITS OF WIDTH AND HEIGHT
## @knitr GR66
par(mar=c(12, 4, 4, 2)) 
bp <- barplot(mn$x_mm, ylim=c(0, max(mn$x_mm + se$x_mm, na.rm=TRUE)), las=1) 
arrows(bp, mn$x_mm + se$x_mm, bp, mn$x_mm - se$x_mm, code=3, angle=90, length=0.04, lwd=2)
axis(1, at=bp, labels= mn$taxonName, las=2, font=3, cex=0.7)
mtext("Species", side=1, line=10) 
mtext("Shell length (mm)", side=2, line=2.5) 
title("One Tree Reef Bivalvia") 
dev.off()
## @knitr end GR66

## MUST ALWAYS USE dev.off() WHEN YOU ARE DONE WRITING TO THE FILE... OR IT STAYS OPEN...

# START A PNG FILE
## @knitr GR67
png(filename="./figs/my_barplot.png", width=400, height=400) 
par(mar=c(12, 4, 4, 2)) 
bp <- barplot(mn$x_mm, ylim=c(0, max(mn$x_mm + se$x_mm, na.rm=TRUE)), las=1) 
arrows(bp, mn$x_mm + se$x_mm, bp, mn$x_mm - se$x_mm, code=3, angle=90, length=0.04, lwd=2)
axis(1, at=bp, labels= mn$taxonName, las=2, font=3, cex=0.7)
mtext("Species", side=1, line=10) 
mtext("Shell length (mm)", side=2, line=2.5) 
title("One Tree Reef Bivalvia") 
dev.off()
## @knitr end GR67

##  TIP: WHEN THINGS GO WRONG SAVING PLOTS
##  - IT IS NEARLY ALWAYS BECAUSE THE FILE WAS NOT CLOSED
##  - REPEAT dev.off() until it says "cannot shut down device"


#######################################
## MULTIPLE PANEL PLOTS
#######################################

## "mfrow" FILLS YOUR PANELS ACROSS THE TOP ROW AND THEN SEQUENTIAL ROWS DOWN
## "mfcol" FILLS YOUR PANELS DOWN THE LEFT MOST COLUMN FIRST...
## @knitr GR68
oldPar <- par()
## @knitr end GR68

##  MAKE 4 HISTOGRAMS
## @knitr GR69
par(mfcol=c(2,2)) 
plot(aHist, col='blue', ann=FALSE, main='Abranda') 
pHist <- hist(pingData$x_mm, col='green', main='Pinguitellina') 
hist(pingData$y_mm, col='red') 
plot(aHist,col='pink', ann=FALSE) 
par(oldPar)
## @knitr end GR69

##  LETS MAKE IT NICER...
##  - SET MARGINS ALL TO 1
##  - SET THE OUTER MARGINS TO c(4,3,4,2)
## @knitr GR70
par(mfrow=c(2, 2), mar=c(1, 1, 1, 1), oma=c(4, 3, 4, 2))
## @knitr end GR70

##  LETS ONLY PUT THE OUTER AXES ON (COMMON IF THE AXES ARE THE SAME)
##  LETS LABEL EACH PANEL A-D IN THE UPPER LEFT CORNER
## @knitr GR71
plot(aHist, ann=FALSE, axes=FALSE, col='forestgreen', xlim=range(pHist$breaks, aHist$breaks)) 
axis(2) 
mtext("A", 3, -2, adj = 0.1, font=2, cex=1.2) 
hist(pingData$x_mm, ann=FALSE, axes=FALSE, col='skyblue') 
mtext("B", 3, -2, adj = 0, font=2, cex=1.2) 
plot(pHist, ann=FALSE, col='pink', xlim=range(pHist$breaks, aHist$breaks)) 
mtext("C", 3, -2, adj = 0.1, font=2, cex=1.2) 
hist(pingData$x_mm, ann=FALSE, axes=FALSE, col='grey40') 
axis(1) 
mtext("D", 3, -2, adj = 0, font=2, cex=1.2)
## @knitr end GR71

##  JUST TO DEMONSTRATE THE POSSIBLE BOXES...
## @knitr GR72
? box()
## @knitr GR73
box("plot", col="red") 
box("figure", col="blue") 
box("inner", col="black") 
box("outer", col="pink")
## @knitr end GR73

##	mtext REALLY SHINES - PUTTING JOINT AXIS LABELS "outer"
## @knitr GR74
mtext("Shell size (mm)", side=1, outer=TRUE, line=2) 
mtext("Frequency", side=2, outer=TRUE, line=2) 
mtext("Four plots of shell size", side=3, outer=TRUE, line=1, cex=1.5) 
## @knitr GR75
par(oldPar)
## @knitr end GR75

#######################################
##  ADDING ADDITIONAL THINGS TO PLOTS
#######################################
## @knitr GR76
plot(crMass ~ x_mm, pingData, type="p", axes=FALSE, ann=FALSE, pch=21, col="white", bg="black") 
axis(1) 
axis(2, las=2) 
mtext("Shell size (mm)", side = 1, line = 3) 
mtext("Cuberoot shell mass (mg)", side = 2, line = 3) 
title("Figure 1", adj=0)
## @knitr end GR76

##  GET/PLOT A BEST FIT LINE USING lm()
## @knitr GR77
mod <- lm(crMass ~ x_mm, pingData)
## @knitr end GR77

##  PLOT THE LINE USING (abline)
## @knitr GR78
abline(mod, lwd=2, lty=2, col='blue')
## @knitr end GR78

# GET/PLOT THE PREDICTION INTERVALS
## @knitr GR79
hs <- seq(min(pingData$x_mm), max(pingData$x_mm), 1) 
intPred <- predict(mod, list(x_mm = hs), interval = "prediction") 
lines(hs, intPred[,"lwr"], lty = 2) 
lines(hs, intPred[,"upr"], lty = 2) 
## @knitr end GR79

# GET/PLOT THE CONFIDENCE INTERVALS
## @knitr GR80
intConf <- predict(mod, list(x_mm = hs), interval = "confidence") 
lines(hs, intConf[,"lwr"]) 
lines(hs, intConf[,"upr"]) 
## @knitr end GR80

# PLOT A SHADED THE PREDICTION INTERVAL REGION
## @knitr GR81
polygon(c(hs, rev(hs)), c(intPred[,"lwr"], rev(intPred[,"upr"])), col = rgb(0,0,0,0.2), border = NA)
## @knitr end GR81

##  LETS ADD THE R-SQUARED TO THE PLOT
##  TIP: UNICODE CHARACTERS ARE AN EASY WAY TO GET SOME CHARACTERS
## @knitr GR82
text(5,4,paste("r\U00b2 = ",round(summary(mod)$r.squared,2)))
## @knitr end GR82

# ADD A LEGEND
## @knitr GR83
legend("topleft", c("green data", "actual data", "orange cross"), pch=c(4, 20, 3), col=c("green", "black", "orange"), bty="y")
## @knitr end GR83

# ADD SOME MATH 
## @knitr GR84
text(11, 2, expression(Y[i] == beta[0]+beta[1]*X[i1]+epsilon[i])) # see demo(plotmath) for more examples 
## @knitr end GR84

## NOW... WRAP THE SUPER NICE PLOTS INTO A PDF...