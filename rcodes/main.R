# MatchIt 패키지 로드
library(MatchIt)

# 1. 데이터 불러오기
mydata <- read.csv("/app/data/merged_filtered.csv")

# 2. 평균혈압(MAP) 계산
mydata$MAP <- (mydata$HE_sbp + 2 * mydata$HE_dbp) / 3

# 3. 그룹 정의 (1: 처치군, 0: 대조군)
mydata$group <- NA
mydata$group[mydata$BS3_1 == 3.0 & mydata$BS12_47 == 1.0] <- 1
mydata$group[mydata$BS3_1 == 1.0 & mydata$BS12_47 == 8.0] <- 0

# 4. 그룹 정의된 데이터만 필터링
mydata <- mydata[!is.na(mydata$group), ]

# 5. 매칭에 사용할 공변량 목록 지정
covariates <- c("age", "sex", "BD1_11", "BD2_1", "BP1", "BE9", "HE_BMI")

# 6. 공변량에 결측값이 있는 행 제거
mydata_complete <- mydata[complete.cases(mydata[, covariates]), ]

# 7. PSM 수행
psm_model <- matchit(
  group ~ age + sex + BD1_11 + BD2_1 + BP1 + BE9 + HE_BMI,
  data = mydata_complete,
  method = "nearest"
)

# 8. 매칭된 데이터 추출
matched_data <- match.data(psm_model)

# 9. 분석할 결과변수 목록 정의
outcome_vars <- c("MAP", "HE_glu", "HE_chol", "HE_Uacid")

# 10. 각 결과변수에 대해 요약과 t-test 수행
for (var in outcome_vars) {
  cat("\n==============================\n")
  cat("결과변수:", var, "\n")
  cat("==============================\n")
  
  # 요약 통계
  print(summary(matched_data[[var]] ~ matched_data$group))
  
  # t-test
  test_result <- t.test(matched_data[[var]] ~ matched_data$group)
  print(test_result)
}
