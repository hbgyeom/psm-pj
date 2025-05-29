library(MatchIt)

mydata <- read.csv("/app/data/merged_filtered.csv")

co_vars <- c(
             # 기본변수
             "sex", # 성별
             "age", # 나이
)

out_vars <- c(
              "D_1_1", # 주관적 건강인지
              
              # 강한 연관
              "DI1_pr", # 고혈압 현재 유병 여부
              "DI2_pr", # 이상지질혈증 현재 유병 여부
              "DE1_pr", # 당뇨병 현재 유병 여부

              "BH2_61" # 2년간 암검진 여부
)

cat("===== Confounders Summary =====\n")
cat("\n")
summary(mydata[co_vars])
cat("\n")
cat("===== Outcomes Summary =====\n")
cat("\n")
summary(mydata[out_vars])
cat("\n")

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

model <- glm(D_1_1B ~ group, data = matched_data, family = binomial)
summary(model)

chisq.test(matched_data$D_1_1B, matched_data$group)
