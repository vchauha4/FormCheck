import os
# assign directory
directory = 'wrong-curl'
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