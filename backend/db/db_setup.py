#FOOD_SOURCE : 22  - FOOD AVAILABLE IN THE CANADIAN FOOD SUPPLY, MAJOR NUTRIENTS ANALYZED IN THE CANADIAN PRODUCT
'''
FOOD_GROUPS:
1 - Dairy and Egg Products
2 - Spices and Herbs
4 - Fats and Oils
5 - Poultry Products
7 - Sausages and Luncheon Meats
9 - Fruits and fruit juices
10 - Pork Products
11 - Vegetables and Vegatable Products
12 - Nuts and Seeds
13 - Beef Products
15 - Finfish and Shellfish
16 - Legumes and Legume products
17 - Lamb, Veal, and Game
18 - Baked Products
20 - Cereals, Grains, and Pasta
'''

'''
NUTRIENT_IDs:
203 - protein
204 - fat
205 - carbs
208 - kCal
269 - total sugar
291 - fiber
'''


'''
Self made categories

###High Carb###
Nuts and Seeds
Cereals, Grains, and Pasta
Baked Products

###Fats### 
Fats and Oils
Pork Products
Sausages and Luncheon Meats

###High Protein###
Dairy and Egg Products
Poultry
Sausages and Luncheon Meats
Pork Products
Beef Products
Finfish and Shellfish
Lamb, Veal, and Game

###Fiber###
Fruits and fruit juices
Vegetables and Vegetable products
Legumes and Legume products
Nuts and Seeds

'''
'''
TO_JOIN 
FOOD NAME
NUTRIENT AMOUNT
'''

import pandas as pd
import os

print(os.getcwd())
# Read in the CSV files into DataFrames

food_df = pd.read_csv("backend/db/FOOD_NAME.csv", encoding='latin1')           # contains food IDs and related info
nutrient_amount_df = pd.read_csv("backend/db/NUTRIENT_AMOUNT.csv", encoding='latin1')  # contains food_id, nutrient_id, and amount
nutrient_name_df = pd.read_csv("backend/db/NUTRIENT_NAME.csv", encoding='latin1')      # contains nutrient_id and nutrient_name

# Merge nutrient amounts with nutrient names to get descriptive column names.
merged_nutrients = pd.merge(nutrient_name_df,nutrient_amount_df,
                            on="NutrientID", how="inner")

# Pivot the merged data so that each food_id is a single row and each nutrient becomes a column.
# If a food has multiple entries for the same nutrient, you can decide on an aggregation function.
pivot_df = merged_nutrients.pivot_table(index="FoodID",
                                        columns="NutrientName",
                                        values="NutrientValue",
                                        aggfunc="first").reset_index()

# Merge the pivoted nutrient data with the food data on food_id.
final_df = pd.merge(food_df, pivot_df, on="FoodID", how="left")

# Save the final DataFrame to a new CSV file.
final_df.to_csv("combined_food_nutrients.csv", index=False)
