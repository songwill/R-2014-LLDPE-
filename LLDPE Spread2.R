#导入数据
spot<-read.csv('E:\\mygit\\spread trading\\2014 LLDPE spot price.csv',header=T)
future<-read.csv('E:\\mygit\\spread trading\\2014 LLDPE futures price.csv',header=T)

#修改列名称
colnames(spot)<-c('date','222WT','7042YY','7042GZ','7042MM','7042FJ')
colnames(future)<-c('date','open','high','low','close','volume','adj')
head(spot)
head(future)

#按照日期合并两表
data1<-merge(spot,future,by='date')
data1date<-strptime(data1[,1],"%Y-%m-%d")  #日期由字符格式转换为日期格式
data1$date<-data1date
data2<-data1[order(data1[,1]),]   #将数据按照日期排序
head(data2)

#画图整合
plot(data2[1:2],type='l')
library(ggplot2)
qplot(date,`7042YY`,data=data2,geom=c('point','smooth'),span=0.2,
      main='2014年7042余姚市场价格')
qplot(date,data2[,2],data=data2,geom='line',colour='red')
lines(data2$date,data2$adj)
lines(data2$date,data2$`7042YY`,col='red')

p<-ggplot(data2,aes(x=date,y=adj))
p+geom_line()

p<-ggplot(data2)
p+geom_line(aes(x=date,y=`7042YY`),col='red')
last_plot()+geom_line(aes(x=date,y=adj),col='green',main='2014年7042余姚市场价格和期货价格')


#基差计算
jc=data.frame(data2[,1],data2[,2]-data2$adj,data2[,3]-data2$adj,
data2[,4]-data2$adj,data2[,5]-data2$adj,data2[,6]-data2$adj)
head(jc)
colnames(jc)<-c('date','222WT-Adj','7042YY-Adj','7042GZ-Adj','7042MM-Adj','7042FJ-Adj')
summary(jc)
jc[which.max(jc[,3]),] #查找基差最大的项
data2[which(data2[,1]=='2014-12-26'),]


