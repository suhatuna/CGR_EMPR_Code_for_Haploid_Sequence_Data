function C = net2Cube(net, SCALE, pixVal)

n = length( net );
C = zeros(SCALE, SCALE, 31);
for i = 1 : n
   C(:, :, i) = CGR2Matrix( net{i}, SCALE, pixVal );
end

end

