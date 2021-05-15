#libraries
library(tidyverse)
library(rpart)
library(C50)
library(caret)

#data import
bucks_df <- read.csv("~/Git/NBA_Rest/data/bucks_16_20_rest_dist.csv"
                             , stringsAsFactors = T)

bucks_df <- bucks_df[,-c(1,8)]
#CART model
#CART fit
cartfit <- rpart(results ~ locations + rest + game_nums + 
                   opponent + travel_miles,
                 data = bucks_df,
                 method = "class")

#cart eval
summary(cartfit)

eval_cart <- predict(cartfit, bucks_df, type = "class")

cart_cm <- confusionMatrix(eval_cart,bucks_df$results)

cart_cm

# #c50 model
# #putting variables in x and y 
# x <- bucks_df[,c(3,4,5,7,9)]
# y <- bucks_df$results
# 
# #c50 fit
# c50fit <-C5.0(x,y)
# 
# #c50 eval
# 
# eval_c50 <- predict(c50fit, bucks_df, type = "class")
# 
# c50_cm <- confusionMatrix(eval_c50,bucks_df$results)
# 
# c50_cm

#neural net

dmy <- dummyVars(" ~ .", data = bucks_df)
nn_df <- data.frame(predict(dmy, newdata = bucks_df))

#train nn

NN_fit <- neuralnet(formula = results.Win ~ locations.Away + locations.Home + 
                      rest + game_nums + date_diff + opponent.ATL + 
                      opponent.BOS + opponent.BRK + opponent.CHI + opponent.CHO +
                      opponent.CLE + opponent.DAL + opponent.DEN + opponent.DET +
                      opponent.GSW + opponent.HOU + opponent.IND + opponent.LAC +
                      opponent.LAL + opponent.MEM + opponent.MIA + opponent.MIN +
                      opponent.NOP + opponent.NYK + opponent.OKC + opponent.ORL +
                      opponent.PHI + opponent.PHO + opponent.POR + opponent.SAC +
                      opponent.SAS + opponent.TOR + opponent.UTA + opponent.WAS +
                      travel_miles,
                   data = nn_df, rep = 2, hidden = 2, linear.output = F)

#predicting wins (wins are 1s losses are 0s)
nn_df_test <- nn_df[,-c(1,2)]

nn_pred <- predict(NN_fit, nn_df_test, type = "class")

nn_pred[nn_pred < 0.7] <- 0 

nn_pred[nn_pred >= 0.7] <- 1

nn_cm <- confusionMatrix(as.factor(nn_pred), as.factor(nn_df$results.Win))

nn_cm
