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

# Passenger on row 62 and 830 do not have a value for embarkment. 
# Since many passengers embarked at Southampton, we give them the value S.
# We code all embarkment codes as factors.
all_data$Embarked[c(62,830)] = "S"
#all_data$Embarked <- factor(combi$Embarked)

# Passenger on row 1044 has an NA Fare value. Let's replace it with the median fare value.
all_data$Fare[1044] <- median(all_data$Fare, na.rm=TRUE)

# How to fill in missing Age values?
# We make a prediction of a passengers Age using the other variables and a decision tree model. 
# This time you give method="anova" since you are predicting a continuous variable.
predicted_age <- rpart(Age ~ Pclass + Sex + SibSp + Parch + Fare + Embarked + Title + family_size,
                       data=all_data[!is.na(all_data$Age),], method="anova")
all_data$Age[is.na(all_data$Age)] <- predict(predicted_age, all_data[is.na(all_data$Age),])

# Split the data back into a train set and a test set
train <- all_data[1:891,]
test <- all_data[892:1309,]


# Set seed for reproducibility
set.seed(111)

# Apply the Random Forest Algorithm
my_forest <- randomForest(as.factor(train$Survived) ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked, data = train, ntree = 1000, importance = TRUE)

# Make your prediction using the test set
my_prediction <- predict(my_forest, test)

# Create a data frame with two columns: PassengerId & Survived. Survived contains your predictions
my_solution <- data.frame(PassengerId = test$PassengerId, Survived = my_prediction)

# Write your solution away to a csv file with the name my_solution.csv
write.csv(my_solution, file = "my_solution.csv", row.names = FALSE)
