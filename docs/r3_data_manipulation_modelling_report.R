# load the libraries


# specify the dataset url
data_url <- "https://tdmdal.github.io/r-workshop-researchers/data/mroz_1987.csv"

# read it into a dataframe, mroz_1987; use the read_csv() function in readr library


# print out the first few rows of the data


# summary statistics


# data manipulation using dplyr package
# create new variables lwage; mutate()


# not necessary for our regression, but for practice, let's filter out the rows where inlf (in labor force) is 1; filter()


# not necessary for our regression, but for practice, let's select only lwage, exper, expersq, fathereduc columns; select()


# can we combine the above three operations in some way; pipe %>%




# three regression models
# 1. simple regression; lm()


# 2. multiple regression; lm()


# 3. iv regression; ivreg() from AER package


# report regression result; summary()


# can we do better; stargazer package



# a few words about plotting: ggplot2 package
