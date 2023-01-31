import os
# assign directory
directory = 'data\\front'
stingLIst=[]
# iterate over files in
# that directory
for filename in os.listdir(directory):
    f = os.path.join(directory, filename)
    # checking if it is a file
    if os.path.isfile(f):
        stingLIst.append(str(f))
        # print(filename)
print(stingLIst)