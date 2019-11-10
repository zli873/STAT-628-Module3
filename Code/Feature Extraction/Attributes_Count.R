library(VIM)
library(ggplot2)
library(RColorBrewer)
t1 <- t(data.frame(attribution,row.names=1))
t1 <- as.data.frame(t1)
for (i in 1 : 7913){
  if (t1[i, 69] == ' 2'){
    t1[i, 69] = 2
  }else if(t1[i, 69] == ' 3'){
    t1[i, 69] = 3
  }
} 

t1 <- t1[-c(4584, 5948), ]
t1[, 69] <- factor(t1$stars, levels = c(1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5))

p1 <- ggplot(data = t1, aes(x = stars, fill = HasTV)) + geom_histogram(stat = "count") + scale_fill_discrete(name="TV")
p1

t1$RestaurantsPriceRange2 <- factor(t1$RestaurantsPriceRange2, levels = c(1, 1.5, 2, 2.5, 3, 3.5, 4))
p2 <- ggplot(data = t1, aes(x = stars, fill = RestaurantsPriceRange2)) + geom_histogram(stat = "count") + scale_fill_discrete(name="Price")
p2


# Credits -----------------------------------------------------------------

credits1 <- t1[which(t1$BusinessAcceptsCreditCards == TRUE), ]
ggplot(data = credits1, aes(x = stars)) + geom_histogram(stat = "count")
credits0 <- t1[which(t1$BusinessAcceptsCreditCards == FALSE), ]
ggplot(data = credits0, aes(x = stars)) + geom_histogram(stat = "count")


# Music -------------------------------------------------------------------

dj <- t1[which(t1$dj == TRUE), ]
p_dj <- ggplot(data = dj, aes(x = stars)) + geom_histogram(stat = "count", fill = brewer.pal(7, "Set1")[2], width = 0.6) 
print(p_dj + ggtitle("DJ") + 
        theme(plot.title = element_text(hjust = 0.5, size = 18),
              axis.title = element_text(size=14)))

bm <- t1[which(t1$background_music == TRUE), ]
ggplot(data = bm, aes(x = stars)) + 
  geom_histogram(stat = "count", fill = brewer.pal(7, "Set1")[2], width = 0.6) + 
  ggtitle("Background Music") + 
  theme(plot.title = element_text(hjust = 0.5, size = 18),
        axis.title = element_text(size=14))

jukebox <- t1[which(t1$jukebox == TRUE), ]
ggplot(data = jukebox, aes(x = stars)) +
  geom_histogram(stat = "count", fill = brewer.pal(7, "Set1")[2], width = 0.6) +
  ggtitle("Jukebox") + 
  theme(plot.title = element_text(hjust = 0.5, size = 18),
        axis.title = element_text(size=14))

live <- t1[which(t1$live == TRUE), ]
ggplot(data = live, aes(x = stars)) + 
  geom_histogram(stat = "count", fill = brewer.pal(7, "Set1")[2], width = 0.6) + 
  ggtitle("Live") + 
  theme(plot.title = element_text(hjust = 0.5, size = 18),
        axis.title = element_text(size=14))

video <- t1[which(t1$video == TRUE), ]
ggplot(data = video, aes(x = stars)) + 
  geom_histogram(stat = "count",  fill = brewer.pal(7, "Set1")[2], width = 0.6) + 
  ggtitle("Video") + 
  theme(plot.title = element_text(hjust = 0.5, size = 18),
        axis.title = element_text(size=14))

karaoke <- t1[which(t1$karaoke == TRUE), ]
ggplot(data = karaoke, aes(x = stars)) + 
  geom_histogram(stat = "count",  fill = brewer.pal(7, "Set1")[2], width = 0.6) + 
  ggtitle("Karaoke") + 
  theme(plot.title = element_text(hjust = 0.5, size = 18),
        axis.title = element_text(size=14))


# HasTV -------------------------------------------------------------------

TV1 <- t1[which(t1$HasTV == TRUE), ]
TV0 <- t1[which(t1$HasTV == FALSE), ]
ggplot(data = TV1, aes(x = stars)) + 
  geom_histogram(stat = "count",  fill = brewer.pal(7, "Set1")[2], width = 0.6) + 
  ggtitle("Has TV") + 
  theme(plot.title = element_text(hjust = 0.5, size = 18),
        axis.title = element_text(size=16))

ggplot(data = TV0, aes(x = stars)) + 
  geom_histogram(stat = "count",  fill = brewer.pal(7, "Set1")[2], width = 0.6) + 
  ggtitle("Not has TV") + 
  theme(plot.title = element_text(hjust = 0.5, size = 18),
        axis.title = element_text(size=16))


# Price -------------------------------------------------------------------

price1 <- t1[which(t1$RestaurantsPriceRange2 == 1), ]
price2 <- t1[which(t1$RestaurantsPriceRange2 == 2), ]
price3 <- t1[which(t1$RestaurantsPriceRange2 == 3), ]
ggplot(data = price1, aes(x = stars)) + 
  geom_histogram(stat = "count",  fill = brewer.pal(7, "Set1")[2], width = 0.6) + 
  ggtitle("$") + 
  theme(plot.title = element_text(hjust = 0.5, size = 18),
        axis.title = element_text(size=16))
ggplot(data = price2, aes(x = stars)) + 
  geom_histogram(stat = "count",  fill = brewer.pal(7, "Set1")[2], width = 0.6) + 
  ggtitle("$$") + 
  theme(plot.title = element_text(hjust = 0.5, size = 18),
        axis.title = element_text(size=16))
ggplot(data = price3, aes(x = stars)) + 
  geom_histogram(stat = "count",  fill = brewer.pal(7, "Set1")[2], width = 0.6) + 
  ggtitle("$$$") + 
  theme(plot.title = element_text(hjust = 0.5, size = 18),
        axis.title = element_text(size=16))

# wifi -------------------------------------------------------------

wifi1 <- t1[which(t1$WiFi == "'free'"), ]
wifi0 <- t1[which(t1$WiFi == "'no'"), ]

ggplot(data = wifi1, aes(x = stars)) + 
  geom_histogram(stat = "count",  fill = brewer.pal(7, "Set1")[2], width = 0.6) + 
  ggtitle("Free Wifi") + 
  theme(plot.title = element_text(hjust = 0.5, size = 18))

ggplot(data = wifi0, aes(x = stars)) + 
  geom_histogram(stat = "count",  fill = brewer.pal(7, "Set1")[2], width = 0.6) + 
  ggtitle("No Wifi") + 
  theme(plot.title = element_text(hjust = 0.5, size = 18))


# outseating --------------------------------------------------------------

outseat1 <- t1[which(t1$OutdoorSeating == TRUE), ]
outseat0 <- t1[which(t1$OutdoorSeating == FALSE), ]
ggplot(data = outseat1, aes(x = stars)) + 
  geom_histogram(stat = "count",  fill = brewer.pal(7, "Set1")[2], width = 0.6) + 
  ggtitle("Has Outdoor Seating") + 
  theme(plot.title = element_text(hjust = 0.5, size = 18))

ggplot(data = outseat0, aes(x = stars)) + 
  geom_histogram(stat = "count",  fill = brewer.pal(7, "Set1")[2], width = 0.6) + 
  ggtitle("No Outdoor Seating") + 
  theme(plot.title = element_text(hjust = 0.5, size = 18))

# Happy hour --------------------------------------------------------------

Happyhour1 <- t1[which(t1$HappyHour == TRUE), ]
Happyhour0 <- t1[which(t1$HappyHour == FALSE), ]
ggplot(data = Happyhour1, aes(x = stars)) + 
  geom_histogram(stat = "count",  fill = brewer.pal(7, "Set1")[2], width = 0.6) + 
  ggtitle("No Outdoor Seating") + 
  theme(plot.title = element_text(hjust = 0.5, size = 18))
ggplot(data = Happyhour0, aes(x = stars)) + 
  geom_histogram(stat = "count",  fill = brewer.pal(7, "Set1")[2], width = 0.6) + 
  ggtitle("No Outdoor Seating") + 
  theme(plot.title = element_text(hjust = 0.5, size = 18))









