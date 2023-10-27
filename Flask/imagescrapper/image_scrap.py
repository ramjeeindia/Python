import requests
from bs4 import BeautifulSoup
from urllib.request import urlopen as uReq
import os 

save_dir = "images/"
if not os.path.exists(save_dir):
    os.makedirs(save_dir)

query = "Ramjee Singh"
response = requests.get(f"https://www.google.com/search?q={query}&sxsrf=AJOqlzUuff1RXi2mm8I_OqOwT9VjfIDL7w:1676996143273&source=lnms&tbm=isch&sa=X&ved=2ahUKEwiq-qK7gaf9AhXUgVYBHYReAfYQ_AUoA3oECAEQBQ&biw=1920&bih=937&dpr=1#imgrc=1th7VhSesfMJ4M")


soup = BeautifulSoup(response.content,'html.parser')

images_tages = soup.find_all("img")

del images_tages[0]


for i in images_tages:
    images_url = i['src']
    image_data = requests.get(images_url).content
    with open(os.path.join(save_dir , f"{query}_{images_tages.index(i)}.jpg"), "wb") as f :
        f.write(image_data)
    