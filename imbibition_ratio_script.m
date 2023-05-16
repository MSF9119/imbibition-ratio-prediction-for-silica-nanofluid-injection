% Coded by @MSF9119

% This projects reads 22 sample datapoints (that include inbibition ratios
% for 22 rock samples), developes a ML model on it to predict values ratios
% at t = infinity from values at t = 20 mins. It performs two functions:
% mode 1: predict values at infinity from values at t = 20
% mode 2: same function as above, but it also lets you know if your stone 
% sample is suited for silica nanofluid injection  

% Extract datapoints from the dataset (the file must be in the same folder
% as the code. We are using my dataset that I obtained from my experiment
data = readtable('imbibition_dataset.csv');

% Extract columns A, B, D, and E
% Column A: Imbibition ratio of stone sample for water injection at t =20m
% Column B: Imbibition ratio of stone sample for silica injection at t =20m
% Column C: Imbibition ratio of stone sample for water injection at
% infinity
% Column D: Imbibition ratio of stone sample for silica injection at
% infinity
inputs = data(:, {'A', 'B'});
outputs = data(:, {'D', 'E'});

% We then convert tables to arrays for processing
inputs = table2array(inputs);
outputs = table2array(outputs);

% We segment the dataset into both training and testing sets (80 - 20)
rng('default'); % For reproducibility
cv = cvpartition(size(inputs, 1), 'HoldOut', 0.2);
idx = cv.test;


X_train = inputs(~idx, :);
Y_train = outputs(~idx, :);
X_test = inputs(idx, :);
Y_test = outputs(idx, :);

% Now, we train the model (using SVM regression - best result)
mdl_water = fitrsvm(X_train, Y_train(:, 1));
mdl_silica = fitrsvm(X_train, Y_train(:, 2));

% Finally, we can  outputs for the test set
Y_pred_water = predict(mdl_water, X_test);
Y_pred_silica = predict(mdl_silica, X_test);

% For statistics: we calculate the performance metrics and display it
% (mean squared root)
mse_water = immse(Y_pred_water, Y_test(:, 1));
mse_silica = immse(Y_pred_silica, Y_test(:, 2));

fprintf('The mean squared error for water-injection predictions is: %f\n', mse_water);
fprintf('The mean squared error for silica nanofluid injection predictions is: %f\n', mse_silica);

% Now that the model is created, we ask the user to choose a mode:
mode = input(['Choose a mode (1: Predict Imbibition Ratios at t = infinity from experimental data obtained during shortterm experimentation,' ...
    ' 2: Check stone sample suitability for silica nanofluid injection): ']);

% Mode 1: Predict Imbibition Ratios at t = infinity
if mode == 1
    % We first ask the user for input parameters (their own experimental
    % data for t = 20mins or shortere
    user_input = input('Please enter your two input parameters (Shortterm Experimental Imbibition ratios for water and silica nanofluid injectio) separated by a space: ', 's');
    user_input = str2num(user_input);

    % Use the model to predict the outputs for the user input
    user_pred_water = predict(mdl_water, user_input);
    user_pred_silica = predict(mdl_silica, user_input);

    % Display the predicted outputs
    fprintf('The predicted water-injected imbibition ratio after a long time (D) is: %f\n', user_pred_water);
    fprintf('The predicted silica-injected imbibition ratio after a long time (E) is: %f\n', user_pred_silica);
    
    % Mode 2: Check suitability for silica injection
elseif mode == 2
    % We request that the user provides input data
    user_input = input('Please enter your two input parameters (Shortterm Experimental Imbibition ratios for water and silica nanofluid injectio) separated by a space: ', 's');
    user_input = str2num(user_input);

    % Use the model to predict the outputs for the user input
    user_pred_water = predict(mdl_water, user_input);
    user_pred_silica = predict(mdl_silica, user_input);

    % Check if the stone sample is suitable for silica nanofluid injection
    if user_pred_silica > user_pred_water
        fprintf('The stone sample is SUITABLE for silica injection!\n');
    else
        fprintf('The stone sample is NOT suitable for silica injection!\n');
    end
    
    % Display the predicted outputs
    fprintf('The predicted water-injected imbibition ratio after a long time is: %f\n', user_pred_water);
    fprintf('The predicted silica-injected imbibition ratio after a long time is: %f\n', user_pred_silica);
    
else
    fprintf('Unsupported mode selected. Please choose either mode 1 or 2.\n');
end

% Finally, we would like to just show the actual vs predicted values plot
% for both of our predictions
% For water-injected:
figure;
scatter(Y_test(:, 1), Y_pred_water);
hold on;
plot([min(Y_test(:, 1)), max(Y_test(:, 1))], [min(Y_test(:, 1)), max(Y_test(:, 1))], 'r');
xlabel('Actual Water-injected Imbibition Ratio');
ylabel('Predicted Water-injected Imbibition Ratio');
title('Actual vs. Predicted Values for Water-injected Imbibition Ratio');
grid on;

%For silica nanofluid injection:
figure;
scatter(Y_test(:, 2), Y_pred_silica);
hold on;
plot([min(Y_test(:, 2)), max(Y_test(:, 2))], [min(Y_test(:, 2)), max(Y_test(:, 2))], 'r');
xlabel('Actual Silica-injected Imbibition Ratio');
ylabel('Predicted Silica-injected Imbibition Ratio ');
title('Actual vs. Predicted Values for Silica-injected Imbibition Ratio');
grid on;