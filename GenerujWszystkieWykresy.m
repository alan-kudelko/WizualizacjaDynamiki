nazwaPliku='przejazdDane';

%W celu unikniecia niepotrzebnego zapisywania wykresow na dysku
%nalezy zakomentowac linie 94 oraz 168
for przejazd=1:1:8
    for bieg=3:1:4

iteracyjnaNazwaPliku=strcat(strcat(strcat(nazwaPliku,num2str(przejazd)),'_'),strcat(num2str(bieg),'Bieg'));

dane=load(strcat(iteracyjnaNazwaPliku,'.csv'));
% Zamiast wyświetlać co tik, to co sekundy które otrzymamy z DT

tik=1:length(dane);

%Zamiana prędkości w km/h na prędkość w m/s
dane(:,15)=dane(:,15)/3.6;

czas=linspace(0,0,length(dane));
for i=2:1:length(dane)
    czas(i)=dane(i,14)+czas(i-1);
end
%% Ugięcie sprężyn, pozycja kół
figure('units','inch','position',[0 0.5 8.5 8.5]);
subplot(4,2,1:2);
title("Pozycja pionowa kół 1 i 2",'FontSize',12);
hold all;
plot(czas,dane(:,2),'color',[0 0.4470 0.7410],'LineWidth',1.1,'LineStyle','-');
plot(czas,dane(:,3),'color',[0.8500 0.3250 0.0980],'LineWidth',1.1,'LineStyle','-');

grid on;
ylim([-150,150]);
osie=gca;
set(get(gca,'XAxis'),'FontSize',11);
set(get(gca,'YAxis'),'FontSize',12);
set(get(gca,'YAxis'),'TickLabelInterpreter', 'latex');
osie.XLabel.String='t [s]';
ylabel('z koła [cm]','Interpreter','latex','FontSize',14);
set(get(gca,'YLabel'),'Rotation',0)
set(get(gca,'YLabel'),'Position',[0,160]);
xl=xlim;
set(get(gca,'XLabel'),'Position',[mean(xl),-182]);

subplot(4,2,3:4);
title("Pozycja pionowa kół 3 i 4",'FontSize',12);
hold all;
plot(czas,dane(:,4),'color',[0.4660 0.6740 0.1880],'LineWidth',1.1,'LineStyle','-');
plot(czas,dane(:,5),'color',[0.6350 0.0780 0.1840],'LineWidth',1.1,'LineStyle','-');

grid on;
ylim([-150,150]);
osie=gca;
set(get(gca,'XAxis'),'FontSize',11);
set(get(gca,'YAxis'),'FontSize',12);
set(get(gca,'YAxis'),'TickLabelInterpreter', 'latex');
osie.XLabel.String='t [s]';
ylabel('z koła [cm]','Interpreter','latex','FontSize',14);
set(get(gca,'YLabel'),'Rotation',0)
set(get(gca,'YLabel'),'Position',[0,160]);
xl=xlim;
set(get(gca,'XLabel'),'Position',[mean(xl),-182]);

subplot(4,2,5:6);
title("Względne ugięcie sprężyn 1 i 2",'FontSize',12);
hold all;
plot(czas,dane(:,6),'color',[0 0.4470 0.7410],'LineWidth',1.5,'LineStyle','-');
plot(czas,dane(:,7),'color',[0.8500 0.3250 0.0980],'LineWidth',1.5,'LineStyle','-');

grid on;
ylim([-0.1,1.1]);
osie=gca;
set(get(gca,'XAxis'),'FontSize',11);
set(get(gca,'YAxis'),'FontSize',12);
osie.XLabel.String='t [s]';
set(get(gca,'YLabel'),'Rotation',0)
set(get(gca,'YLabel'),'Position',[0,1.15]);
xl=xlim;
set(get(gca,'XLabel'),'Position',[mean(xl),-0.26]);

subplot(4,2,7:8);
title("Względne ugięcie sprężyn 3 i 4",'FontSize',12);
hold all;
plot(czas,dane(:,8),'color',[0.4660 0.6740 0.1880],'LineWidth',1.5,'LineStyle','-');
plot(czas,dane(:,9),'color',[0.6350 0.0780 0.1840],'LineWidth',1.5,'LineStyle','-');

grid on;
ylim([-0.1,1.1]);
osie=gca;
set(get(gca,'XAxis'),'FontSize',11);
set(get(gca,'YAxis'),'FontSize',12);
osie.XLabel.String='t [s]';
xl=xlim;
set(get(gca,'XLabel'),'Position',[mean(xl),-0.30]);

saveas(gcf,strcat(strcat(iteracyjnaNazwaPliku,'Pojazd'),'.png'));

%% Wykres prędkości chwilowej przejazdu
% Prędkość pojazdu
figure('units','inch','position',[9 0.5 8.5 8]);
subplot(3,1,1);
title("Prędkość chwilowa pojazdu podczas przejazdu",'FontSize',12);
hold all;
plot(czas,dane(:,15),'color',[0.6350 0.0780 0.1840],'LineWidth',1.5,'LineStyle','-');
grid on;
ylim([0,9]);
osie=gca;
set(get(gca,'XAxis'),'FontSize',11);
set(get(gca,'YAxis'),'FontSize',12);
set(gca,'YTick',[0,0.55,1.11,2.22,4.44,8.88]);
set(get(gca,'YAxis'),'TickLabelInterpreter', 'latex');
osie.XLabel.String='t [s]';
ylabel('v pojazdu [$\frac{m}{s}$]','Interpreter','latex','FontSize',14);
set(get(gca,'YLabel'),'Rotation',0)
set(get(gca,'YLabel'),'Position',[0,9.2]);
% Przyśpieszenie poprzeczne? pojazdu
subplot(3,1,2);
title("Przyśpieszenie chwilowe pojazdu podczas przejazdu",'FontSize',12);
hold all;

przyspieszeniePojazdu=linspace(0,0,length(dane));

for i=2:1:length(dane)
    przyspieszeniePojazdu(i)=(dane(i,15)-dane(i-1,15))/dane(i,14);
end

plot(czas,przyspieszeniePojazdu,'color',[0.6350 0.0780 0.1840],'LineWidth',1.5,'LineStyle','-');
grid on;
ylim([-15,15]);
osie=gca;
set(get(gca,'XAxis'),'FontSize',11);
set(get(gca,'YAxis'),'FontSize',12);
%set(gca,'YTick',[0,2,4,8,16,20,26]);
osie.XLabel.String='t [s]';
ylabel('a pojazdu [$\frac{m}{s^2}$]','Interpreter','latex','FontSize',14);
set(get(gca,'YLabel'),'Rotation',0)
set(get(gca,'YLabel'),'Position',[0,16]);

%Położenie i orientacja pojazdu
subplot(3,1,3);
title(["Położenie pionowe pojazdu podczas przejazdu","Orientacja pojazdu w trakcie przejazdu"],'FontSize',12);
hold all;
colororder([0.6350 0.0780 0.1840
            0 0 0]);

yyaxis left;
plot(czas,dane(:,10),'color',[0.6350 0.0780 0.1840],'LineWidth',1.1,'LineStyle','-');
grid on;
osie=gca;
set(get(gca,'XAxis'),'FontSize',11);
set(get(gca,'YAxis'),'FontSize',12);
osie.XLabel.String='t [s]';
ylabel('z pojazdu [$cm$]','Interpreter','latex','FontSize',14);
set(get(gca,'YLabel'),'Rotation',0)
set(get(gca,'YLabel'),'Position',[0,270]);
ylim([-250,250]);

yyaxis right;
plot(czas,dane(:,11),'color',[0 0.4470 0.7410],'LineWidth',1.1,'LineStyle','-');
plot(czas,dane(:,12),'color',[0.8500 0.3250 0.0980],'LineWidth',1.1,'LineStyle','-');
plot(czas,dane(:,13),'color',[0.9290 0.6940 0.1250],'LineWidth',1.1,'LineStyle','-');
ylabel('Orientacja pojazdu [$\circ$]','Interpreter','latex','FontSize',14);
set(get(gca,'YLabel'),'Rotation',0)
xl=xlim;
set(get(gca,'YLabel'),'Position',[xl(2)*0.91,55]);
ylim([-40 40]);

lgd=legend({'Położenie pionowe','Roll','Pitch','Yaw'},'Position',[0.215,0.253,0.01,0.01],'BackgroundAlpha',[0],'Box','off');

saveas(gcf,strcat(strcat(iteracyjnaNazwaPliku,'Sprezyny'),'.png'));

    end
end


