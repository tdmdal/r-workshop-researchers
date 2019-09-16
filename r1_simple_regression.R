# 1. Data Import & Manipulation

# load data
data_url <- "https://tdmdal.github.io/r-workshop-researchers/data/mroz_1987.csv"
mroz_1987 <- read.csv(data_url)

# take a look at the structure of the data
str(mroz_1987)

# print the first few rows of the dataset
head(mroz_1987)

# create log wage
mroz_1987["lwage"] <- log(mroz_1987["wage"])


# 2. Modelling

# setup a regression model
lr <- lm(formula = lwage ~ educ, data = mroz_1987)


# 3. Report and Graph

# report regression result
summary(lr)

# plot data and regression line
par(mfrow = c(1, 1))
plot(mroz_1987[c("educ", "lwage")])
abline(coef(lr))

# plot a few other things
par(mfrow = c(2, 2))
plot(lr)

