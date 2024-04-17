%% Comprehensive metric score plot (original -- no FWHM as 4th column)

close all
clear

%% Metric and Case and marker size
m = 1; % {1 'SCR', 2 'SCR-FWHM', 3 'SMR', 4 'SMR-FWHM', 5 'MMR', 6 'LE', ...
    % 7 'Smax', 8 'Cmax', 9 'Smax-FWHM', 10 'Cmax-FWHM', 11 'Smean', 12 'Cmean'};
c = 3;
symbolSize = 200;

%% Initialisation 
m_range = (10:1:30)*1e-3; % m
ph_values = {'B0', 'B10E', 'B15E', 'B20E', 'B30E'};
label_list = {'c1,1', 'c1,2', 'c1,3', 'c1,4', 'c2,1', 'c2,2', 'c2,3', 'c2,4'};

fontSize = 20;
cc_phantoms = hsv(length(ph_values));
col_num = 12;
rbow = zeros(col_num, 3);

for i = 1:col_num
    hue = (i-1)/col_num;
    rgb_color = hsv2rgb([hue, 1, 1]);
    rbow(i, :) = rgb_color;
end


%% FAKE PLOTTING FOR A LEGEND
figure;
hold on;

% FAKE PLOT RAD = 10mm
rad_values = 1; 
rad_vals = m_range(rad_values)*1e3;  % Convert to mm
ph = 'B0';
load(append('results\', ph, '\workspaces\radius_sweep\', ph, '_', label_list{c}, '.mat'));
met_vals_cell = metric_vals{m};  % Assuming metric_vals is a cell array
met_vals = met_vals_cell(1, rad_values);  % Assuming scr_values_cell is a matrix
scatter(1*ones(size(met_vals)), met_vals, symbolSize, rbow(1, :),...
        '^', 'filled', 'DisplayName', ['R = ', num2str(rad_vals), ' mm'], ...
        'MarkerEdgeColor', 'black', 'LineWidth', 1);

% FAKE PLOT RAD = 20mm
rad_values = 11; 
rad_vals = m_range(rad_values)*1e3;  % Convert to mm
ph = 'B0';
load(append('results\', ph,'\workspaces\radius_sweep\', ph, '_', label_list{c}, '.mat'));
met_vals_cell = metric_vals{m};  % Assuming metric_vals is a cell array
met_vals = met_vals_cell(1, rad_values);  % Assuming scr_values_cell is a matrix
scatter(1.25*ones(size(met_vals)), met_vals, symbolSize, rbow(2, :),...
        's', 'filled', 'DisplayName', ['R = ', num2str(rad_vals), ' mm'], ...
        'MarkerEdgeColor', 'black', 'LineWidth', 1);

% FAKE PLOT RAD = 30mm
rad_values = 21; 
rad_vals = m_range(rad_values)*1e3;  % Convert to mm
ph = 'B0';
load(append('results\', ph, '\workspaces\radius_sweep\', ph, '_', label_list{c}, '.mat'));
met_vals_cell = metric_vals{m};  % Assuming metric_vals is a cell array
met_vals = met_vals_cell(1, rad_values);  % Assuming scr_values_cell is a matrix
scatter(1.5*ones(size(met_vals)), met_vals, symbolSize, rbow(3, :),...
        'o', 'filled', 'DisplayName', ['R = ', num2str(rad_vals), ' mm'], ...
        'MarkerEdgeColor', 'black', 'LineWidth', 1);

legend({'10 mm', '20 mm', '30 mm'}, 'Location', 'northeast', 'FontSize', fontSize, 'AutoUpdate', 'off', 'NumColumns',3);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ACTUAL PLOTS

% Rad = 10mm
rad_values = 1; 
rad_vals = m_range(rad_values)*1e3;  % Convert to mm
hold on;
for ph_idx = 1:length(ph_values)
    % Load data for the current phantom
    ph = ph_values{ph_idx};
    load(append('results\', ph, ...
        '\workspaces\radius_sweep\', ph, '_', label_list{c}, '.mat'));

    % Access metric values for the chosen radius idx
    met_vals_cell = metric_vals{m};  % Assuming metric_vals is a cell array
    met_vals = met_vals_cell(:, rad_values);  % Assuming scr_values_cell is a matrix

    % Plot SCR vs Phantom types with different colours
    scatter(ph_idx * ones(size(met_vals)), met_vals, symbolSize, rbow(1, :),...
        '^', 'filled', 'DisplayName', ['R = ', num2str(rad_vals), ' mm'], ...
        'MarkerEdgeColor', 'black', 'LineWidth', 1);
    hold on;
end

% Rad = 20mm
hold on;
rad_values = 11;  
rad_vals = m_range(rad_values)*1e3;  % Convert to mm
for ph_idx = 1:length(ph_values)
    % Load data for the current phantom
    ph = ph_values{ph_idx};
    load(append('results\', ph, ...
        '\workspaces\radius_sweep\', ph, '_', label_list{c}, '.mat'));

    % Access metric values for the chosen radius idx
    met_vals_cell = metric_vals{m};  % Assuming metric_vals is a cell array
    met_vals = met_vals_cell(:, rad_values);  % Assuming scr_values_cell is a matrix

    % Plot SCR vs Phantom types with different colours
    scatter((ph_idx+0.25)*ones(size(met_vals)), met_vals, symbolSize, rbow(2, :),...
        's', 'filled', 'DisplayName', ['R = ', num2str(rad_vals), ' mm'], ...
        'MarkerEdgeColor', 'black', 'LineWidth', 1);
    hold on;
end

% Rad = 30mm
hold on;
rad_values = 21;  
rad_vals = m_range(rad_values)*1e3;  % Convert to mm
for ph_idx = 1:length(ph_values)
    % Load data for the current phantom
    ph = ph_values{ph_idx};
    load(append('results\', ph, ...
        '\workspaces\radius_sweep\', ph, '_', label_list{c}, '.mat'));

    % Access metric values for the chosen radius idx
    met_vals_cell = metric_vals{m};  % Assuming metric_vals is a cell array
    met_vals = met_vals_cell(:, rad_values);  % Assuming scr_values_cell is a matrix

    % Plot SCR vs Phantom types with different colours
    scatter((ph_idx+0.5)* ones(size(met_vals)), met_vals, symbolSize, rbow(3, :),...
        'o', 'filled', 'DisplayName', ['R = ', num2str(rad_vals), ' mm'], ...
        'MarkerEdgeColor', 'black', 'LineWidth', 1);
    hold on;
end


xticks([1.25, 2.25, 3.25, 4.25, 5.25]);
xticklabels(ph_values);
xlim([0.25 max(length(ph_values) + 1)]);

% ylim([min(min(met_vals_cell))-5 max(max(met_vals_cell))+5]);
ylim([-2 26]);

yticks(-100:2:100);

xlabel('Phantom Types', 'FontSize', fontSize);
ylabel([metric_names{m}, ' Values (dB)'], 'FontSize', fontSize); 
title([metric_names{m}, ' Values for all Phantoms (' , label_list{c}, ')'], 'FontSize', fontSize);

set(gca, 'FontSize', fontSize);
grid on;
grid minor;
hold off;
