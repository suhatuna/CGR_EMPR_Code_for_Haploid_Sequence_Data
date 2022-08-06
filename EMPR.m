function [h1, h2, h3] = EMPR(H, w1, w2, w3)

%% Dimensions
[rows, cols, bands] = size(H);

%% 1st support vector: s1
SS1 = zeros(rows, 1);
for i = 1 : rows
    for j = 1 : cols
        for k = 1 : bands
            SS1(i) = SS1(i) + H(i, j, k) * w2(j) * w3(k);
        end
    end
end

normSS1 = 0;
for i = 1 : rows
    normSS1 = normSS1 + SS1(i) * SS1(i) * w1(i);
end
s1 = SS1 / sqrt( normSS1 );
    
%% 2nd support vector: s2
SS2 = zeros(cols, 1);
for j = 1 : cols
    for i = 1 : rows
        for k = 1 : bands
            SS2(j) = SS2(j) + H(i, j, k) * w1(i) * w3(k);
        end
    end
end

normSS2 = 0;
for j = 1 : cols
    normSS2 = normSS2 + SS2(j) * SS2(j) * w2(j);
end
s2 = SS2 / sqrt( normSS2 );

%% 3rd support vector: s3
SS3 = zeros(bands, 1);
for k = 1 : bands    
    for j = 1 : cols
        for i = 1 : rows
            SS3(k) = SS3(k) + H(i, j, k) * w1(i) * w2(j);
        end
    end
end

normSS3 = 0;
for k = 1 : bands
    normSS3 = normSS3 + SS3(k) * SS3(k) * w3(k);
end
s3 = SS3 / sqrt( normSS3 );

%% Constant term: h0
h0 = 0;
for i = 1 : rows
    for j = 1 : cols
        for k = 1 : bands
            h0 = h0 + H(i, j, k) * s1(i) * s2(j) * s3(k) * w1(i);
        end
    end
end

%% 1st one-way term: h1
h1 = zeros(rows, 1);
for i = 1 : rows
    for j = 1 : cols
        for k = 1 : bands
            h1(i) = h1(i) + H(i, j, k) * s2(j) * s3(k) * w2(j) * w3(k);
        end
    end
end
h1 = h1 - h0 * s1;

%% 2nd one-way term: h2
h2 = zeros(cols, 1);
for j = 1 : cols
    for i = 1 : rows
        for k = 1 : bands
            h2(j) = h2(j) + H(i, j, k) * s1(i) * s3(k) * w1(i) * w3(k);
        end
    end
end
h2 = h2 - h0 * s2;

%% 3rd one-way term: h3
h3 = zeros(bands, 1);
for k = 1 : bands
    for i = 1 : rows
        for j = 1 : cols
            h3(k) = h3(k) + H(i, j, k) * s1(i) * s2(j) * w1(i) * w2(j);
        end
    end
end
h3 = h3 - h0 * s3;
                
end