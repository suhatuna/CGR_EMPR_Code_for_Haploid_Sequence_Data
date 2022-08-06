function varNet = readKontrol( jj )

fileName = ['.\NewData\Control\Control-'  num2str(jj) '.txt'];

fileID = fopen(fileName, 'r');

A = textscan(fileID, '%s');
A = A{1};

varNet = cell(92, 1);
for i = 2 : 2 : 184
    varNet{i/2} = A{i};
end

fclose(fileID);

disp([num2str(jj) '. CONTROL network loaded!']);

end

