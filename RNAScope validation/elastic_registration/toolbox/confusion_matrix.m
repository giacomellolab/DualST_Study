function [sensitivity,specificity] = confusion_matrix(actual_Y,predicted_Y)
tp = sum((predicted_Y == 1) & (actual_Y == 1));
fp = sum((predicted_Y == 1) & (actual_Y == 0));
tn = sum((predicted_Y == 0) & (actual_Y == 1));
fn = sum((predicted_Y == 0) & (actual_Y == 0));
sensitivity = tp/(tp + fn);  %TPR
specificity = tn/(tn + fp);  %TNR
end