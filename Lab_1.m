% Setup the Figure
h = 7; % Height in Inches
w = 10; % Width in Inches
Rs = 287; % Variable for Specific Gas Constant

% Set Up the Page
figure ('Units','Inches','Position',[ 0 0 w h ]);
set(gcf,'PaperSize',[ w h ],'PaperPositionMode','auto');

colormap(jet);



%% Plot P-v-T

subplot(2,2,1)
t = 0:100:1000;
v = logspace(-3,0,30);
[T,V] = meshgrid(t,v);
P = (1/(1e6))*(Rs*(T+273))./V;
surf(T,V,P);

% Adjust the Axis Limits, Counts, Scales, and Order
grid on;
xlim([0 1000]);
ylim([10^-3 10^0]);
zlim([0 50]);
xticks(0:200:1000);
yticks(logspace(-3,0,4));
zticks(0:10:50);
set(gca,'YScale','log');
set(gca,'YDir','reverse');

% Label the Axis
xlabel('T (Celsius)');
ylabel('v (m^3/kg)'); 
zlabel('P (MPa)');

%% Plot T-p

subplot(2,2,2);
contourf(T,P,V,logspace(-3,-1,21)); 

% Set Up the Colorbar
a = colorbar;
set(a,'YTick',(0:0.01:0.1))

% Adjust the Axis Limits
grid on;
xlim([0 1000])
ylim([0 50]);

% Label the Axis
xlabel('T (Celsius)');
ylabel('P (MPa)');
ylabel(a,'v (m^3/kg)');

%% Plot v-P

subplot(2,2,3);
t_2 = 0:100:1000000;
[T2,V2] = meshgrid(t_2,v);
P2 = (1/(1e6))*(Rs.*(T2+273))./V2;
contourf(V2,P2,T2,[0 200 400 600 800 1000]);

% Set Up the Colorbar
b = colorbar;

% Adjust the Axis Limits and Scale
grid on;
set(gca,'XScale','log'); 
xlim([10^-3 1]);
ylim([0 50]);

% Label the Axis
xlabel('v (m^3/kg)');
ylabel('P (MPa)');
ylabel(b,'T (Celsius)');

%% Plot v-T

subplot(2,2,4);
contourf(V,T,P,logspace(-0.5,2,12));

% Adjust the Axis Limits and Counts
grid on;
set(gca,'XScale','log');
xticks(logspace(-3,0,4));

% Set Up the Colorbar
c = colorbar;
caxis([0 100]);

% Label the Axis
xlabel('v (m^3/kg)');
ylabel('T (Celsius)');
ylabel(c,'P (MPa)');

%% Print the figure
print('ideal_gas.png','-dpng','-r300')







