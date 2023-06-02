function print_to_xlsx(config, file_name)


M = size(config,1);
threeN = size(config,2);
N = threeN/3;

points_name = {};
for i = 1 : N
    points_name{end+1} = ['x',num2str(i),'@holes'];
    points_name{end+1} = ['y',num2str(i),'@holes'];
end
for i = 1 : N
    points_name{end+1} = ['$prp@length',num2str(i)];
end
points_name{end+1} = '$prp@id';

xlswrite([file_name,'.xlsx'], points_name, 1, 'B1')
xlswrite([file_name,'.xlsx'], (1:M)', 1, 'A2')

idx = [];
for i = 1 : threeN
    if mod(i,3)~=0
        idx = [idx,i];
    end
end

xlswrite([file_name,'.xlsx'], config, 1, 'B2')
xlswrite([file_name,'.xlsx'], (1:M)', 1, xlsrange(2,2+N*3))


end