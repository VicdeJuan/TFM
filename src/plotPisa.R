setwd('/home/vicdejuan/Documents/Master/TFM/src')
library(ggplot2)

cbPalette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")


rez=read.csv('pisa.csv')[c(1,2,3)]
ex=read.csv('pisa.csv')[c(1,4,5)]

color1=3
color2=7

pex = ggplot(ex,aes(x=factor(Year))) + 
    geom_bar(aes(y=OCDE.1,fill="Media OCDE"),stat="identity") + 
    geom_line(aes(y=Espana.1,color="España"),group = 2,size=1.2)+ 
    geom_point(aes(y=Espana.1,color="España"),group = 1,size=3)+
    scale_colour_manual(" ", values=c("Media OCDE" = cbPalette[color1], "España" = cbPalette[color2]))+
    scale_fill_manual("",values=cbPalette[color1])+
    xlab("Año") + ylab("Porcentaje excelentes") + 
    theme(legend.key=element_blank(),
        legend.title=element_blank(),
        axis.text=element_text(size=15,face="bold"),
        axis.title=element_text(size=14,face="bold"))
        
ggsave("../img/PisaExcelentes.png",height=6,width=8)

prez = ggplot(rez,aes(x=factor(Year))) + 
  geom_bar(aes(y=OCDE,fill="Media OCDE"),stat="identity") + 
  geom_line(aes(y=Espana,color="España"),group = 2,size=1.2)+ 
  geom_point(aes(y=Espana,color="España"),group = 1,size=3)+
  scale_colour_manual(" ", values=c("Media OCDE" = cbPalette[color1], "España" = cbPalette[color2]))+
  scale_fill_manual("",values=cbPalette[color1])+
  xlab("Año") + ylab("Porcentaje rezagados") + 
  theme(legend.key=element_blank(),
        legend.title=element_blank(),
        axis.title=element_text(size=14,face="bold"),
        axis.text=element_text(size=15,face="bold"))

ggsave("../img/PisaRezagados.png",height=6,width=8)