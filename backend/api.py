'''
EXPECTED:

Instructions

Ingredient list

'''
'''
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
GROUPS = {
    "Calories": [20],
    "Carbs":[12, 20, 18],
    "Protein":[1, 5, 7, 13, 15, 17],
    "Fats":[4, 7],
    "Fibre":[9, 11, 16, 12]
}

USER_REQUEST = {
  "Calories": 1000,
    "Carbs": 50,
    "Protein": 50,
    "Fats": 15,
    "Fibre": 10
}


NUTRITION_RANGES = {
    "Calories": (300, 1500),
    "Carbs": (10, 150),
    "Protein": (0, 150),
    "Fats": (5, 100),
    "Fibre": (0, 30)
}

def avgOfRange(num_range):
    return num_range[0] + num_range[1] / 2

import time
import pandas as pd
import random
foods_df = pd.read_csv("backend/db/combined_food_nutrients.csv")
top_x = len(foods_df) // 2
 
selection = []
    
def getIngredients(macro_request):
    
    for macro in USER_REQUEST:
        top_modifier = False
        food = ""
        food_group = random.choice(GROUPS[macro])
        #Check if they need "high" amount for this macro
        if USER_REQUEST[macro] > avgOfRange(NUTRITION_RANGES[macro]):
            top_modifier = True
            
        # Filter the foods to include only those in the selected food group
        filtered_foods = foods_df[foods_df['FoodGroupID'] == food_group]
        
        if top_modifier:

            # From the filtered foods, select the top_x rows with the highest values for the current macro nutrient
            top_foods = filtered_foods.nlargest(top_x, macro)
            
            # Randomly sample one food from these top candidates
            food = top_foods.sample(n=1).copy()

            
        else:
            food = filtered_foods.sample(n=1).copy()
            
        #add food name to selectoins
        selection.append(food.iloc[0]["FoodDescription"])
        
        
def formatPrompt(requestedMacros) :
    
    ingredientsToUse = getIngredients(requestedMacros)
    
    final_prompt = "Create a recipe based on theese macros: "
    
    for macro in requestedMacros:
        final_prompt += f"{macro}: {requestedMacros[macro]}, "
    
    final_prompt += "and these ingredients: "
    
    for ingredient in ingredientsToUse:
        final_prompt += f"{ingredient}, "
        
    return final_prompt
        
    
import re
def sectionedOutput(recipe_text):
    # Capture the dish name (assuming it always follows "Recipe:" and is enclosed in **)
    dish_match = re.search(r"\*\*(.*?)\*\*", recipe_text)
    dish_name = dish_match.group(1).strip() if dish_match else "Dish name not found"

    print("Dish Name:")
    print(dish_name)
    return dish_name


      
    
    
    
from openai import OpenAI
import prompts
client = OpenAI(
base_url="https://openrouter.ai/api/v1",
api_key="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",
)
def callAPI (requestedMacros):

    formattedUserPrompt = formatPrompt(requestedMacros)
    
    # client = OpenAI(
    # base_url="https://openrouter.ai/api/v1",
    # api_key="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",
    # )

    completion = client.chat.completions.create(
    #   extra_headers={
    #     "HTTP-Referer": "<YOUR_SITE_URL>", # Optional. Site URL for rankings on openrouter.ai.
    #     "X-Title": "<YOUR_SITE_NAME>", # Optional. Site title for rankings on openrouter.ai.
    #   },
    #   extra_body={},
        model = "meta-llama/llama-3.3-70b-instruct:free",
        # model="deepseek/deepseek-r1-distill-llama-70b:free",
        messages=[
            {
            "role": "user",
            "content": formattedUserPrompt
            },
            prompts.formatted_prompts
        ]
    )
    output = completion.choices[0].message.content
    print(output)
    
    sectionedOutput(output)
    
    # print("***********************************************\n")
    
    # #sectionedOutput(completion.choices[0].message.content)
    # time.sleep(30)
    # return refineOutput(completion.choices[0].message.content)
    

# def refineOutput (aiOutput):
    
#     prompt = f"Given this recipe consolidate the data so it is simple to parse based on the system prompts: \n{aiOutput}"
    
    
#     # client = OpenAI(
#     # base_url="https://openrouter.ai/api/v1",
#     # api_key="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",
#     # )

#     completion = client.chat.completions.create(
#         model = "deepseek/deepseek-chat:free",
#         # model="deepseek/deepseek-r1-distill-llama-70b:free",
#         messages=[
#             {
#             "role": "user",
#             "content": prompt
#             },
#             prompts.secondary_formatted_prompts
#         ]
#     )
    
    
#     print(completion.choices[0].message.content)
       
# prompt = formatPrompt(USER_REQUEST, selection)

# print(prompt)

# callAPI(prompt)




