folder = '../submission/W';
file = [84,601,745];

for i=1:3
    figure;
    for j=1:20
        im = imread([folder,num2str(file(i)),'/P',num2str(j),'.png']);
        subplot(4,5,j); imshow(im);
    end
    saveas(i, ['../submission/vocabulary',num2str(i),'.png'],'png');
end

