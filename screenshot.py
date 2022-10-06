# # importing webdriver from selenium
from selenium import webdriver
 
# from PIL import Image
 
# # Here Chrome  will be used
# driver = webdriver.Chrome()
 
# # URL of website
# url = "http://rrcrossings.woodhavenmi.org/"
 
# # Opening the website
# driver.get(url)
 
# driver.save_screenshot("image.png")
 
# # Loading the image
# image = Image.open("image.png")
 
# w,h = image.size

# top = 450
# bottom = 550
# left = (w/2)+180
# right = (w/2)+280

# print((left, top, right, bottom))

# image = image.crop((left, top, right, bottom))

# # print(image.histogram())

# print(len(image.histogram()))

# # Showing the image
# image.show()

from bs4 import BeautifulSoup
import urllib.request

driver = webdriver.Chrome()
 
url = "http://rrcrossings.woodhavenmi.org/"
 
driver.get(url)

soup = BeautifulSoup(driver.page_source)

image_url = ""
images = []
for img in soup.findAll('img'):
    if(img.get('src')[0] == 'a'):
        image_url = url+img.get('src')
        break

urllib.request.urlretrieve(s,'./image.jpeg')

driver.quit()