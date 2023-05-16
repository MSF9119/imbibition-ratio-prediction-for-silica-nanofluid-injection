# imbibition-ratio-prediction-for-silica-nanofluid-injection
A simple MATLAB Machine Learning Script that uses a small dataset of experimental data and enables users to either: 1) Predict Imbibition Ratios 2)Find out if their specific stone sample is suitable for Silica Nanofluid Injection.

CONTEXT:
Petroleum Engineering
Reservoir Engineering

1.0 PROJECT DESCRIPTION:
This projects acts only as a proof of concept since it only works with 22 datapoints that I obtained during my own experiment. Considering the fact that the number of datapoints is relatively low for a Machine Learning model, and also obtaining such data for a single individual is expensive (stone sample are quite expensive, not to mention the lack of access to proper instruments for obtaining the data), this project acts more as a proof of concept for scientists or companies to use in the process of Reservoir Engineering

1.1. Experimental Data
The experimental used in this project was obtained through my Masters Thesis Research. I obtained Water-Injection and Silica Nanofluid-Injection Imbibition ratios for 22 stone samples at both shortterm (t = 20 mins) and longterm ( t = infinity). The data set has for columns:
% Column A: Imbibition ratio of stone sample for water injection at t =20m
% Column B: Imbibition ratio of stone sample for silica injection at t =20m
% Column C: Imbibition ratio of stone sample for water injection at infinity
% Column D: Imbibition ratio of stone sample for silica injection atinfinity

1.2. Script
The script reads 22 sample datapoints, developes a ML model on it to predict values ratios
at t = infinity from values at t = 20 mins. It performs two functions:

% mode 1: predict values at infinity from values at t = 20mins
% mode 2: same function as above, but it also lets you know if your stone sample is suited for silica nanofluid injection

1.3. Prediction Model:
Using a SVM (Support Vector Machine) Regression model to perform the predictions. The dataset is divided into %80 Training set and %20 Test set

2.0. TO RUN THE SCRIPT:
1- Create a new empty folder.
2- Download and put the dataset labeled "imbibition_dataset.csv" inside the folder.
3- Download and put the MATLAB code inside the same folder.
4- Run the script using MATLAB (tested on MATLAB 2022b)

3.0. USING THE SCRIPT:
To use the script, you can either type in '1' or '2' to choose your preferred mode.

*If you choose mode 1, you must input your own shortterm experimental Imbibition Ratio for both water and Silica nanofluid injected stone sample respectively. The model will let you know what Imbibition values you can expect at longterm (t = infinity)

*If you choose mode 2, you must input your own shortterm experimental Imbibition Ratio for both water and Silica nanofluid injected stone sample respectively. The model will let you know what Imbibition values you can expect at longterm (t = infinity) and will also let you know if your specific stone sample is suited for Silica Nanofluid injection.
