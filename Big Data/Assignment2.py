import pandas as pd
import glob
import os

my_path = os.getcwd()
files = glob.glob(my_path + '/bdpClass2/*.csv')
print('Number of files in the bdp_class_2:', len(files))

chicago = 0
for i in files:
    df = pd.read_csv(i)
    chicago += sum(df['Chicago'])
print('Sum of values of Chicago:', chicago)