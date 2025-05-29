# This code is to show overall summary for all considerable variables

mydata <- read.csv("/app/data/merged_filtered.csv")

co_vars <- c(
             "sex", # 성별
             "age", # 나이
             "ho_incm", # 소득 4분위수(가구)
             "edu", # 교육수준 재분류 코드
             "occp", # 직업재분류 및 실업/비경제활동 상태 코드

             "marri_1", # 결혼여부
             
             "EC_wht_23", # 주당 평균 근로시간

             "BD1_11", # 1년간 음주빈도
             "BD2_1", # 한 번에 마시는 음주량

             "BE9", # 하루 60분 이상 신체활동 실천 일수

             "HE_fh", # 만성질환 의사진단 가족력 여부

             "HE_BMI" # 체질량지수
)

out_vars <- c(
              "D_1_1", # 주관적 건강인지
              
              "BH2_61", # 2년간 암검진 여부
              
              "HE_sbp", # 최종 수축기 혈압(2,3차 평균)
              "HE_dbp", # 최종 이완기 혈압(2,3차 평균)

              "HE_glu", # 공복혈당
              "HE_HbA1c", # 당화혈색소

              "HE_chol", # 총콜레스테롤
              "HE_HDL_st2", # HDL-콜레스테롤
              "HE_TG", # 중성지방
              "HE_LDL_drct" # LDL-콜레스테롤
)


sink("overall.txt")

cat("\n")
cat("===== Confounders Summary =====\n")
cat("\n")
summary(mydata[co_vars])
cat("\n")
cat("===== Outcomes Summary =====\n")
cat("\n")
summary(mydata[out_vars])
cat("\n")

sink()
