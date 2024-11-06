%Naloga 1
t=readmatrix('naloga1_1.txt');

%Naloga 2
podatki=fopen('naloga1_2.txt','r');
P1=[];

for i=1:101
   vrstica=fgetl(podatki);
   stevilo=str2double(vrstica);
   P1(i)=stevilo;
end

fclose(podatki);

P=P1(2:end);

plot(t,P);
xlabel('t[s]');
ylabel('P[W]');
title('Graf P(t)');

%Naloga 3
dt=t(2)-t(1); %korak

integral1=P(1)+P(end);

integral2=0;

for i=2:99
    integral2=integral2+(2*P(i));
end

integral=(dt/2)*(integral1+integral2)

integralt=trapz(t,P)


