getdataCP
=========

getting and cleaning data Course Project Repo

This script reads the data available in the Human Activity Recognition Using Smartphones Data Set provided for the Course Assignment of the Getting and Cleaning Data Course.

The data, which is provided in several raw files, is read into tables and arranged into a single tidy data table. with one record per row, and the identifier of the subject and the description of the activity in the first two columns.

This tada table is then processed to obtain the average of the mean and standard deviation measurments per subject and per activity.

The resulting tidy data has 180 row (30 subjects performing 6 activities) and 68 columns (66 means and standard deviations plus the identifiers of the subject and the acrivity), and the descriptive of the measurments where adjusted for easier reading. A more descriptive definition of the measurement averages is in the codebook.md.

The script must be ran with the data folder placed in the working directory of the machine.

The script also loads the necessary "qdap" library.
  
