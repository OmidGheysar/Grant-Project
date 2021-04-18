# # Here is one exmaple to follow
# df<-data.frame(ID=c(1:10), Gender=factor(c("M","M","M","","F","F","M","","F","F" )), 
#                AgeGroup=factor(c("[60+]", "[26-35]", "[NA]", "[36-45]", "[46-60]", 
#                                  "[26-35]", "[NA]", "[18-25]", "[26-35]", "[26-35]")))
# 
# levels(df$Gender)[levels(df$Gender)==""] ="U"
# 
# levels(df$AgeGroup)[levels(df$AgeGroup)=="[18-25]"] = "[18-35]"
# levels(df$AgeGroup)[levels(df$AgeGroup)=="[26-35]"] = "[18-35]"
# levels(df$AgeGroup)[levels(df$AgeGroup)=="[36-45]"] = "[35+]"
# levels(df$AgeGroup)[levels(df$AgeGroup)=="[46-60]"] = "[35+]"
# levels(df$AgeGroup)[levels(df$AgeGroup)=="[60+]"] = "[35+]"


unique(grant$Title)
grant$Title <- as.factor(grant$Title)
levels(grant$Title)[levels(grant$Title)==unique(grant$Title)[1]] = "blue"
levels(grant$Title)[levels(grant$Title)==unique(grant$Title)[2]] = "yellow"
levels(grant$Title)[levels(grant$Title)==unique(grant$Title)[3]] = "orange"
levels(grant$Title)[levels(grant$Title)==unique(grant$Title)[4]] = "green"
levels(grant$Title)[levels(grant$Title)==unique(grant$Title)[5]] = "purple"

grant$Title

