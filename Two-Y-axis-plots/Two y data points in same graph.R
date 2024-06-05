data("swiss")
##help(swiss) ## understand the data 

# Now lets we need to plot Fertility and Infant Mortality in the same plot but using 
# Same extent of Y axis. 

## let create a ploting data. 

plot_data<- data.frame(district=rownames(swiss),Fertility=swiss$Fertility,
                       Infant_Mortality=swiss$Infant.Mortality)

#lets start with simple ggplot2 with two graphs
library(ggplot2)
library(dplyr)
library(patchwork) # To display 2 charts together
library(hrbrthemes)
library(ggnewscale)
Fertility_plot<-ggplot(data = plot_data,aes(x=district))+
  geom_point(aes(y=Fertility),col="blue")+
  ggtitle(paste("Range Of Fertility",as.character(min(swiss$Fertility)),":",
                as.character(max(swiss$Fertility))))+
  theme_classic()+
  theme(axis.text.x = element_text(angle = 90))
  
Fertility_plot
Infant_Mortality<-ggplot(data = plot_data,aes(x=district))+
  geom_point(aes(y=Infant_Mortality))+
  ggtitle(paste("Range Of Infant_Mortality",as.character(min(plot_data$Infant_Mortality)),":",
                as.character(max(plot_data$Infant_Mortality))))+
  theme_classic()+
  theme(axis.text.x = element_text(angle = 90))
Infant_Mortality
# ploting together
Fertility_plot + Infant_Mortality
## as you can see the Infant mortaility is 3 time of Feritility
## we will create one plot with same x axis and two y axis. 
## Additionally, we will creare Infant mortaility as bar chart and 
## Feritility as Points

## lets begin

## Value for transforming infact mortaility to same scale as Fertility

coeff=3

ggplot(plot_data,aes(x=district))+
  geom_point(aes(y=Fertility),col="navy",size=3)+
  geom_bar(aes(y=Infant_Mortality*3),stat = "identity",alpha=0.5,col="black",
           fill="khaki4")+
  ## same scale transformation is requirement in the y axis too
  scale_y_continuous(name="Fertility % ",
                     sec.axis = sec_axis(~./3,name = "Infant Mortality %"))+
  theme_classic()+
  theme(axis.text.x = element_text(angle = 90))
