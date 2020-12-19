#libraries
library(tidyverse)
library(rpart)
library(C50)
library(caret)

#data import
bucks_16_20_rest <- read.csv("~/Git/NBA_Rest/data/bucks_16_20_rest.csv"
                             , stringsAsFactors = T)
#CART model

#CART fit
cartfit <- rpart(results ~ locations + rest + game_nums,
                 data = bucks_16_20_rest,
                 method = "class")

summary(cartfit)

#c50 model
#putting variables in x and y 
x <- bucks_16_20_rest[,c(3,4,6)]
y <- bucks_16_20_rest$results

#c50 fit
c50fit <-C5.0(x,y)

#c50 eval

eval_c50 <- predict(c50fit, bucks_16_20_rest, type = "class")

c50_cm <- confusionMatrix(eval_c50,bucks_16_20_rest$results)
summary(c50fit)
#evalaute
#cart eval
eval_cart <- predict(cartfit, bucks_16_20_rest, type = "class")

cart_cm <- confusionMatrix(eval_cart,bucks_16_20_rest$results)
#neural net?