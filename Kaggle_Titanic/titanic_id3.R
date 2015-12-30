# Original: Tutorial from Datacamp
# Modified and improved by Emma
# Version 2. Updated on 22/12/2015

# Install packages:
# install.packages("randomForest")

#Load in the package
library(randomForest)


# Assign the training set
train <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/course/Kaggle/train.csv")

# Assign the testing set
test <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/course/Kaggle/test.csv")

# train and test are available in the workspace
str(train)
str(test)

# All data, both training and test set
test <- as.data.frame(append(test, list(Survived = NA), after = 1))
all_data <- rbind(train,test)

## ID3 IMPLEMENTATION ###

#########################


# Create a data frame with two columns: PassengerId & Survived. Survived contains your predictions
my_solution <- data.frame(PassengerId = test$PassengerId, Survived = my_prediction)

# Write your solution away to a csv file with the name my_solution.csv
write.csv(my_solution, file = "my_solution.csv", row.names = FALSE)
