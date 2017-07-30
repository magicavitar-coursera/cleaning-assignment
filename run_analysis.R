library(data.table)
library(dplyr)

path = "UCI HAR Dataset/"

# Read the training feautures and labels
training_features <- fread(file=paste0(path, "train/X_train.txt"))
training_labels <- fread(file=paste0(path, "train/y_train.txt"))

# Read the test feautures and labels
test_features <- fread(file=paste0(path, "test/X_test.txt"))
test_labels <- fread(file=paste0(path, "test/y_test.txt"))

# Read the test subjects
training_subjects <- fread(file=paste0(path, "train/subject_train.txt"))
test_subjects <- fread(file=paste0(path, "test/subject_test.txt"))

# Combine training and test subjects
all_subjects <- rbind(training_subjects, test_subjects)

# Apply a descriptive column name
colnames(all_subjects) <- c("subject")

# Combine training and test features
all_features <- rbind(training_features, test_features)

# Read feature descriptons
feature_descriptions <- fread(paste0(path, "features.txt"), col.names = c("featureid","featuredescription"))
feature_descriptions <- unlist(feature_descriptions[,2])

# Apply descriptive column names to the features
colnames(all_features) <- feature_descriptions

# Read activity descriptons
activity_descriptions <- fread(paste0(path, "activity_labels.txt"), col.names = c("activity.id","activity.description"))

# Combine training and test labels
all_labels <- rbind(training_labels, test_labels)

# Apply proper column name to labels
colnames(all_labels) <- c("activity")

# Apply activity descriptions
all_labels$activity <- factor(all_labels$activity,activity_descriptions$activity.id,activity_descriptions$activity.description)
 
# Extract only standard deviation and mean columns
stddev_or_mean_col_ids <- grep("mean\\(\\)$|mean\\(\\)-[XYZ]$|std\\(\\)$|std\\(\\)-[XYZ]$",colnames(all_features))
all_mean_and_stddev_features <- subset(all_features,select=stddev_or_mean_col_ids)

# Build the complete dataset
complete_dataset <- cbind(all_subjects, all_labels, all_mean_and_stddev_features)

# Summarize the dataset, grouping by subject and activity and computing means for each variable
tidy_dataset <- complete_dataset %>%
  group_by(subject, activity) %>%
  summarise_all(mean)

# # Output the tidy dataset
write.csv(tidy_dataset, file = "tidy-dataset.txt",row.names=FALSE)