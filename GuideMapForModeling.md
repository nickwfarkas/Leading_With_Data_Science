# Data Understanding

## Questions to Ask:
1. Do you have enough data?
2. What kind of data in each feature (Categorical, Discrete, Continous, Mixed)?
3. Distribution of each feature?
4. Type of Prediction (Multiclass Classification, Binary Classification, Custering, Forcasting)

## Model Selection:

| Name | Input Data | General Use | Excels In| Bad At|
| ----------- | ----------- | ----------- | ----------- | ----------- |
| Logistic Regression | Continous/Categorical | Binary Classification | Low Dimensional Data | Multiclass/High Dimensional Data |
| Linear Regression | Continous/Categorical | Regression/Forcasting | Simple Models | Outliers/Data Quality/Underfit |
| KNN | Continous/Categorical | Multiclass Classification | Weirdly Distributed Data | High Dimensional Data/Large Data Sets/Performance |
| Neural Networks | Continous/Categorical | Multiclass/Binary Classification/Forcasting | High Dimension/Complex Data | Performance/Non-Normal/Overfitting |
| Naive Bayes | Continous/Categorical | Multiclass/Binary Classification | Small Training Data/Multiclass | Non-Normal/Dependant Data |

# Data Preprocessing

* Outliers (if data is 1.5 times the IQR)
   * Remove them
* Missing values
    * 
##