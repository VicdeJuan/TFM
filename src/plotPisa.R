setwd('/home/vicdejuan/Documents/Master/TFM/src')
library(ggplot2)


rez=read.csv('pisa.csv')[c(1,2,3)]
ex=read.csv('pisa.csv')[c(1,4,5)]

pex = ggplot(ex,aes(x=factor(Year))) + 
    geom_bar(aes(y=OCDE.1,fill="Media OCDE"),stat="identity") + 
    geom_line(aes(y=Espana.1,color="España"),group = 1)+ 
    scale_colour_manual(" ", values=c("Media OCDE" = cbPalette[3], "España" = cbPalette[6]))+
    scale_fill_manual("",values=cbPalette[3])+
    xlab("Año") + ylab("Porcentaje excelentes") + 
    theme(legend.key=element_blank(),
        legend.title=element_blank(),
        axis.text.y = element_text(face="bold", 
                                   size=12))
ggsave("../img/PisaExcelentes.png")

prez = ggplot(rez,aes(x=factor(Year))) + 
  geom_bar(aes(y=OCDE,fill="Media OCDE"),stat="identity") + 
  geom_line(aes(y=Espana,color="España"),group = 1)+ 
  scale_colour_manual(" ", values=c("Media OCDE" = cbPalette[3], "España" = cbPalette[6]))+
  scale_fill_manual("",values=cbPalette[3])+
  xlab("Año") + ylab("Porcentaje rezagados") + 
  theme(legend.key=element_blank(),
        legend.title=element_blank(),
        axis.text.y = element_text(face="bold", 
                                   size=12))

ggsave("../img/PisaRezagados.png")