# BMI 500 Motion Analysis Lecture 1
# Dr. McKay
# Assignment completed by Frank Chien 11/11/21

Matlab R2021b was downloaded and used for this assignment. 

This assignment uses code from Dr. McKay's website as well as code given in the powerpoint. My (Frank Chien) contributions to the assignment are in writing the functions preprocess_marker_data and pc1, or otherwise explicitly commented in code. plot_motion.m was written to demonstrate the code's functionality and to reproduce the figure on slide 74 of the lecture powerpoint. This graphic is found in preprocessed_pc1_plot.png.

When run on pt 688  using "L.Wrist", the outputs of tremor_analysis were similar to the output in slide 80 with minor variation, except RMS_Power was ~6 rather than 9.49.

Using the following command >> tremor_analysis('fname', "C:\Users\Frank\Desktop\deidentified_trc\deidentified_trc\688\sit-rest1-TP.trc", 'markername', "L.Wrist")
These were the outputs obtained:    9.9679    5.0400    0.3671    6.0203
Compared to: 9.6505	5.0400	0.3655	9.4936

Tremor_analysis.m takes a filename and outputs max_p, f_max_p, f_sd, and rms_power. This script calls preprocess_marker_data and pc1.

For preprocessing, butter() was used followed by filtfilt(). An N of 6 was arbitrarily chosen for butter()

for pc1, principal component analysis was performed. The first column of the coefficient matrix corresponds to the first principal component. 3d data was then projected onto the primary principal component before being returned.

Finally, file_crawler.m is a script written by Frank Chien that uses the patients in icd.csv and runs tremor_analysis in a for loop. The script builds an output table based on the results of tremor_analysis and writes them to a csv. The output file is given under the name "output_dataset.csv".

Filepaths for file_crawler were hard-coded in, and needs to be changed to run on another system.

Due to file size, deidentified_trc and the lecture slides were not included but can be obtained from Dr. McKay's website.