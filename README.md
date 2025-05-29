# 연초,액상형,궐련형 담배의 다양한 건강지표에 미치는 영향을 비교
```bash
git clone https://github.com/hbgyeom/psm-pj.git
```
## 대상자 분류 기준
### 변수 설명
- BS3_1 - 현재 일반담배(궐련) 흡연 여부
- BS12_47 - 궐련형 전자담배 현재사용여부
1. 매일피움
2. 가끔피움
3. 과거엔 피웠으나, 현재 피우지 않음
8. 비해당(문항4-②⑧)
9. 모름, 무응답

### 연구군 분류 기준
- 대조군 - 일반담배(궐련)을 매일 피우고(BS3_1=1), 궐련형 전자담배를 피우지 않음(BS12_47=8)
- 처치군 - 일반담배(궐련)을 과거에 피웠으나, 현재 피우지 않으며(BS3_1=3), 궐련형 전자담배를 매일 피움(BS12_47=1)

| 구분 | BS3_1 | BS12_47 |
|:----|:-----:|:-------:|
| 대조군 | 1 | 8 |
| 처치군 | 3 | 1 |
## 디렉토리 설명
pycodes -> 데이터 변환 및 전처리

rcodes -> PSM 분석 진행
## pycodes
### sas2csv.py
sas_data 폴더 안에 있는 .sas7bdat 파일들을 일괄 csv로 변환 후 csv_data 폴더에 저장
```
Converted: hn19_all.csv
Converted: hn18_all.csv
Converted: hn22_all.csv
Converted: hn23_all.csv
Converted: hn20_all.csv
Converted: hn21_all.csv
```
### row-filter.py
csv_data 폴더 안에 있는 .csv 파일들을 대상자 분류 기준에 따라 필터링 후 row_data 폴더에 저장
```
Filtered: row_hn22_all.csv - 596 rows
Filtered: row_hn19_all.csv - 681 rows
Filtered: row_hn20_all.csv - 666 rows
Filtered: row_hn21_all.csv - 617 rows
Filtered: row_hn23_all.csv - 626 rows
Filtered: row_hn18_all.csv - 746 rows
```
