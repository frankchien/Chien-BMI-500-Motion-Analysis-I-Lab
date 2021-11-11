function filtered_data = preprocess_marker_data(raw_data, time, cutoff_frequencies)
%after several attempts with ftt(), bandpass(), at last!
fs = 1/mean(diff(time));  %sampling frequency is a function of the mean delta(t) given by time
[b,a] = butter(6,cutoff_frequencies/(fs/2),"bandpass"); %butterworth filter using bandpass method. %arbitrarily picking 6 for nth order...
filtered_data = filtfilt(b,a,raw_data);
end