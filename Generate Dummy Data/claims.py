import random
from faker import Faker
import pandas as pd
 
fake = Faker()
 
def generate_claims(n):
    claims = []
    for _ in range(n):
        claims.append({
            'claim_id': fake.unique.random_int(min=100000, max=999999),
            'policy_num': fake.unique.random_int(min=100000, max=999999),  # Valid policy_num
            'claim_type': random.choice(['Accident', 'Theft', 'Damage', 'Natural Disaster']),
            'claim_date': fake.date_this_year(),
            'claim_status': random.choice(['Pending', 'Approved', 'Denied']),  # Claim status field
        })
    return claims
 
# Define number of claims to generate
num_claims = 52640  # Adjust as needed
 
# Generate claims data
claims = generate_claims(num_claims)
 
# Convert claims data to DataFrame
df_claims = pd.DataFrame(claims)
 
# Save claims data to CSV
df_claims.to_csv("C:/Users/2261151/OneDrive - Cognizant/Desktop/insurance_data/data/claims.csv", index=False)
 
