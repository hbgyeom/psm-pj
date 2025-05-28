df <- read.csv("/app/data/merged_filtered.csv")

co_vars <- c(
             "sex", # 성별
             "age", # 나이
             "ho_incm", # 소득 4분위수(가구)
             "edu", # 교육수준 재분류 코드
             "marri_1" # 결혼여부
)

out_vars <- c(
              "D_1_1", # 주관적 건강인지
              "DI1_dg", # 고혈압 의사진단 여부
              "DI1_pr", # 고혈압 현재 유병 여부
              "DI2_dg", # 이상지질혈증 의사진단 여부
              "DI2_pr", # 이상지질혈증 현재 유병 여부
              "DE1_dg", # 당뇨
              "DE1_pr",
              "DJ4_dg", # 천식
              "DJ6_dg", # 부비동염
              "DH4_dg"
)

cat("===== Confounders Summary =====\n")
summary(df[co_vars])
cat("===== Outcomes Summary =====\n")
summary(df[out_vars])
