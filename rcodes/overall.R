# This code is to show overall summary for all considerable variables

mydata <- read.csv("/app/data/merged_filtered.csv")

co_vars <- c(
             "sex", # 성별
             "age", # 나이
             "BD1_11", # 1년간 음주빈도
             "BD2_1", # 한 번에 마시는 음주량
             "BP1", # 평소 스트레스 인지 정도
             "BE9", # 하루 60분 이상 신체활동 실천 일수
             "HE_BMI" # 체질량지수
)

out_vars <- c(
              "D_1_1", # 주관적 건강인지
              "HE_sbp", # 최종 수축기 혈압(2,3차 평균)
              "HE_dbp", # 최종 이완기 혈압(2,3차 평균)
              "HE_glu", # 공복혈당
              "HE_chol" # 총콜레스테롤
)


# sink("overall.txt")

cat("\n")
cat("===== Confounders Summary =====\n")
cat("\n")
summary(mydata[co_vars])
cat("\n")
cat("===== Outcomes Summary =====\n")
cat("\n")
summary(mydata[out_vars])
cat("\n")

# sink()
