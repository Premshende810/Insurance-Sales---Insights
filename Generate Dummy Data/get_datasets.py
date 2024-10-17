import random
from faker import Faker
import pandas as pd
 
# Initialize Faker
fake = Faker()
 
# Define the number of records to generate for each table
num_agents = 1250
num_customers = 52640
num_policies = 52640
num_payments = 52640
num_profit_loss = 650
num_life_insurance = 26320
num_healthcare = 13160
num_cars = 4300
num_houses = 2280
num_transactions = 52640
num_revenue = 650
num_expenses = 650
 
 
# Define a function to generate 10-digit phone numbers
def generate_phone_number():
    return ''.join([str(random.randint(0, 9)) for _ in range(10)])
 
# Define functions to generate fake data for each table
 
# Table: Agent (new columns: gender, address, city, state, country)
def generate_agents(n):
    agents = []
    for _ in range(n):
        agents.append({
            'agent_id': fake.unique.random_int(min=228728, max=1000000),
            'first_name': fake.first_name(),
            'last_name': fake.last_name(),
            'user_name': fake.user_name(),
            'phone': generate_phone_number(),  # Generate 10-digit phone number
            'gender': random.choice(['Male', 'Female', 'Other']),  # Gender column
            'address': fake.street_address(),  # New address field
            'city': fake.city(),               # New city field
            'state': fake.state(),             # New state field
            'country': fake.country(),         # New country field
        })
    return agents
 
# Generate agents and store their IDs for foreign key references
agents = generate_agents(num_agents)
agent_ids = [agent['agent_id'] for agent in agents]
 
# Table: Customer (ensure agent_id references an existing agent and new columns: gender, country)
def generate_customers(n):
    customers = []
    for _ in range(n):
        customers.append({
            'cust_id': fake.unique.random_int(min=1834782, max=100000000),
            'agent_id': random.choice(agent_ids),  # Valid agent_id
            'policy_num': None,  # To be updated after generating policies
            'first_name': fake.first_name(),
            'last_name': fake.last_name(),
            'user_name': fake.user_name(),
            'dob': fake.date_of_birth(minimum_age=18, maximum_age=90),
            'phone': generate_phone_number(),  # Generate 10-digit phone number
            'city': fake.city(),
            'state': fake.state(),
            'zip': fake.zipcode(),
            'dl_num': fake.license_plate(),
            'ssn': fake.ssn(),
            'gender': random.choice(['Male', 'Female', 'Other']),  # New gender field
            'country': fake.country(),                             # New country field
        })
    return customers
 
# Generate customers and store their IDs
customers = generate_customers(num_customers)
customer_ids = [customer['cust_id'] for customer in customers]
 
# Table: Policy (ensure cust_id and agent_id are valid)
def generate_policies(n, customer_ids, agent_ids):
    policies = []
    for _ in range(n):
        policies.append({
            'policy_num': fake.unique.random_int(min=1723729, max=100000000),
            'payment_id': None,  # To be updated after generating payments
            'cust_id': random.choice(customer_ids),  # Valid cust_id
            'agent_id': random.choice(agent_ids),  # Valid agent_id
            'type': random.choice(['Health', 'Car', 'Home']),
            'coverage': random.choice(['Basic', 'Premium', 'Gold']),
            'term_price': round(random.uniform(100.0, 10000.0), 2),
            'issued_date': fake.date_this_decade(),
            'deductible': round(random.uniform(500.0, 5000.0), 2),
        })
    return policies
 
# Generate policies and store their IDs
policies = generate_policies(num_policies, customer_ids, agent_ids)
policy_ids = [policy['policy_num'] for policy in policies]
 
# Update customers with policy numbers after generating policies
for customer in customers:
    customer['policy_num'] = random.choice(policy_ids)
 
# Table: Payment (ensure cust_id and policy_num are valid)
def generate_payments(n, customer_ids, policy_ids):
    payments = []
    for _ in range(n):
        payments.append({
            'payment_id': fake.unique.random_int(min=23792221, max=100000000),
            'cust_id': random.choice(customer_ids),  # Valid cust_id
            'payment_date': fake.date_this_year(),
            'policy_num': random.choice(policy_ids),  # Valid policy_num
            'payment_amount': round(random.uniform(50.0, 500.0), 2),
        })
    return payments
 
# Generate payments and store their IDs
payments = generate_payments(num_payments, customer_ids, policy_ids)
payment_ids = [payment['payment_id'] for payment in payments]
 
# Update policies with payment_id after generating payments
for policy in policies:
    policy['payment_id'] = random.choice(payment_ids)
 
# Table: Health_care (ensure cust_id and policy_num are valid)
def generate_healthcare(n, customer_ids, policy_ids):
    healthcare = []
    for _ in range(n):
        healthcare.append({
            'report_id': fake.unique.random_int(min=45893, max=1000000),
            'policy_num': random.choice(policy_ids),  # Valid policy_num
            'cust_id': random.choice(customer_ids),  # Valid cust_id
            'date': fake.date_this_year(),
        })
    return healthcare
 
 
healthcare=generate_healthcare(num_healthcare, customer_ids, policy_ids)
 
# Table: Car (ensure cust_id and policy_num are valid)
def generate_cars(n, customer_ids, policy_ids):
    cars = []
    for _ in range(n):
        cars.append({
            'vehicle_id': fake.unique.random_int(min=1347739, max=10000000),
            'policy_num': random.choice(policy_ids),  # Valid policy_num
            'cust_id': random.choice(customer_ids),  # Valid cust_id
            'make': fake.company(),
            'model_num': fake.bothify(text='???-###'),
            'doors': random.choice([2, 4]),
            'year': fake.year(),
            'color': fake.color_name(),
        })
    return cars
 
cars=generate_cars(num_cars, customer_ids, policy_ids)
 
# Table: House (ensure cust_id and policy_num are valid)
def generate_houses(n, customer_ids, policy_ids):
    houses = []
    for _ in range(n):
        houses.append({
            'house_id': fake.unique.random_int(min=334873, max=1000000),
            'cust_id': random.choice(customer_ids),  # Valid cust_id
            'policy_num': random.choice(policy_ids),  # Valid policy_num
            'house_cost': round(random.uniform(50000.0, 500000.0), 2),
        })
    return houses
 
houses=generate_houses(num_houses, customer_ids, policy_ids)
 
# Table: Life_Insurance (ensure cust_id, agent_id, and policy_num are valid)
def generate_life_insurance(n, customer_ids, policy_ids, agent_ids):
    life_insurance = []
    for _ in range(n):
        life_insurance.append({
            'life_policy_id': fake.unique.random_int(min=4587338, max=1000000000),
            'policy_num': random.choice(policy_ids),  # Valid policy_num
            'cust_id': random.choice(customer_ids),   # Valid cust_id
            'agent_id': random.choice(agent_ids),     # Valid agent_id
            'coverage_amount': round(random.uniform(10000.0, 1000000.0), 2),
            'premium': round(random.uniform(100.0, 10000.0), 2),
            'term_length': random.randint(1, 30),  # Duration of policy in years
            'beneficiary_name': fake.name(),
            'issue_date': fake.date_this_decade(),
        })
    return life_insurance
 
# Generate life insurance policies
life_insurance = generate_life_insurance(num_life_insurance, customer_ids, policy_ids, agent_ids)
 
# Table: Sales Transactions (ensure cust_id is valid)
def generate_sales_transactions(n, customer_ids):
    transactions = []
    for _ in range(n):
        transactions.append({
            'transaction_id': fake.unique.uuid4(),
            'cust_id': random.choice(customer_ids),  # Valid cust_id
            'product_id': fake.unique.uuid4(),
            'sale_date': fake.date_this_year(),
            'quantity': random.randint(1, 10),
            'total_price': round(random.uniform(10.0, 1000.0), 2),
        })
    return transactions
 
transactions= generate_sales_transactions(num_transactions, customer_ids)
 
# Table: Revenue (ensure cust_id and policy_num are valid)
def generate_revenue(n, customer_ids, policy_ids):
    revenue = []
    for _ in range(n):
        revenue.append({
            'revenue_id': fake.unique.uuid4(),
            'policy_num': random.choice(policy_ids),  # Valid policy_num
            'cust_id': random.choice(customer_ids),  # Valid cust_id
            'revenue_amount': round(random.uniform(500.0, 5000.0), 2),
        })
    return revenue
 
revenue=generate_revenue(num_revenue, customer_ids, policy_ids)
 
# Table: Expenses (ensure cust_id, policy_num, agent_id are valid, new description field)
def generate_expenses(n, customer_ids, policy_ids, agent_ids):
    expenses = []
    for _ in range(n):
        expenses.append({
            'expense_id': fake.unique.uuid4(),
            'cust_id': random.choice(customer_ids),  # Valid cust_id
            'policy_num': random.choice(policy_ids),  # Valid policy_num
            'agent_id': random.choice(agent_ids),  # Valid agent_id
            'expense_type': random.choice(['Salary', 'Maintenance', 'Utility', 'Marketing']),
            'amount': round(random.uniform(100.0, 5000.0), 2),
            'description': fake.text(max_nb_chars=100),  # New description field
            'date': fake.date_this_year(),
        })
    return expenses
 
# Generate expenses and store them
expenses = generate_expenses(num_expenses, customer_ids, policy_ids, agent_ids)
 
# Table: Profit and Loss (ensure cust_id, policy_num, agent_id are valid)
def generate_profit_loss(n, customer_ids, policy_ids, agent_ids):
    profit_loss = []
    for _ in range(n):
        total_revenue = round(random.uniform(5000.0, 20000.0), 2)
        total_expenses = round(random.uniform(1000.0, 15000.0), 2)
        profit_or_loss = total_revenue - total_expenses
        profit_loss.append({
            'cust_id': random.choice(customer_ids),  # Valid cust_id
            'policy_num': random.choice(policy_ids),  # Valid policy_num
            'agent_id': random.choice(agent_ids),     # Valid agent_id
            'total_revenue': total_revenue,
            'total_expenses': total_expenses,
            'profit_loss': profit_or_loss,
        })
    return profit_loss
 
# Generate profit and loss records
profit_loss = generate_profit_loss(num_profit_loss, customer_ids, policy_ids, agent_ids)
 
# Example of converting data to pandas DataFrame for further use
df_agents = pd.DataFrame(agents)
df_customers = pd.DataFrame(customers)
df_policies = pd.DataFrame(policies)
df_life_insurance = pd.DataFrame(life_insurance)
df_payments = pd.DataFrame(payments)
df_healthcare = pd.DataFrame(healthcare)
df_cars = pd.DataFrame(cars)
df_houses = pd.DataFrame(houses)
df_sales_transactions = pd.DataFrame(transactions)
df_revenue = pd.DataFrame(revenue)
df_expenses = pd.DataFrame(expenses)
df_profit_loss = pd.DataFrame(profit_loss)
 
# You can save the data to CSV files, or directly insert into your database
 
 
 
df_agents.to_csv("C:/Users/2261397/OneDrive - Cognizant/Desktop/insurance_data/data/agents.csv",index=False)
df_customers.to_csv("C:/Users/2261397/OneDrive - Cognizant/Desktop/insurance_data/data/customers.csv",index=False)
df_policies.to_csv("C:/Users/2261397/OneDrive - Cognizant/Desktop/insurance_data/data/policies.csv",index=False)
df_life_insurance.to_csv("C:/Users/2261397/OneDrive - Cognizant/Desktop/insurance_data/data/life_insurance.csv",index=False)
df_payments.to_csv("C:/Users/2261397/OneDrive - Cognizant/Desktop/insurance_data/data/payments.csv",index=False)
df_healthcare.to_csv("C:/Users/2261397/OneDrive - Cognizant/Desktop/insurance_data/data/healthcare.csv",index=False)
df_cars.to_csv("C:/Users/2261397/OneDrive - Cognizant/Desktop/insurance_data/data/cars.csv",index=False)
df_houses.to_csv("C:/Users/2261397/OneDrive - Cognizant/Desktop/insurance_data/data/houses.csv",index=False)
df_sales_transactions.to_csv("C:/Users/2261397/OneDrive - Cognizant/Desktop/insurance_data/data/transactions.csv",index=False)
df_revenue.to_csv("C:/Users/2261397/OneDrive - Cognizant/Desktop/insurance_data/data/revenue.csv",index=False)
df_expenses.to_csv("C:/Users/2261397/OneDrive - Cognizant/Desktop/insurance_data/data/expenses.csv",index=False)
df_profit_loss.to_csv("C:/Users/2261397/OneDrive - Cognizant/Desktop/insurance_data/data/profit_loss.csv",index=False)
