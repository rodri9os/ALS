clear;
%x = [100 100 100 100 100 100 100 100]; %Densidade alta
%x = [100 101 101 102 105 102 100 103]; %Densidade alta
%x = [100 110 160 180 105 102 190 100]; %Densidade baixa - pontos distantes 
%x = [100 101 100 102 101 102 100 190]; %Densidade para um ponto novo distante
%x = [100 100 100 180 100 100 100 100]; %Densidade baixa - outlayer 
x = rand(100,1);


i = size(x,2);
%dataSize = size(x, 1);


for k = 1:i 
    
    if (k==1)
        mi(k) = x(k);
        X(k)= (abs(x(k)))^2;        
        D(k) = 1 / (1 + (abs(x(k) - mi(k)))^2 + (X(k) - (abs(mi(k)))^2)); 
        
        Dm(k)=D(k);
        DesPadD(k)=0;
        
    else
        mi(k)= ((k - 1)/k)*mi(k-1) + (1/k) * x(k);
        X(k) = ((k - 1)/k)*X(k-1) + 1/k*(abs(x(k))^2);
        D(k) = 1 / (1 + (abs(x(k) - mi(k)))^2 + (X(k) - (abs(mi(k)))^2)); 
        
        Dm(k)= ((k-1)/k)*Dm(k-1) + ((1/k) * D(k));
        DesPadD(k)= ((k-1)/k) * (DesPadD(k-1))^2 + (1/k)*(D(k)-Dm(k))^2;
    end
    
    %detectando outlier
    if (D(k) < Dm(k) - DesPadD(k))
        res(k) = 1;
    else
        res(k) = 0;
    end
end