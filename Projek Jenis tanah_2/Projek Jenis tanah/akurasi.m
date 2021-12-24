hasil = xlsread('hasil.xls');
x1=hasil(:,1:20);
[a b] = size(x1);
t1=hasil(:,21);
dt_uji=xlsread('data uji.xls');
x1_uji=dt_uji(:,1:20);
[c d] = size(x1_uji);
y1_uji=dt_uji(:,21);

%
kls1 = [];
for i=1:c
   arrData = [];
   arrLabel = t1;
   for j=1:a
      res = 0;
      for k=1:b
        n1 = x1(j,k);
        n2 = x1_uji(i,k);
        n1 = str2double(n1);
        n2 = str2double(n2);
        res = res + (n1 - n2).^2;
      end
      res = sqrt(res);
      arrData = [arrData res];
   end
   [values,isort]=sort(arrData);
   names=arrLabel(isort);
   kls1 = [ kls1 names(1)];
end

[m n]=size(y1_uji);
ttl1=0;
for i=1:m
    if(ismember(kls1(i), y1_uji(i)))
        ttl1=ttl1+1;
    end
end
akurasi_knn=ttl1/m*100

%
% c1 = fitcknn(x1,t1,'NumNeighbors',1,'Standardize',1);
% kls1 = predict(c1,x1_uji);
% [m n] = size(y1_uji);
% ttl1=0;
% for i=1:m
%     if(kls1(i)==y1_uji(i))
%       ttl1=ttl1+1;
%     end
% end
% akurasi_hasil_knn=ttl1/m*100