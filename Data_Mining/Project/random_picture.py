import random
import requests
from bs4 import BeautifulSoup
import urllib.request
import time

url = "http://rrcrossings.woodhavenmi.org/allen.jpg?rnd="

for i in range(5):
    print(i)
    time.sleep(5)
    urllib.request.urlretrieve(url,'./images/image'+str(i)+'.jpeg')





