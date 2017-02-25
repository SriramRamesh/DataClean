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
    new_DF <- df[is.na(df$year),]

    ym<-nrow(subset(new_DF,is.na(month)))
    yd<-nrow(subset(new_DF,is.na(day)))

    new_DF <- df[is.na(df$month),]
    dm<-nrow(subset(new_DF,is.na(day)))

    Ndf<- new_DF[is.na(new_DF$day),]
    ymd<-nrow(subset(Ndf,is.na(year)))
    score<-y+m+d-yd-ym-dm+ymd
    print("y=")
    print(y)
    print("m=")
    print(m)
    print("d=")
    print(d)
    print("yd=")
    print(yd)
    print("ym=")
    print(ym)
    print("md=")
    print(dm)
    print("ymd=")
    print(ymd)
    score<-score/N
    tmpX[count]<-score
    count<-count+1
  }
  Score<-tmpX
  df<-data.frame(Name,Score)
  print(df)
}
CheckData(c('Helianthus annuus','Ursus americanus'),10000)
