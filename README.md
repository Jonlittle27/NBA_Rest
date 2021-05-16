# NBA Prediction Models <img align="right" width="75" height="155" src="https://cdn.freebiesupply.com/images/large/2x/nba-logo-transparent.png">


Predicts NBA Game Outcomes using Random Forest Classifier and Logistic Regression

#Execution

The code in the notebooks is completely reproducible and mutliple consistent seeds were set.  In order to run the notebooks externally, I suggest installing the sportsreference API first then proceeding to the preparation notebooks.  In here the test and training files can both be run from the start as a whole kernel respectively.  After these are executed, two csv files will populate in a data folder, this can be renamed according to your liking.  

From there the model file can be executed, which will import the training data first, process it, and then perform training runs of the models to test accuracy prior to seeing any new data.  Then both the training and test  data (the unseen 2019 dataset) will be reloaded.  The model will now be created on the entirety of the training data, as opposed to using a train test split, and predict based on the unseen data's information.  Luckily the new data does come with the actual values since the 2019 season has been completed and accuracy scores can be obtained.