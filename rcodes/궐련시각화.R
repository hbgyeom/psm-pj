# MatchIt 패키지 로드
library(MatchIt)

# 1. 데이터 불러오기
mydata <- read.csv("C:/Users/jit48/Downloads/merged_filtered.csv")

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
  method = "nearest",
)

summary(psm_model$model)

# 8. 매칭된 데이터 추출
matched_data <- match.data(psm_model)

# 9. 그룹별 평균혈압 요약 출력
summary(matched_data$MAP ~ matched_data$group)

# 10. (선택) 통계적 유의성 검정 (t-test)
t.test(MAP ~ group, data = matched_data)

library(ggplot2) 
ggplot(matched_data, aes(x = factor(group), y = MAP)) +
  geom_boxplot(fill = "lightblue", color = "darkblue") +
  labs(x = "Group (0 = 일반담배, 1 = 궐련형)", y = "평균혈압 (MAP)", title = "PSM 후 평균혈압 비교") +
  theme_minimal()

ggplot(matched_data, aes(x = MAP, fill = factor(group))) +
  geom_density(alpha = 0.4) +
  labs(x = "평균혈압 (MAP)", fill = "Group", title = "PSM 후 MAP 밀도 분포") +
  theme_minimal()

# 평균과 표준오차 계산
library(dplyr)
group_stats <- matched_data %>%
  group_by(group) %>%
  summarise(mean_MAP = mean(MAP), se = sd(MAP) / sqrt(n()))

# 시각화
ggplot(group_stats, aes(x = factor(group), y = mean_MAP)) +
  geom_col(fill = "skyblue") +
  geom_errorbar(aes(ymin = mean_MAP - se, ymax = mean_MAP + se), width = 0.2) +
  labs(x = "Group (0 = 일반담배, 1 = 궐련형)", y = "평균 MAP", title = "그룹별 평균 MAP ± SE") +
  theme_minimal()

ggplot(matched_data, aes(x = factor(group), y = HE_glu)) +
  geom_boxplot(fill = "lightgreen", color = "darkgreen") +
  labs(x = "그룹", y = "혈당 (HE_glu)", title = "PSM 후 혈당 비교") +
  theme_minimal()


ggplot(matched_data, aes(x = HE_glu, fill = factor(group, labels = c("일반담배", "궐련형")))) +
  geom_density(alpha = 0.4) +
  labs(x = "혈당 (HE_glu)", fill = "그룹", title = "PSM 후 혈당 분포") +
  theme_minimal()

ggplot(matched_data, aes(x = factor(group), y = HE_chol)) +
  geom_boxplot(fill = "lightcoral", color = "darkred") +
  labs(x = "그룹", y = "총콜레스테롤 (HE_chol)", title = "PSM 후 총콜레스테롤 비교") +
  theme_minimal()

ggplot(matched_data, aes(x = HE_chol, fill = factor(group, labels = c("일반담배", "궐련형")))) +
  geom_density(alpha = 0.4) +
  labs(x = "총콜레스테롤 (HE_chol)", fill = "그룹", title = "PSM 후 총콜레스테롤 분포") +
  theme_minimal()

ggplot(matched_data, aes(x = factor(group), y = HE_Uacid)) +
  geom_boxplot(fill = "lightyellow", color = "orange") +
  labs(x = "그룹", y = "요산 (HE_Uacid)", title = "PSM 후 요산 비교") +
  theme_minimal()

ggplot(matched_data, aes(x = HE_Uacid, fill = factor(group, labels = c("일반담배", "궐련형")))) +
  geom_density(alpha = 0.4) +
  labs(x = "요산 (HE_Uacid)", fill = "그룹", title = "PSM 후 요산 분포") +
  theme_minimal()
