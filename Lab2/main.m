%% 1.1 
TRC = load('TRC_display.mat');
r = TRC.TRCr;
g = TRC.TRCg';
b = TRC.TRCb';

linear = (0:0.01:1)';

plot(linear, r, 'red');
hold on
plot(linear, g, 'green');
hold on
plot(linear, b, 'blue');
plot(linear, linear', '--');



%% 1.2

Ramp_display = load('Ramp_display.mat');
Ramp_display = Ramp_display.Ramp_display;
Ramp_linear = load('Ramp_linear.mat');
Ramp_linear = Ramp_linear.Ramp_linear;


subplot(3,1, 1);
imshow(Ramp_display)
title('Ramp display')

subplot(3, 1, 2)
imshow(Ramp_linear)
title('Ramp linear')

res = linearization(Ramp_display, r, g, b);
subplot(3,1,3)
imshow(res);
title('Linearization')

%% 1.2

max_D = max(max(Ramp_display));
D(:,:,1) = max_D(:,:,1)*(Ramp_display(:,:,1)/max_D(:,:,1)).^(1/2.1);
D(:,:,2) = max_D(:,:,2)*(Ramp_display(:,:,2)/max_D(:,:,2)).^(1/2.4);
D(:,:,3) = max_D(:,:,3)*(Ramp_display(:,:,3)/max_D(:,:,3)).^(1/1.8);

imshow(D)


%% 2.1
load('DLP.mat')
wavelength = (400:5:700);

plot(wavelength, DLP(:,1), 'red');
hold on
plot(wavelength, DLP(:,2), 'green');
hold on
plot(wavelength, DLP(:,3), 'blue');

%% 2.2
% Sr_max is the radiance emitted from the red channels maximum intensity
% Dr is the digital input to the display.

% Srgb(lamda) = Dr' Sr_max(lamda) + Dg' Sg_max(lamda) + Db' Sb_max (lamda)

% RGB_raw as input
load('RGB_raw.mat');
load('xyz.mat')
load('XYZ_ref.mat')

S_rgb = DLP * RGB_raw;

% Normalization factor
k = 100./sum(CIED65'.*xyz(:,2));

XYZ_Srgb = (k*S_rgb'*xyz);

delta = delta_E(XYZ_Srgb, XYZ_ref);

mean_e = mean(delta)

max_e = max(delta)

%% 2.3
load('RGB_cal.mat');

S_rgb_CAL = DLP * RGB_cal;

% Normalization factor
k = 100./sum(CIED65'.*xyz(:,2));

XYZ_Srgb_CAL = k*S_rgb_CAL'*xyz;

delta_cal = delta_E(XYZ_Srgb_CAL, XYZ_ref);

mean_e_cal = mean(delta_cal)

max_e_cal = max(delta_cal)

%% 3.1

% Normalization factor
k = 100./sum(CIED65'.*xyz(:,2));

A_crt = DLP' * xyz;

A_crt_norm = A_crt*k;

%% 3.2 Skippis tills vi får hjälpis

%% 3.3 

%% 3.4

%% 3.5

plot_chrom_sRGB(A_crt_norm)

% Pretty bad

%% 3.6

