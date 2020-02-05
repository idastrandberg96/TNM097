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
load('illum.mat')
load('chips20')

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

A_crt = xyz' *DLP;

A_crt_norm = A_crt*k;

%% 3.2 
load('XYZ_est')
D_prim = inv(A_crt_norm)*XYZ_est;

% Detta går också. Står att det är bättre än inv.
%D_prim_1 = A_crt_norm\XYZ_est;
k = 100./sum(CIED65'.*xyz(:,2));

S_rgb_res = DLP * D_prim;

XYZ_Srgb_res = k*S_rgb_res'*xyz;

D_prim_res = delta_E(XYZ_Srgb_res, XYZ_ref);

mean_e_D = mean(D_prim_res)
max_e_D = max(D_prim_res)


%% 3.3 
plot(D_prim); %Har negativt värde.
figure
%% 3.4

%D_prim_scale = rescale(D_prim); Sätter högasta värdet till 1?

D_prim(D_prim > 1.0) = 1.0;
D_prim(D_prim < 0) = 0;


S_rgb_scale = DLP * D_prim;

XYZ_Srgb_scale = k*S_rgb_scale'*xyz;

D_prim_scale_res = delta_E(XYZ_Srgb_scale, XYZ_ref);

mean_e_D = mean(D_prim_scale_res)
max_e_D = max(D_prim_scale_res)



%% 3.5

plot_chrom_sRGB(A_crt_norm)

% Pretty bad

%% 3.6

color_sample =  (chips20.*CIED65);
deltis = delta_E(color_sample, XYZ_ref);

[minimum, index] = min(deltis)

plot(400:5:700,S_rgb_scale(:,8))
hold on
plot(400:5:700,color_sample(8,:), '--');


