library(data.table)
library(jsonlite)
library(ggplot2)
library(stringr)
#Enrolment In University First Degree Courses By Type Of Course And Sex, Annual
LS <- read_json("http://www.tablebuilder.singstat.gov.sg/publicfacing/api/json/title/15207.json",
                 simplifyVector = T)


dt <- data.table(LS$Level2)
dt[value=="na",value:=NA]
dt[,value:=as.numeric(value)]
dt[,level_2:=str_replace(level_2,"^.+: ","")]

dtRatio <- dt[,.(ratio = value[level_1=="Males"]/sum(value)),.(year,level_2)]
dtRatio <- dtRatio[is.na(ratio)==F]
dtMax <- dtRatio[,.SD[ratio==max(ratio)],level_2]
dtMin <- dtRatio[,.SD[ratio==min(ratio)],level_2]


ggplot(data= dt)+
  ggtitle("Singapore's Gender Proportion Trend of University Graduates (1993-2016)")+
  geom_col(aes(x=year,y=value,fill=level_1),position = "fill",width = 1,color="black")+
  geom_point(data = dtMax,aes(x=year,y=ratio),pch=25,bg="black")+
  geom_text(data = dtMax,aes(x=year,y=ratio,label=round(ratio,digits = 3)),nudge_y = 0.05)+
  geom_point(data = dtMin,aes(x=year,y=ratio),pch=24,bg="black")+
  geom_text(data = dtMin,aes(x=year,y=ratio,label=round(ratio,digits = 3)),nudge_y = -0.05)+
  facet_wrap(~level_2,scales = "free")+
  scale_x_discrete(breaks=seq(1990,2015,by=5))+
  theme_minimal()+
  theme(legend.position = "bottom",panel.ontop = TRUE,
        axis.title = element_blank(),
        text = element_text(size=15),
        panel.grid.major = element_blank(),
        panel.grid.major.y = element_line(colour = "black"),
        panel.grid.minor = element_blank())

ggplot(data= dt)+
  ggtitle("Singapore's Gender Proportion Trend of University Graduates (1993-2016)")+
  geom_col(aes(x=year,y=value,fill=level_1),position = "fill",width = 1)+
  geom_point(data = dtMax,aes(x=year,y=ratio),pch=25,bg="black")+
  geom_text(data = dtMax,aes(x=year,y=ratio,label=round(ratio,digits = 3)),nudge_y = 0.05)+
  geom_point(data = dtMin,aes(x=year,y=ratio),pch=24,bg="black")+
  geom_text(data = dtMin,aes(x=year,y=ratio,label=round(ratio,digits = 3)),nudge_y = -0.05)+
  facet_wrap(~level_2,scales = "free")+
  scale_x_discrete(breaks=seq(1990,2015,by=5))+
  theme_minimal()+
  theme(legend.position = "bottom",panel.ontop = TRUE,
        axis.title = element_blank(),
        text = element_text(size=15),
        panel.grid.major = element_line(colour = "black"),
        panel.grid.minor = element_blank())


ggplot(data= dt)+
  ggtitle("Singapore's Gender Proportion Trend of University Graduates (1993-2016)")+
  geom_col(aes(x=year,y=value,fill=level_1),position = "fill",width = 1)+
  geom_point(data = dtMax,aes(x=year,y=ratio),pch=25,bg="black")+
  geom_text(data = dtMax,aes(x=year,y=ratio,label=round(ratio,digits = 3)),nudge_y = 0.05)+
  geom_point(data = dtMin,aes(x=year,y=ratio),pch=24,bg="black")+
  geom_text(data = dtMin,aes(x=year,y=ratio,label=round(ratio,digits = 3)),nudge_y = -0.05)+
  facet_wrap(~level_2,scales = "free")+
  scale_x_discrete(breaks=seq(1990,2015,by=5))+
  theme_minimal()+
  theme(legend.position = "bottom",panel.ontop = TRUE,
        axis.title = element_blank(),
        axis.text.y = element_blank(),
        text = element_text(size=15),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

