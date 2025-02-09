# Problem Statement
Many individuals striving to meet specific dietary and macro-nutrient goals—whether for weight loss, muscle gain, or overall health—face significant challenges when it comes to meal planning. Traditional recipe sources and meal planning apps rarely offer solutions that are both nutritionally tailored and creatively appealing. Users are forced to manually adapt or compromise on taste and variety, which can lead to frustration, nutritional imbalances, and eventually, poor adherence to their dietary plans.

Our application addresses this gap by leveraging artificial intelligence to generate recipes that precisely align with user-defined macro requirements while ensuring creativity and palatability. By allowing users to input their desired protein, carbohydrate, and fat targets, the system generates innovative recipes that meet these specifications and enables users to save and revisit their favorite creations. This automated, personalized approach not only simplifies the meal planning process but also supports healthier eating habits by eliminating the need for tedious manual adjustments.


# System Overview

Quick Plate uses a simple and secure system to generate recipes, harnessing the power of AI while leveraging proprietary algorithms to ensure accurate and reliable results. 

### Data

Data was sourced from Health Canada and included extensive informaiton related to a wide variety of foods. Narrowing down our scope for this project ensured we were't dealing with too much when it came to our data. Using search and join techniques native to the Pandas framework we were able to extract the data relevant to our project while keeping room for creativity in the recipe generation.

Through our research we were able to deduce the food groups which were relevant to each macronutrient and further divided them into categories. This process allowed us to ensure we created balanced meals, but also enabled us to incorporate dietary restrictions for the future.

### AI 
After researching various LLM providers, we eventually landed on using OpenRouter. They come with an easy to use api, and have a long list of models available for free limited use. We also tried a variety of models, eventually settling on Llama 3.3 72B due to its relativley fast response times and accuracy. 

Prompting played a  large role in ensuring the LLM provided relevant outputs and stayed on topic. Without prompts the LLMs would tend to deviate from our desired workspace. Creating this persona for the LLM gave an experience that feels tailored to the product, as opposed to just a simple chatbot.

### Backend
 Using Python we were able to rapidly develop a simple endpoint using FastAPI. This helped us seamlessley connect our mobile application to the power of our tailored LLM. 

### Database
Our user data is securley stored on firebase. Leveraging the use of Google sighn-in we created a seamless onboarding expereince. 
This allowed us to securley store data relevant to each client, namely heir recipes. No other data is stored from the client as we deemed it to be an unneccesary security risk. 

# Get Started
In order to use our app you must have the flutter SDK available on your device. Please follow the instructions listed here to get started with flutter ([setup instructions])(https://docs.flutter.dev/get-started/install) 
Once you have the SDK downloaded you should be able to build and deploy the application through the main dart file depending on the platofmr you are on. 

For setting up the API calling and activating the LLM, ensure you have pyhton installed and download the requirements from the requirements.txt file in the /backend folder. 

Once you run the main.py file, the flutter app should have access to all the backend requirements it has. And the app is ready to use!