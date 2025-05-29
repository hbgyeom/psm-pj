library(MatchIt)

mydata <- read.csv("/app/data/merged_filtered.csv")

# 혼동변수
co_vars <- c(
             # 기본변수
             "sex", # 성별
             "age", # 나이
             "ho_incm", # 소득 4분위수(가구)
             # "edu", # 교육수준 재분류 코드 / 결측치 많음

             # 가구조사
             "marri_1", # 결혼여부
             
             # 경제활동
             "EC1_1", # 경제활동 상태
             "EC_occp", # 표준직업분류 대분류 코드
             "EC_wht_23", # 주당 평균 근로시간
             "EC_lgw_2" # 최장일자리: 표준직업분류
                        # 대분류 코드+실업/비경활 상태
)

# 결과변수
out_vars <- c(
              "D_1_1", # 주관적 건강인지
              
              # 강한 연관
              "DI1_pr", # 고혈압 현재 유병 여부
              "DI2_pr", # 이상지질혈증 현재 유병 여부
              "DE1_pr", # 당뇨병 현재 유병 여부
              
              # 연관 있음
              "DJ4_dg", # 천식 의사진단 여부
              "DJ6_dg", # 부비동염 의사진단 여부

              "BH2_61" # 2년간 암검진 여부
)

cat("========= Data Summary =========\n")
cat("===== Confounders Summary =====\n")
cat("\n")
summary(mydata[co_vars])
cat("\n")
cat("===== Outcomes Summary =====\n")
cat("\n")
summary(mydata[out_vars])
cat("\n")
cat("================================\n")

mydata$group <- NA
mydata$group[mydata$BS3_1 == 3.0 & mydata$BS12_47 == 1.0] <- 1
mydata$group[mydata$BS3_1 == 1.0 & mydata$BS12_47 == 8.0] <- 0

# table(mydata$group)

mydata <- mydata[!is.na(mydata$group), ]

mydata$D_1_1B <- ifelse(mydata$D_1_1 == 9, NA,
                        ifelse(mydata$D_1_1 <= 3, 1, 0))

# myvars <- c("D_1_1B", "sex", "age", "marri_1")
myvars <- c("D_1_1B", "sex", "age", "BD1_11", "BP1", "BE9", "HE_BMI")
mydata_clean <- mydata[complete.cases(mydata[, myvars]), ]

# table(mydata_clean$group)

# psm_model <- matchit(group ~ sex + age + marri_1 + BD1_11,
#                     data = mydata_clean,
#                     method = "nearest")

psm_model <- matchit(group ~ age + sex + BD1_11 + BP1 + BE9 + HE_BMI,
                     data = mydata_clean,
                     method = "nearest")

matched_data <- match.data(psm_model)
# summary(psm_model)

model <- glm(D_1_1B ~ group, data = matched_data, family = binomial)
summary(model)

chisq.test(matched_data$D_1_1B, matched_data$group)
