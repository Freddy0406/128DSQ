clc;
clear;
close all;

u = [1,1,1];        %Input u1,u2,u3
c = [1,1,1,1];      %Input c1,c2,c3,c4
x1 = zeros(1,4);
x2 = zeros(1,4);

x1(1) = bitand(bitxor(u(1),1),u(3));
x1(2) = bitxor(u(1),u(3));
x1(3) = c(1);
x1(4) = bitxor(c(1),c(2));
x2(1) = bitor((bitand(u(2),u(3))),bitand(u(1),bitxor(u(2),1)));
x2(2) = bitxor(u(2),u(3));
x2(3) = c(3);
x2(4) = bitxor(c(3),c(4));
x1 = x1(1)*8+x1(2)*4+x1(3)*2+x1(4);
x2 = x2(1)*8+x2(2)*4+x2(3)*2+x2(4);
y = zeros(2,1);
R = [1,1;-1,1];

y = mod(R*[x1;x2],16);

a1 = 2*y(1)-15;
a2 = 2*y(2)-15;
code = [a1,a2];



%% Demapping

x = zeros(4,2);

code = R\((code+15)./2)';


[y1,y2] = demapping(code);







%% Function

function [y1,y2] = demapping(code)







    






end














