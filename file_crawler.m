clear;
close all;
%file crawler - runs tremor_analysis on every trc 
icd_filepath = "C:\Users\Frank\Desktop\icd.csv";
pts=readtable(icd_filepath);

%this script assumes the deidentified_trc folder is in desktop. This
%filepath base will need to be changed to run on another machine.
trc_filepath_base = "C:\Users\Frank\Desktop\deidentified_trc\deidentified_trc\";

pids = [];
files = [];
icds = [];
markernames = [];
max_ps = [];
f_max_ps = [];
f_sds = [];
rms_powers = [];
for i=1:size(pts.id) %loops through pid

    pid = pts.id(i);
    %constructing the filepath search string
    dir_search_str = strcat(trc_filepath_base,string(pid), "\*.trc");
    %uses dir() to find the trc name in the folder
    trc_files = dir(dir_search_str);
    %dir will return a struct containing the folder name and the file name.
    %concatenate together with \ delimiter to make the full file pathway
    %str
    f = strcat(trc_files.folder, "\", trc_files.name);
    %runnig tremor_analysis using filename
    row_output = tremor_analysis('fname', f); %allowing default markername to L.finger.m3

    file = strcat(string(pid),"\",trc_files.name)
    

    pids = [pids pid];
    files = [files file];
    icds = [icds pts(i,2).icd]; %icd data is encoded in 2nd column of icd.csv
    markernames = [markernames "L.Finger3.M3"]; %we will only look at this marker for the assignment
    max_ps = [max_ps row_output(1)];
    f_max_ps = [f_max_ps row_output(2)];
    f_sds = [f_sds row_output(3)];
    rms_powers = [rms_powers row_output(4)];
    
end
output = table(pids', files', icds', markernames', max_ps',f_max_ps', f_sds', rms_powers', 'VariableNames',{'record_id','file','icd','markername','max_p','f_max_p','f_sd','rms_power'})
writetable(output,"output_dataset.csv")