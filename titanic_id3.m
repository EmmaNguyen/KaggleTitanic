%% Initialization
clear ; close all; clc



fileID = fopen('train.csb','w');
fprintf(fileID,'%4.4f\n',x);
fclose(fileID);
