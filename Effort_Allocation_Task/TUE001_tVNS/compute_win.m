%=================================
%Computes win for effort task
%=================================


%cereals.num=input('Müsli-Sorte: [1 für Frucht, 2 für Schoko, 3 für Schoko-Keks, 4 für Honig-Nuss]: ','s');
cereals.num = 3;

%session.label=input('1 für Training, 2 für Experiment: ', 's');
%insert 0 for different computation
run.label =2;



% 1
cereals.fruit = 369; %kcal/100g
%2
cereals.chocolate = 406; %kcal/100g
%3
cereals.choccookie = 455; %kcal/100g
%4
cereals.honeynut = 454; %kcal/100g



%Exchange rate 5:1
Gewinn_Geld = win_sum_coins / 5

Gewinn_kCal = win_sum_cookies / 5




if cereals.num == 1
    
    nutr_value = cereals.fruit;

elseif cereals.num == 2
    
    nutr_value = cereals.chocolate;
    
elseif cereals.num == 3
    
    nutr_value = cereals.choccookie;
    
elseif cereals.num == 4
    
    nutr_value = cereals.honeynut;
    
end



if run.label == 1
    
    g_Muesli = Gewinn_kCal * 100 / nutr_value
    
elseif run.label == 2
    
    g_Muesli = (Gewinn_kCal - 100 - 68) * 100 / nutr_value
    
end



%============
%end
%============