import duckduckgo_search as ds

def get_first_image_url(query):
    # Create an instance of DDGS
    ddgs = ds.DDGS()
    # Fetch image results, asking for only one result
    results = ddgs.images(keywords=query)
    # Return the URL of the first image if available
    return results[0]['image'] if results else None

if __name__ == "__main__":
    query = "puppies"
    image_url = get_first_image_url(query)
    if image_url:
        print("First image URL:", image_url)
    else:
        print("No image found.")

