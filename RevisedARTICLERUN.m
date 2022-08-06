%%
clear;  clc;  close all;

%% parameters
N = 400;           % # of networks
SCALE = 700;       % CGR image size
% S = 10;            % # of training samples per class
NUMTRIALS = 50;    % # of classification attempts per experiment

%% load EMPR components of control and patient network cubes (feature extraction phase)
load('./Features/hasta_features_mTOR.mat');
load('./Features/kontrol_features_mTOR.mat');

%% computation
tic;
for S = 10 : 10 : 50 % # of training samples for each class

% initialize result arrays    
eval(['SVM_OA_' num2str(S) '      = zeros(1, NUMTRIALS);']);
eval(['CV_acc_' num2str(S) '      = zeros(1, NUMTRIALS);']);
eval(['Acc_Pos_' num2str(S) '     = zeros(1, NUMTRIALS);']);
eval(['Acc_Neg_' num2str(S) '     = zeros(1, NUMTRIALS);']);
eval(['OA_' num2str(S) '          = zeros(1, NUMTRIALS);']);
eval(['MCC_' num2str(S) '         = zeros(1, NUMTRIALS);']); 
eval(['accuracy_' num2str(S) '    = zeros(1, NUMTRIALS);']);
eval(['precision_' num2str(S) '   = zeros(1, NUMTRIALS);']);
eval(['recall_' num2str(S) '      = zeros(1, NUMTRIALS);']);
eval(['F1_' num2str(S) '          = zeros(1, NUMTRIALS);']);
eval(['sensitivity_' num2str(S) ' = zeros(1, NUMTRIALS);']);
eval(['specificity_' num2str(S) ' = zeros(1, NUMTRIALS);']);
eval(['X_' num2str(S) '           = zeros(3, NUMTRIALS);']);
eval(['Y_' num2str(S) '           = zeros(3, NUMTRIALS);']);
eval(['AUC_' num2str(S) '         = zeros(1, NUMTRIALS);']);     
    
for tt = 1 : NUMTRIALS % # of trials for each experiment    
    
%% splitting the data as train and test sets
% training indices
indTraControl = sort( randperm(N, S) );
indTraPatient = sort( randperm(N, S) );

% testing indices
indTesControl = 1 : N;  indTesControl(indTraControl) = [];
indTesPatient = 1 : N;  indTesPatient(indTraPatient) = [];

% training labels (Control --> 0, Patient --> 1)
labTra = [ zeros(1, length(indTraControl)) ones(1, length(indTraPatient)) ];

% testing labels (Control --> 0, Patient --> 1)
labTes = [ zeros(1, length(indTesControl)) ones(1, length(indTesPatient)) ];

%% construct training data via f = [h1; h2; h3] features
dataTra = zeros( 2*SCALE+31, length(indTraControl) +  length(indTraPatient));
cnt = 0;
for i = indTraControl
   cnt = cnt + 1;
   dataTra(:, cnt) = [kontrolEMPRComps{i, 1}; kontrolEMPRComps{i, 2}; kontrolEMPRComps{i, 3}]; 
end

for i = indTraPatient
   cnt = cnt + 1;
   dataTra(:, cnt) = [hastaEMPRComps{i, 1}; hastaEMPRComps{i, 2}; hastaEMPRComps{i, 3}];  
end

%% construct testing data via f = [h1; h2; h3] features
dataTes = zeros( 2*SCALE+31, length(indTesControl) + length(indTesPatient) );
cnt = 0;
for i = indTesControl
   cnt = cnt + 1;
   dataTes(:, cnt) = [kontrolEMPRComps{i, 1}; kontrolEMPRComps{i, 2}; kontrolEMPRComps{i, 3}];
end

for i = indTesPatient
   cnt = cnt + 1;
   dataTes(:, cnt) = [hastaEMPRComps{i, 1}; hastaEMPRComps{i, 2}; hastaEMPRComps{i, 3}];  
end

%% SVM classification
[predicted, CV_results, SVM_OA(tt)] = performSVM(dataTra, dataTes, labTra, labTes);
CV_acc(tt) = max(CV_results(:));

%% Metrics
[Acc_Pos(tt), Acc_Neg(tt), OA(tt), MCC(tt), accuracy(tt), precision(tt), ...
    recall(tt), F1(tt), sensitivity(tt), specificity(tt), X(:,tt), Y(:,tt), ...
    T, AUC(tt)] = calculateMetrics(labTes, predicted);

end % end of tt
eval(['SVM_OA_' num2str(S) ' = SVM_OA']);
eval(['CV_acc_' num2str(S) ' = CV_acc']);
eval(['Acc_Pos_' num2str(S) ' = Acc_Pos']);
eval(['Acc_Neg_' num2str(S) ' = Acc_Neg']);
eval(['OA_' num2str(S) ' = OA']);
eval(['MCC_' num2str(S) ' = MCC']);
eval(['accuracy_' num2str(S) ' = accuracy']);
eval(['precision_' num2str(S) ' = precision']);
eval(['recall_' num2str(S) ' = recall']);
eval(['F1_' num2str(S) ' = F1']);
eval(['sensitivity_' num2str(S) ' = sensitivity']);
eval(['specificity_' num2str(S) ' = specificity']);
eval(['X_' num2str(S) ' = X']);
eval(['Y_' num2str(S) ' = Y']);
eval(['AUC_' num2str(S) ' = AUC']);

% save result arrays
save(['SVM_OA_' num2str(S) '.mat'], ['SVM_OA_' num2str(S)]);
save(['CV_acc_' num2str(S) '.mat'], ['CV_acc_' num2str(S)]);
save(['Acc_Pos_' num2str(S) '.mat'], ['Acc_Pos_' num2str(S)]);
save(['Acc_Neg_' num2str(S) '.mat'], ['Acc_Neg_' num2str(S)]);
save(['OA_' num2str(S) '.mat'], ['OA_' num2str(S)]);
save(['MCC_' num2str(S) '.mat'], ['MCC_' num2str(S)]);
save(['accuracy_' num2str(S) '.mat'], ['accuracy_' num2str(S)]);
save(['precision_' num2str(S) '.mat'], ['precision_' num2str(S)]);
save(['recall_' num2str(S) '.mat'], ['recall_' num2str(S)]);
save(['F1_' num2str(S) '.mat'], ['F1_' num2str(S)]);
save(['sensitivity_' num2str(S) '.mat'], ['sensitivity_' num2str(S)]);
save(['specificity_' num2str(S) '.mat'], ['specificity_' num2str(S)]);
save(['X_' num2str(S) '.mat'], ['X_' num2str(S)]);
save(['Y_' num2str(S) '.mat'], ['Y_' num2str(S)]);
save(['AUC_' num2str(S) '.mat'], ['AUC_' num2str(S)]);

end % end of S
elapsed = toc;

%% 