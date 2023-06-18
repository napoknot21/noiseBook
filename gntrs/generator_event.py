from faker import Faker
import csv

# Instantiate Faker
fake = Faker()

# Prepare data
data = []

for _ in range(1000):  # Change this number to generate more or less rows
    nom = fake.company()  # Use a fake company name as the place name
    city = fake.city()  # Generate a fake address
    capacite = fake.random_int(min=50, max=5000, step=10)  # Capacity ranges from 50 to 5000 with a step of 10

    # Append to data
    data.append([nom, city, capacite])

# Write data to CSV file
with open('../data/lieux_data.csv', 'w', newline='') as file:
    writer = csv.writer(file)
    writer.writerow(["name_p","city_p","cp_p"])
    writer.writerows(data)