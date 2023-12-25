clc;
clear;
close all;

u = input('Enter u1,u2,u3 with []: ');          %Input u1,u2,u3
c = input('Enter c1,c2,c3, c4 with []: ');      %Input c1,c2,c3,c4
original = cat(2,u,c);
fprintf('Original bits:');
disp(original);
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
fprintf('Step 1 result:x1 =');
disp(x1);
fprintf('\nx2 =');
disp(x2);


x1 = x1(1)*8+x1(2)*4+x1(3)*2+x1(4);
x2 = x2(1)*8+x2(2)*4+x2(3)*2+x2(4);

R = [1,1;-1,1];

y = mod(R*[x1;x2],16);
fprintf('Step 2 result:y =');
disp(y');

a1 = 2*y(1)-15;
a2 = 2*y(2)-15;
code = [a1,a2];
fprintf('\n16-PAM symbol:');
disp(code);

%% Demapping

code = R\((code+15)./2)';
[result] = soft_demapping(code);

fprintf('\nSoft-demapping result:');
disp(result);

%% Functions

function [y] = soft_demapping(code)  
    y(1) = llrb(mod(code(1),4));
    y(2) = llrb(mod(code(1)+1,4));
    y(3) = llrb(mod(code(2),4));
    y(4) = llrb(mod(code(2)+1,4));   
end


function [bit] = llrb(x)
    variance = 1;  
    sum1 = 0.0;
    sum2 = 0.0;
    for k = 0:7
        sum1 = sum1+exp(-(x-(4*k+0))^2/(2*variance))+exp(-(x-(4*k+1))^2/(2*variance));
        sum2 = sum2+exp(-(x-(4*k+2))^2/(2*variance))+exp(-(x-(4*k+3))^2/(2*variance));
    end
    sum_prob = log(sum1/sum2);

    if(sum_prob<0)
        bit = 1;
    else 
        bit = 0;
    end
end

