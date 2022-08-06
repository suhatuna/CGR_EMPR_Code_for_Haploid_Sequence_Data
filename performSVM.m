function [predictedLabels, CV, oa, probs] = performSVM(dataTra, dataTes, labTra, labTes)

% normalisation 
[n1, ~] = size(dataTra);
for k = 1 : n1
    min_val(k) = min( dataTra(k, :) );
    max_val(k) = max( dataTra(k, :) );
    if ( max_val(k) == min_val(k) )
        Mnorm_tra(k,:) = zeros( 1, length( indTra ) );
        Mnorm_tes(k,:) = zeros( 1, length( indTes ) );
    else
        Mnorm_tra(k,:) = dataTra(k,:) - min_val(k);
        Mnorm_tra(k,:) = Mnorm_tra(k,:) ./ (max_val(k)-min_val(k));
        Mnorm_tra(k,:) = 2*(Mnorm_tra(k,:) - 0.5);
        Mnorm_tes(k,:) = dataTes(k,:) - min_val(k);
        Mnorm_tes(k,:) = Mnorm_tes(k,:) ./ (max_val(k)-min_val(k)); 
        Mnorm_tes(k,:) = 2*(Mnorm_tes(k,:) - 0.5);
    end
end

% grid search + cross-validation
kernel='-t 2 '; % rbf kernel
base = 10;   
bestcv = 0; % for grid search
for ig = 1 : 9 % gamma parameters values (rows from 0.0001 to 10000)
    logbaseg = (ig - 5);
    for ic = 1 : 9   % c parameters values (columns from 0.0001 to 10000) 
        logbasec = (ic - 5);
        % cross-validation (5 fold= -v 5)
        cmd = [kernel, '-v 5 -c ', num2str(base^logbasec), ' -g ', num2str(base^logbaseg)];
        cv = svmtrain(labTra', Mnorm_tra', cmd);
        CV(ig,ic) = cv;   % grid searh matrix
        if(cv >= bestcv) 
            bestcv = cv; bestc = base^logbasec; bestg = base^logbaseg;
        end
    end
end
    
% training with optimised parameter gamma and c
cmd = [kernel,' -c ' num2str(bestc) ' -g ' num2str(bestg) ' -b 1'];
model = svmtrain(labTra', Mnorm_tra', cmd);
    
% testing
[predictedLabels, accuracy, probs] = svmpredict(labTes', Mnorm_tes', model);
   
% showing results
oa = accuracy(1); % result

end

