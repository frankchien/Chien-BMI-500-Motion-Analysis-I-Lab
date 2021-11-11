%preprocess_marker_data and pc1 function written by Frank C
%remaining code with minor adjustments using code by Dr. McKay

clear
close all

trc = rename_trc(read_trc("C:\Users\Frank\Desktop\deidentified_trc\deidentified_trc\688\sit-rest1-TP.trc"));
raw_data = trc{:,startsWith(names(trc), "L.Wrist")};
time_s = trc.Time;
filtered_data = preprocess_marker_data(raw_data,time_s, [2 45]);

pc1_mm = pc1(filtered_data);
figure
plot(time_s,pc1_mm); xlim([0 5])
xlabel("seconds")
ylabel("mm")

