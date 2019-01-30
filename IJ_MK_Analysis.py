#!/usr/bin/env python
#This script calculates percentages of ProPLT formation from csvs
#generated by MK_Incucyte_Zoom_Batch.ijm

import os, re, sys
import pandas as pd
import numpy as np

def alphanumeric_sort(l):

    convert = lambda text: int(text) if text.isdigit() else text
    alphanum_key = lambda key: [convert(c) for c in re.split('([0-9]+)', key)]
    return sorted(l, key = alphanum_key)

from tkinter.filedialog import askdirectory

''' User selects folder containing excel csvs created by the MK_Incucyte_Zoom_Batch.ijm '''

results_dir = askdirectory()
os.chdir(results_dir)
files = alphanumeric_sort(os.listdir(results_dir))

timepoints = int(input("Number of Timepoints:"))

""" Functions """
def format_output_csv(dataframe, files, timepoints, results_dir, csv_name):

    dataframe.columns = files
    dataframe['Timepoint'] = range(1,(timepoints + 1))
    dataframe = dataframe.set_index('Timepoint')
    dataframe.to_csv(os.path.join(results_dir, csv_name))

def analyze(df,timepoints,pct_list,mk_list,pplt_list):
    
    n = 1

    while n <= timepoints: 
        
        df2 = df.loc[n].reset_index()

        mk = df2.loc[df2["Circ."] > 0.4, 'Area']
        mk_area = mk.sum()
        
        pplt = df2.loc[df2["Circ."] < 0.4, 'Area']
        pplt_area = pplt.sum()
        
        try:
            
            pct = len(pplt)/len(mk) * 100
            
        except ZeroDivisionError:
            
            pct = 0.00
            
        pct_list.append(pct)      
        mk_list.append(mk_area)
        pplt_list.append(pplt_area)

        n += 1
                
        if n > timepoints:
            
            df3 = pd.DataFrame(
                {'Pct': pct_list,
                 'MK_Area': mk_list,
                 'Pplt_Area': pplt_list})
        
    return df3

""" Main """

final_df = pd.DataFrame()

for file in files:
    
    df = pd.read_csv(file, usecols = ["Area", "Circ.", "Slice"], index_col = ["Slice"])
    
    pct_list = []
    mk_list = []
    pplt_list = []
    
    frame = analyze(df,timepoints,pct_list,mk_list,pplt_list) 
    final_df = pd.concat([final_df,frame],axis=1)

format_output_csv(final_df.iloc[:,::3], files, timepoints, results_dir, "Pct_Pplt_Prod.csv")
format_output_csv(final_df.iloc[:,1::3], files, timepoints, results_dir, "Area_MK.csv")
format_output_csv(final_df.iloc[:,2::3], files, timepoints, results_dir, "Area_Pplt.csv")

print("Done!")
sys.exit()
