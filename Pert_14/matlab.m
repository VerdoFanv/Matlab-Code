clc;
clear;
close all;

x = [5,8,9,12,17];
y = [9,22,34,55,77];

init(x, y);

function init(x, y)
    n = polyfit(x, y, 1);
    newX = 7;
    prediksiY = polyval(n, newX);
    garisRegresi = polyval(n, x);
    
    a = n(1, 2);
    b = n(1, 1);
    
    intersep(x, y);
    slope(x, y);
    fprintf("\n");
    fprintf("Persamaan Y = %.3f + %.3fX\n", a, b);
    fprintf("Jika X = %g, maka hasil akhirnya: %.3f\n", newX, prediksiY);
    
    plot(x, y, 'O', newX, prediksiY, 'r*')
    hold on
    plot(x, garisRegresi, 'b-')
    title('Regresi Linier')
    xlabel('x')
    ylabel('y')
    grid on
end

function intersep(dataX, dataY)
    xSum = sum(dataX);
    ySum = sum(dataY);
    xKSum = sum(dataX.^2);
    x_ySum = sum(dataX.*dataY);
    n = numel(dataX);
    
    top = (ySum * xKSum) - (xSum * x_ySum);
    btm = (n * xKSum) - xSum^2;
    
    res = top / btm;
    
    fprintf("Intersept a: %.3f\n", res);
end

function slope(dataX, dataY)
    xSum = sum(dataX);
    ySum = sum(dataY);
    xKSum = sum(dataX.^2);
    x_ySum = sum(dataX.*dataY);
    n = numel(dataX);
    
    top = (n * x_ySum) - (xSum * ySum);
    btm = (n * xKSum) - xSum^2;
    
    res = top / btm;
    
    fprintf("Slope b: %.3f\n", res);
end