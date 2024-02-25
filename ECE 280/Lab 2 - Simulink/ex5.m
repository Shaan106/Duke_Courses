clear;

Days = 60;
StockInfo = readtable('table.csv');
StockPrices = StockInfo.AdjClose((end-Days+1):end);


n = [1:Days]'-1;


concat = [n(:), StockPrices(:)];