close all;
clc;

init();

function init()
   % pert 9
   disp('Nomor 1');
   dataIpk = xlsread('./Data_IPK.xlsx');
   nomor1(dataIpk, 1.645);
   
   % pert 9
   disp('Nomor 2');
   dataVaksin = xlsread('./Data_Vaksinasi.xlsx');
   nomor2(dataVaksin, 1.282);
   
   % pert 10
   disp('Nomor 3');
   dataPenjualan = xlsread('./Data_Penjualan.xlsx');
   nomor3(dataPenjualan, 1.036);
   
   % pert 10
   disp('Nomor 4');
   dataPelanggan = xlsread('./Data_Pelanggan5G.xlsx');
   nomor4(dataPelanggan, 1.645);
   
   % pert 12
   disp('Nomor 5');
   dataPenumpang = xlsread('./Data_Penumpang.xlsx');
   nomor5(dataPenumpang, 1.282);
end

function nomor1(datas, alpha)
    format shortg
    x = round(mean(datas), 3, 'significant');
    u = 3.30;
    n = numel(datas);
    sb = round(std(datas), 3, 'significant');
    a = alpha;
    am = -(alpha);
    
    top = x - u;
    btm = sb / sqrt(n);
    res = top / btm;
    
    if res > am && res < a
        fprintf("H0 Diterima, Z Score = %.3f\n\n", res);
    else
        fprintf("H0 Ditolak, Z Score = %.3f\n\n", res);
    end
end

function nomor2(datas, alpha)
    data = datas(:, 2);
    pPol = 0.45;
    n = numel(data);
    dataFiltered = find(data < 2);
    pSam = numel(dataFiltered) / n;
    a = alpha;
    am = -(alpha);
    
    top = pSam - pPol;
    cmn = pPol * (1 - pPol) / n;
    btm = sqrt(cmn);
    
    res = top / btm;
    
    if res > am && res < a
        fprintf("H0 Diterima, Z Score = %.3f\n\n", res);
    else
        fprintf("H0 Ditolak, Z Score = %.3f\n\n", res);
    end
end

function nomor3(datas, alpha)
    dataA = datas(:, 2);
    dataB = datas(:, 3);
    n1 = numel(dataA);
    n2 = numel(dataB);
    x1 = mean(dataA);
    x2 = mean(dataB);
    sb1 = std(dataA);
    sb2 = std(dataB);
    a = alpha;
    amin = -(alpha);

    top = (x1 - x2);
    cmn1 = sb1^2 / n1;
    cmn2 = sb2^2 / n2;
    down = sqrt(cmn1 + cmn2);
    
    res = top / down;

    if res < a && res > amin
        fprintf("H0 Diterima, Z Score = %.3f\n\n", res);
    else 
        fprintf("H0 Ditolak, Z Score = %.3f\n\n", res);
    end
end

function nomor4(datas, alpha)
    data1 = datas(:, 2);
    data2 = datas(:, 3);
    dataMile = find(data1 < 2);
    dataNonMile = find(data1 > 1);
    
    dataMileAndAgree = find((data1 < 2) & (data2 < 2));
    dataNonMileAndAgree = find((data1 > 1) & (data2 < 2));
    resMileAndAgree = numel(dataMileAndAgree);
    resNonMileAndAgree = numel(dataNonMileAndAgree);
    
    nt = numel(data1);
    n1 = numel(dataMile);
    n2 = numel(dataNonMile);
    ps1 = resMileAndAgree / n1;
    ps2 = resNonMileAndAgree / n2;
    P = (resMileAndAgree + resNonMileAndAgree) / nt;
    a = alpha;
    amin = -(alpha);

    top = (ps1 - ps2) - (P - P);
    
    cmn1 = (P * (1 - P)) / n1;
    cmn2 = (P * (1 - P)) / n2;
    
    btm = sqrt(cmn1 + cmn2);
    res = top / btm;

    if res < a && res > amin
        fprintf("H0 Diterima, Z Score = %.3f\n\n", res);
    else 
        fprintf("H0 Ditolak, Z Score = %.3f\n\n", res);
    end
end

function nomor5(datas, alpha)
    data1 = datas(:, 2);
    data2 = datas(:, 3);
    
    x1 = mean(data1);
    x2 = mean(data2);
    s1 = std(data1);
    s2 = std(data2);
    n1 = numel(data1);
    n2 = numel(data2);
    a = alpha;
    amin = -(alpha);
    
    top = x1 - x2;
    cmn1 = (n1 - 1) * s1^2 + (n2 - 1) * s2^2;
    cmn2 = (n1 + n2) - 2;
    cmn3 = (1 / n1) + (1 / n2);
    
    btm = sqrt(cmn1 / cmn2) * sqrt(cmn3);
    
    res = top / btm;

    if res < a && res > amin
        fprintf("H0 Diterima, Z Score = %.3f\n\n", res);
    else 
        fprintf("H0 Ditolak, Z Score = %.3f\n\n", res);
    end
end
