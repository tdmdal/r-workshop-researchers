# load the libraries
library(readr)
library(dplyr)
library(AER)
library(stargazer)
library(ggplot2)

# specify the dataset url
data_url <- "https://tdmdal.github.io/r-workshop-researchers/data/mroz_1987.csv"

# read it into a dataframe, mroz_1987; use the read_csv() function in readr library
mroz_1987 <- read_csv(data_url)

# print out the first few rows of the data
head(mroz_1987)

# summary statistics
summary(mroz_1987)

# data manipulation using dplyr package
# create new variables lwage; mutate()
mroz_1987_reg <- mutate(mroz_1987, lwage = log(wage), expersq = exper^2)

# not necessary for our regression, but for practice, let's filter out the rows where inlf (in labor force) is 1; filter()
mroz_1987_reg <- filter(mroz_1987_reg, inlf == 1)

# not necessary for our regression, but for practice, let's select only lwage, exper, expersq, fathereduc columns; select()
mroz_1987_reg <- select(mroz_1987_reg, lwage, educ, exper, expersq, fatheduc, motheduc)

# can we combine the above three operations in some way; pipe %>%
mroz_1987_reg <- mroz_1987 %>%
  mutate(lwage = log(wage), expersq = exper^2) %>%
  filter(inlf == 1) %>%
  select(lwage, educ, exper, expersq, fatheduc, motheduc)


# three regression models
# 1. simple regression; lm()
lr_simple <- lm(formula = lwage ~ educ, data = mroz_1987_reg)

# 2. multiple regression; lm()
lr_multiple <- lm(formula = lwage ~ educ + exper + expersq, data = mroz_1987_reg)

# 3. iv regression; ivreg() from AER package
lr_multiple_iv <- ivreg(lwage ~ educ + exper + expersq | exper + expersq + fatheduc + motheduc , data = mroz_1987_reg)

# report regression result; summary()
summary(lr_simple)
summary(lr_multiple)
summary(lr_multiple_iv, diagnostics = TRUE)

# can we do better; stargazer package
stargazer(lr_simple, lr_multiple, lr_multiple_iv, title="Results", align = TRUE, type = "text")

stargazer(lr_simple, lr_multiple, lr_multiple_iv, 
          title="Results", dep.var.labels = "log wage",
          align = TRUE, type = "html", style = "aer", out = "regression_result.html")

stargazer(lr_simple, lr_multiple, lr_multiple_iv, 
          title="Results", dep.var.labels = "log wage",
          align = TRUE, type = "latex", style = "aer")


# a few words about plotting: ggplot2 package
ggplot(mroz_1987_reg, aes(x = educ, y = lwage)) +
  geom_point(color = "deeppink", aes(size = exper)) +
  geom_smooth(method = "lm")