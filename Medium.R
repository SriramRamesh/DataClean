CheckData <- function(Name,N){
  x<-Name
  library('rgbif')
  tmpX<-matrix(length(x))
  count<-1
  for(i in x){
    key <- name_backbone(name =i, rank='species')$usageKey
    print("i=")
    print(i)
    df<-data.frame((occ_data(taxonKey=key,limit=N))$data)
    y<-nrow(subset(df,is.na(year)))
    m<-nrow(subset(df,is.na(month)))
    d<-nrow(subset(df,is.na(day)))
    ym<-nrow(subset(df,is.na(year)&&is.na(month)))
    yd<-nrow(subset(df,is.na(year)&&is.na(day)))
    dm<-nrow(subset(df,is.na(day)&&is.na(month)))
    ymd<-nrow(subset(df,is.na(year)&&is.na(month)&&is.na(day)))
    score<-y+m+d-yd-ym-dm+ymd
    score<-score/N
    tmpX[count]<-score
    count<-count+1
  }
  Score<-tmpX
  df<-data.frame(Name,Score)
  print(df)
}
CheckData(c('Helianthus annuus','Ursus americanus'),10000)
