import httpx
import asyncio

async def fetch_data():
    url = "https://openrouter.ai/api/v1/auth/key"
    headers = {
        "Authorization": "Bearer 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"  # replace with your API key
    }
    
    async with httpx.AsyncClient() as client:
        response = await client.get(url, headers=headers)
        if response.status_code == 200:
            print(response.json())
        else:
            print(f"Error {response.status_code}: {response.text}")

asyncio.run(fetch_data())
