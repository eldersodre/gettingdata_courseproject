---
title: "README"
output: html_document
---

This repository contains my answers to "Getting and Cleaning Data" course project.

* run_analysis.R

The file above is an R script containing the code to create a tidy dataset based on UCI HAR Data set, originally available at:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


The script, at first, loads the required packages and loads the necessary datasets into R.

The test and train datasets are merged as one, along with subject and activity number. Then, only mean and standard deviation measurements are selcted.

Activity numbers are replaced by activity label, according to the file activity_labels.txt .

By using the function aggregate(), the mean of selected variables was calculated regarding the subject and activity. This data frame was then made tidy with the functions gather() and separate.


*CodeBook.md

Code book explaining the variables in tidy.data.txt .