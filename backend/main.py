from fastapi import FastAPI
from pydantic import BaseModel
from api import callAPI
app = FastAPI()

# Define a request model using Pydantic for input validation.
class RecipeRequest(BaseModel):
    # For example, you might expect a list of ingredients.
    data : dict

# POST endpoint at /genRecipe
@app.post("/genRecipe")
async def gen_recipe(request: RecipeRequest):
    response = callAPI(request.data)
    return {
        "message": "Recipe generated successfully!",
        "title":response.title,
        "recipe": response.recipe
        
    }

# Run the app with uvicorn if executed as the main module.
if __name__ == "__main__":
    import uvicorn
    uvicorn.run("main:app", host="127.0.0.1", port=8000, reload=True)
