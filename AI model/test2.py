# import os
# # assign directory
# directory = 'data\\wrong'
# stingLIst=[]
# # iterate over files in
# # that directory
# for filename in os.listdir(directory):
#     f = os.path.join(directory, filename)
#     # checking if it is a file
#     if os.path.isfile(f):
#         stingLIst.append(str(f))
#         # print(filename)
# print(stingLIst)



# vidpath1=['','data\\proper\\6976[0].mp4', 'data\\proper\\6976[10].mp4', 'data\\proper\\6976[11].mp4', 'data\\proper\\6976[12].mp4', 'data\\proper\\6976[13].mp4', 'data\\proper\\6976[14].mp4', 'data\\proper\\6976[15].mp4', 'data\\proper\\6976[16].mp4', 'data\\proper\\6976[18].mp4', 'data\\proper\\6976[19].mp4', 'data\\proper\\6976[1].mp4', 'data\\proper\\6976[20].mp4', 'data\\proper\\6976[21].mp4', 'data\\proper\\6976[22].mp4', 'data\\proper\\6976[23].mp4', 'data\\proper\\6976[24].mp4', 'data\\proper\\6976[25].mp4', 'data\\proper\\6976[26].mp4', 'data\\proper\\6976[27].mp4', 'data\\proper\\6976[28].mp4', 'data\\proper\\6976[29].mp4', 'data\\proper\\6976[2].mp4', 
# 'data\\proper\\6976[30].mp4', 'data\\proper\\6976[3].mp4', 'data\\proper\\6976[4].mp4', 'data\\proper\\6976[5].mp4', 'data\\proper\\6976[6].mp4', 'data\\proper\\6976[7].mp4', 'data\\proper\\6976[8].mp4', 'data\\proper\\6976[9].mp4', 'data\\proper\\proper[0].mp4', 'data\\proper\\proper[10].mp4', 'data\\proper\\proper[11].mp4', 'data\\proper\\proper[12].mp4', 'data\\proper\\proper[13].mp4', 'data\\proper\\proper[14].mp4', 'data\\proper\\proper[15].mp4', 'data\\proper\\proper[16].mp4', 'data\\proper\\proper[17].mp4', 'data\\proper\\proper[18].mp4', 'data\\proper\\proper[19].mp4', 'data\\proper\\proper[1].mp4', 'data\\proper\\proper[20].mp4', 'data\\proper\\proper[21].mp4', 'data\\proper\\proper[22].mp4', 'data\\proper\\proper[23].mp4', 'data\\proper\\proper[24].mp4', 'data\\proper\\proper[25].mp4', 'data\\proper\\proper[26].mp4', 'data\\proper\\proper[27].mp4', 'data\\proper\\proper[28].mp4', 'data\\proper\\proper[29].mp4', 'data\\proper\\proper[2].mp4', 'data\\proper\\proper[30].mp4', 'data\\proper\\proper[31].mp4', 'data\\proper\\proper[32].mp4', 'data\\proper\\proper[33].mp4', 'data\\proper\\proper[34].mp4', 'data\\proper\\proper[35].mp4', 'data\\proper\\proper[36].mp4', 'data\\proper\\proper[37].mp4', 'data\\proper\\proper[38].mp4', 'data\\proper\\proper[39].mp4', 'data\\proper\\proper[3].mp4', 'data\\proper\\proper[40].mp4', 'data\\proper\\proper[41].mp4', 'data\\proper\\proper[42].mp4', 'data\\proper\\proper[43].mp4', 'data\\proper\\proper[44].mp4', 'data\\proper\\proper[45].mp4', 'data\\proper\\proper[46].mp4', 'data\\proper\\proper[47].mp4', 'data\\proper\\proper[48].mp4', 'data\\proper\\proper[49].mp4', 'data\\proper\\proper[4].mp4', 'data\\proper\\proper[50].mp4', 'data\\proper\\proper[51].mp4', 'data\\proper\\proper[52].mp4', 'data\\proper\\proper[53].mp4', 'data\\proper\\proper[54].mp4', 'data\\proper\\proper[55].mp4', 'data\\proper\\proper[56].mp4', 
# 'data\\proper\\proper[57].mp4', 'data\\proper\\6976[17].mp4', 'data\\proper\\proper[59].mp4', 'data\\proper\\proper[5].mp4', 'data\\proper\\proper[60].mp4', 'data\\proper\\proper[61].mp4', 'data\\proper\\proper[62].mp4', 'data\\proper\\proper[63].mp4', 'data\\proper\\proper[64].mp4', 'data\\proper\\proper[65].mp4', 'data\\proper\\proper[66].mp4', 'data\\proper\\proper[67].mp4', 'data\\proper\\proper[68].mp4', 'data\\proper\\proper[69].mp4', 'data\\proper\\proper[6].mp4', 'data\\proper\\proper[70].mp4', 'data\\proper\\proper[71].mp4', 'data\\proper\\proper[72].mp4', 'data\\proper\\proper[73].mp4', 'data\\proper\\proper[74].mp4', 'data\\proper\\proper[75].mp4', 'data\\proper\\proper[76].mp4', 'data\\proper\\proper[77].mp4', 'data\\proper\\proper[78].mp4', 'data\\proper\\proper[79].mp4', 'data\\proper\\proper[7].mp4', 'data\\proper\\proper[80].mp4', 'data\\proper\\proper[81].mp4', 'data\\proper\\proper[82].mp4', 'data\\proper\\proper[83].mp4', 'data\\proper\\proper[84].mp4', 'data\\proper\\proper[85].mp4', 'data\\proper\\proper[86].mp4', 'data\\proper\\proper[87].mp4', 'data\\proper\\proper[88].mp4', 'data\\proper\\proper[89].mp4', 'data\\proper\\proper[8].mp4', 'data\\proper\\proper[90].mp4', 'data\\proper\\proper[91].mp4', 'data\\proper\\proper[92].mp4', 'data\\proper\\proper[93].mp4', 'data\\proper\\proper[94].mp4', 'data\\proper\\proper[95].mp4', 'data\\proper\\proper[9].mp4']

# print(len(vidpath1))

import pandas as pd

# Read the data into a Pandas DataFrame
df = pd.read_csv('./courses.csv')

# Group the data by the "Frames" column
groups = df.groupby('Frames')

# Initialize the input and output arrays
input_data = []
output_data = []

# Iterate over the groups
for _, group in groups:
    # Split the data into separate sequences when the "Frames" value is 0
    if group['Frames'].iloc[0] == 0:
        # Append the "Angles" column as input data
        input_data.append(group['Angles'].values)

        # Calculate the difference between the current and previous values of the "Angles" column as output data
        output_data.append(group['Angles'].diff().values[1:])

# Create a new Pandas DataFrame with columns for the input and output data
data = pd.DataFrame(columns=['Input', 'Output'])
data['Input'] = input_data
data['Output'] = output_data

# Write the DataFrame to a CSV file
data.to_csv('formatted_data.csv', index=False)
