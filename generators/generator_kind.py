import csv

# Prepare data
genres = ["Blues", "Classical", "Country", "Electronic", "Hip hop", "Jazz", "Pop", "Reggae", "Rock", "Soul"]

# Prepare data for writing to the CSV.
data = [[genre] for genre in genres]

# Write data to CSV file
with open('../data/genders_data.csv', 'w', newline='') as file:
    writer = csv.writer(file)
    writer.writerow(["name_genre"])
    writer.writerows(data)