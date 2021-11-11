
% Matlab script for BMI homework on tremor analysis, part 1
% Frank Chien
% 11/10/21
% The protocol script is adapted from Professor McKay's lecture


function outcomes = tremor_analysis(varargin)


%set up input parser
default_fname = "C:\Users\Frank\Desktop\deidentified_trc\deidentified_trc\198\sit-rest1-TP.trc";
default_markername = "L.Finger3.M3";
default_plot_flag=0;

prs = inputParser;
prs.addOptional('fname', default_fname);
prs.addOptional('markername', default_markername);
prs.addOptional('plot_flag',default_plot_flag);
prs.parse(varargin{:});

%assign arguments
fname = prs.Results.fname;
markername = prs.Results.markername;
plot_flag = prs.Results.plot_flag;

%read
trc = rename_trc(read_trc(fname));
raw_data = trc{:,startsWith(names(trc),markername)}; %this is going to pick only the columns that match the x,y,z axis of markername
filtered_data = preprocess_marker_data(raw_data,trc.Time, [2 45]); %parameters 2, 45 given by assignment


%doing the principal component 1
time_s = trc.Time;
pc1_mm = pc1(filtered_data);

% 
TT=timetable(seconds(time_s),pc1_mm);
TT.Properties.VariableNames = [default_markername];
TT.Properties.VariableUnits = ["mm"];
% 
[p,f,~] = pspectrum(TT, 'spectrogram', 'MinThreshold', -50, 'FrequencyResolution',0.5, 'FrequencyLimits',[0 20]);

%getting max_P
%p has 21 columns listed, as frequency limits 0 through 20 was given to pspectrum
[max_p, max_index] = max(p, [], 'all');

%getting f_max_p
%max returns the 1d index, so to get the index corresponding to frequency
%we need to use modulo
max_index = mod(max_index,size(p,1)); %dim 1 gets rows. size(p,1) gets num rows
f_max_p = f(max_index);

%getting f_sd
[~,row_indices] = max(p,[],1); %get's row where that max p was obtained for each column
f_sd = std(f(row_indices));

%getting rms_power
[~, i] = max(max(p)); %max(p) returns columnwise max. Doing max again places column index of global max p into variable i
powers = p(:,i); %gets column where max p was found
%average power within +- 0.5hz of frequency at overall max power
bounds = [f_max_p-0.5 f_max_p+0.5]; %defines bounds for frequency
f_power = table(f,powers); %makes a table of frequencies, powers
sub_f_power = f_power(f_power.f > bounds(1) & f_power.f < bounds(2),:); %gets only the sub-table such that f > lower bounds and < upper bounds
rms_power = mean(sub_f_power.powers); %averages the powers in the filtered sub_table

outcomes = [max_p, f_max_p, f_sd, rms_power];

end