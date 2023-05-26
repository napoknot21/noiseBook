import csv
import random

file = open("../data/gdata.txt")
band_names = file.readlines()
file.close()

for band in band_names:
    band = band.replace("\n", "")

# Prepare data
data = []
for band in band_names:
    # Convert band name to a suitable email format
    email = band.replace(" ", "").replace("&", "and").replace(",", "") + "@example.com"
    email = email.lower()
    
    # Generate random boolean
    status = "TRUE" if random.getrandbits(1) else "FALSE"
    
    # Append to data
    data.append([band, email, status])

# Write data to CSV file
with open('../data/groupes_data.csv', 'w', newline='') as file:
    writer = csv.writer(file)
    writer.writerows(data)

