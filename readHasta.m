function varNet = readHasta( jj )

fileName = ['.\NewData\Patient\Patient-'  num2str(jj) '.txt'];

fileID = fopen(fileName, 'r');

A = textscan(fileID, '%s');
A = A{1};

varNet = cell(31, 1);
for i = 2 : 2 : 62
    varNet{i/2} = A{i};
end

fclose(fileID);

disp([num2str(jj) '. PATIENT network loaded!']);

end

