import csv
from faker import Faker
import random

# Create a Faker instance to generate random data
faker = Faker()

# Generate random data for Utilisateur table
utilisateur_data = []
for _ in range(1000):
    name = faker.name()
    email = faker.email()
    utilisateur_data.append((name, email))

# Export data to CSV files
utilisateur_file = "../data/utilisateur_data.csv"

with open(utilisateur_file, "w", newline="") as csvfile:
    writer = csv.writer(csvfile)
    writer.writerow(["name_user", "email"])
    writer.writerows(utilisateur_data)

print(f"[*] Data generated and exported to {utilisateur_file} CSV file succesfully!")

