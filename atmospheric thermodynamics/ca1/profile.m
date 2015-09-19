close all
clear all

% Goal : Plot T vs Heigh and T vs P in July and Dec for the station


%Note that your data should not have blank
%Besides the station number begin as 0, please change o or O

% All file format, please refer to the format in dir "sample_format"


% Load the locations ...
stations = importdata ('stations.txt');
stationnum = size(stations, 1);

fig = 0;

for i = 1:stationnum
	info = importdata ([stations{i}, '_info.txt']);
	year = info.data;
	locate = info.textdata{1};

	% Load July data
	data = load ([stations{i}, '_july.txt']);
	[row, col] = size(data);
	pre_j = data(:, 1);
	hei_j = data(:, 2) / 1000;
	T_j = data(:,3);

	% Load Dec data
	data = load ([stations{i}, '_dec.txt']);
	[row, col] = size(data);
	pre_d = data(:, 1);
	hei_d = data(:, 2) / 1000;
	T_d = data(:, 3);
	

	% Set y range of two pictures
	hei_max = max([hei_j;hei_d]);
	hei_min = min([hei_j;hei_d]);
	pre_max = max([pre_j;pre_d]);
	pre_min = min ([pre_j;pre_d]);
	
	fig = fig + 1;
	figure(fig);
	plot (T_j, hei_j, 'b', T_d, hei_d, 'r');
	xlabel ('temperature (^{\circ}C)');
	ylabel ('height (km)');
	title (['Temperature vs Heigh in ', locate, ' of ', num2str(year)]);
	ylim([hei_min, hei_max]);
	legend ('July', 'December');
	print ('-dpng', ['T vs Heigh in ', locate, ' of ', num2str(year)]);

	fig = fig + 1;
	figure(fig);
	plot (T_j, pre_j, 'b', T_d, pre_d, 'r');
	ylabel ('Pressure (hPa)');
	xlabel ('temperature (^{\circ}C)');
	title (['Temperature vs Pressure in ', locate, ' of ', num2str(year)]);
	set (gca, 'ydir', 'reverse');
	ylim([pre_min, pre_max]);
	legend ('July', 'December');
	print ('-dpng', ['T vs P in ', locate, ' of ', num2str(year)]);
end
