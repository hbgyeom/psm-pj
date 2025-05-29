library(MatchIt)

mydata <- read.csv("/app/data/merged_filtered.csv")

mydata$group <- NA
mydata$group[mydata$BS3_1 == 3.0 & mydata$BS12_47 == 1.0] <- 1
mydata$group[mydata$BS3_1 == 1.0 & mydata$BS12_47 == 8.0] <- 0

mydata <- mydata[!is.na(mydata$group), ]

mydata$D_1_1B <- ifelse(mydata$D_1_1 == 9, NA,
                        ifelse(mydata$D_1_1 <= 3, 1, 0))

myvars <- c("D_1_1B", "sex", "age", "BD1_11", "BP1", "BE9", "HE_BMI")
mydata_clean <- mydata[complete.cases(mydata[, myvars]), ]

psm_model <- matchit(group ~ age + sex + BD1_11 + BP1 + BE9 + HE_BMI,
                     data = mydata_clean,
                     method = "nearest")

matched_data <- match.data(psm_model)
summary(psm_model$model)
summary(psm_model)

model <- glm(D_1_1B ~ group, data = matched_data, family = binomial)
summary(model)

chisq.test(matched_data$D_1_1B, matched_data$group)
