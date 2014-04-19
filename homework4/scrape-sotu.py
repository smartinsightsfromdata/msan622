from bs4 import BeautifulSoup as bs
import requests

url = 'http://www.presidency.ucsb.edu/sou.php'
request = requests.get(url)
soup = bs(request.content)
table = soup.find('table', attrs={'width': '800'})
for x in table.findAll('a')[2:]:
    if x.string:
        print x.string
        request2 = requests.get(x.attrs['href'])
        soup2 = bs(request2.content)
        content = soup2.find('span', class_='displaytext')
        with open('sotu/sotu' + x.string + '.txt', 'w+') as f:
            f.writelines([z.encode('utf-8') + '\n' for z in content.stripped_strings])
