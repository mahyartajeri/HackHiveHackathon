from fastapi import FastAPI
from pydantic import BaseModel
from api import callAPI
import json

app = FastAPI()


# Define a request model using Pydantic for input validation.
class RecipeRequest(BaseModel):
    # One field called data, which is a json string.
    data: str


# POST endpoint at /genRecipe
@app.post("/genRecipe")
async def gen_recipe(request: RecipeRequest):
    # convert data from json string to python dict

    response = callAPI(json.loads(request.data))
    # print(response)
    return {
        "message": "Recipe generated successfully!",
        "title": response["title"],
        "recipe": response["recipe"],
        "timestamp": response["timestamp"],
        "imageUrl": response["image"],
    }


# Run the app with uvicorn if executed as the main module.
if __name__ == "__main__":
    import uvicorn

    uvicorn.run("main:app", host="0.0.0.0", port=8000, reload=True)
