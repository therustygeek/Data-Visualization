#install.packages("devtools")
#devtools::install_github("thomasp85/patchwork", force = TRUE) #installing parchwork library

#install.packages("magrittr") # only needed the first time you use it
#install.packages("dplyr")    # alternative installation of the %>%
library(magrittr) # need to run every time you start R and want to use %>%
library(dplyr)    # alternative, this also loads %>%
library(HistData)
library(lubridate)
library(tidyverse)
library(ggrepel)
library(ggmap)
library(patchwork)
library(extrafont)
library(pander)
library(gridExtra)
        
##loading fonts

loadfonts()
data("Minard.cities")
data("Minard.temp")
data("Minard.troops")

print(Minard.temp)
print(Minard.cities)


Minard.temp1 <- data.frame(long=rev(Minard.temp$long),
                           lat=c(54.4,54.3,54.4,54.1,54.2,54.6,54.8,55.2,55.7))

Minard.temp <-Minard.temp %>% 
  mutate(date = as.character(date)) %>% 
  mutate(date = format(as.Date(date,format = "%b%d"), "%B %d")) %>% 
  mutate(date = ifelse(is.na(date),"",date)) 

#area of map which would be used
march.1812.ne.europe <- c(left = 23.5, bottom = 53.4, right = 38.1, top = 56.3)

##Using Stamen Maps because OpenStreet project retricts ggmap to use the API

march.1812.ne.europe.map <- get_stamenmap(bbox = march.1812.ne.europe, zoom = 8,
                                          maptype = "terrain-background", where = "cache")
##plot1 depicts the route taken by the army
plot_1 <- ggplot()+ ggmap(march.1812.ne.europe.map) +
  geom_segment(data=Minard.temp1,aes(x=long,y=lat,xend=long,yend=53.2),size=0.2)+
  geom_path(data=Minard.troops,aes(x=long,y=lat,size=survivors,col=direction,group=group),
            lineend = "round", linejoin = "round")+
  scale_x_continuous(limits=c(24,38),name="")+
  scale_y_continuous(limits=c(53.2,56),name="")+
  scale_color_manual(values=c("#D7C181","#424242"))+
  scale_size(range=c(1,10),breaks = c(1e5,2e5,3e5))+
  geom_text_repel(data=Minard.cities,aes(long,lat,label=city),segment.alpha = 0,
                  family = "EB Garamond 08",
                  size=ifelse(Minard.cities$city=="Moscou",8,4),
                  nudge_x = ifelse(Minard.cities$city=="Moscou",2,0),
                  nudge_y = ifelse(Minard.cities$city=="Moscou",2,0)) +
  theme(panel.background = element_blank(),
        axis.ticks = element_blank(),
        axis.text = element_blank(),
        panel.grid = element_blank(),
        legend.position = "none",
        plot.margin=unit(c(0,0,-0.7,0),"cm")
  )

plot_1

##Temperature and the days of retreat
plot_2 <- ggplot(Minard.temp,aes(x=long,y=temp,label=paste0(temp,"° ",date))) +
  geom_line()+
  geom_text(family = "EB Garamond 08",size=2,vjust=1,hjust=c(rep(0,8),1))+
  scale_x_continuous(limits=c(24,38),name="")+
  scale_y_continuous(limits=c(-31.5,0),position = "right",name="")+
  labs(caption="temperature in degrees below zero of the Réaumur thermometer")+
  theme(panel.background = element_blank(),
        axis.ticks = element_blank(),
        axis.text.x = element_blank(),
        axis.text.y = element_text(family = "EB Garamond 08"),
        panel.grid.major.y = element_line(color="black",size=0.1),
        panel.grid.major.x = element_blank(),
        panel.grid.minor = element_blank(),
        plot.margin = unit(c(0,0,0,0),"cm"),
        plot.caption = element_text(hjust=0.5,size=9,family="EB Garamond 08")
  )+geom_segment(aes(xend=long,yend=0),size=0.2)
  
plot_2
##Describing the plot
descr <- expression(paste("Figurative Map", scriptstyle(" of losses in Napoleon's Army.")))

##combining the two plots
final_plot <- plot_1+plot_2+ plot_layout(ncol = 1, heights = c(3, 1))+
  plot_annotation(title=descr,
                  subtitle = "Drawn by Charles Minard, Inspector General of Bridges and Roads (retired). Paris, November 20, 1869.",
                  caption = "redrawn by Shubham",
                  theme = theme(plot.title=element_text(family="EB Garamond 08",size=20,face = "italic"),
                                plot.subtitle = element_text(family="EB Garamond 08",size=10,hjust = 0.5),
                                plot.caption = element_text(family="EB Garamond 08",colour="grey")))
final_plot
ggsave("napoleon2.png",final_plot,width=12,height=5.8) #Saves as a png file

