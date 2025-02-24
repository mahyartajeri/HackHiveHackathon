from openai import OpenAI

client = OpenAI(
    base_url="https://openrouter.ai/api/v1",
    api_key="YOUR_KEY_HERE",
)

completion = client.chat.completions.create(
    #   extra_headers={
    #     "HTTP-Referer": "<YOUR_SITE_URL>", # Optional. Site URL for rankings on openrouter.ai.
    #     "X-Title": "<YOUR_SITE_NAME>", # Optional. Site title for rankings on openrouter.ai.
    #   },
    #   extra_body={},
    model="deepseek/deepseek-r1-distill-llama-70b:free",
    messages=[
        {"role": "user", "content": "Give me a high protein meal for breakfasty"},
        {
            "role": "system",
            "content": "Return your recipes speaking in a lot of slang and abbreviations",
        },
    ],
)
print(completion)
