spot<-read.csv('E:\\mygit\\spread trading\\2014 LLDPE spot price.csv',header=T)
future<-read.csv('E:\\mygit\\spread trading\\2014 LLDPE futures price.csv',header=T)

#spotdate<-strptime(spot[,1],"%Y-%m-%d")
#spot$DATE<-spotdate
#futuredate<-strptime(future[,1],"%Y-%m-%d")
#future$Date<-futuredate
colnames(spot)<-c('date','222WT','7042YY','7042GZ','7042MM','7042FJ')
colnames(future)<-c('date','open','high','low','close','volume','adj')
head(spot)
head(future)

data1<-merge(spot,future,by='date')
data1date<-strptime(data1[,1],"%Y-%m-%d")  #日期由字符格式转换为日期格式
data1$date<-data1date
data2<-data1[order(data1[,1]),]   #将数据按照日期排序
head(data2)

plot(data2[1:2],type='b')
lines(data2$adj~data2$date)
lines(stats::lowess(data2[1:2]))

jc=data.frame(data2[,1],data2[,2]-data2$adj,data2[,3]-data2$adj,
data2[,4]-data2$adj,data2[,5]-data2$adj,data2[,6]-data2$adj)
head(jc)
colnames(jc)<-c('date','222WT-Adj','7042YY-Adj','7042GZ-Adj','7042MM-Adj','7042FJ-Adj')
summary(jc)
jc[which.max(jc[,3]),] #查找基差最大的项
data2[which(data2[,1]=='2014-12-26'),]


spot[order(spot[,1]),]