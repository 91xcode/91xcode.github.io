import re
import os
import csv
import requests
import pytesseract
from PIL import Image
from lxml import etree


class Ruroom_Spider(object):
    def __init__(self):
        self.url = 'http://www.ziroom.com/z/z1-s100001-u9|10-p%s/?p=t1&qwd=新宫地铁站'
        self.headers = {'User-Agent': 'Mozilla/5.0'}
        self.html_str = ['-0px', '-21.4px', '-42.8px', '-64.2px', '-85.6px', '-107px', '-128.4px', '-149.8px', '-171.2px',
                         '-192.6px']
        self.photo_num = ''
        self.i = 0

    def start_url(self):
        for page in range(1,2):
            url = self.url%(str(page))
            self.get_html(url)

    def get_html(self,url):
        res = requests.get(url, headers=self.headers)
        res.encoding = 'utf-8'
        html = res.text
        self.i +=1

        print ('====== 开始下载图片数据 ========')
        self.download_photo(html)
        print ('====== 开始html数据 ========')
        print(self.photo_num)
        self.get_html_data(html)

    def download_photo(self, html):
        '''
        :param html:  html页面信息
        :return:        提取图片链接，下载图片
        '''
        result = re.findall('<span class="num" style="background-image: url\((.*?)\)', html)[0]
        photo_name = result.split('/')[-1]
        photo_url = 'http:' + result
        res = requests.get(url=photo_url, headers=self.headers)
        res.encoding = 'utf-8'
        with open(photo_name, 'wb')as f:
            f.write(res.content)
            print('%s下载成功' % photo_name)


        self.get_photo_num(photo_name)


    def get_photo_num(self, photo):
        print ('====== 开始get_photo_num ========')
        img = Image.open("/Users/liubing/tools/ziroom/"+photo)
        photo_num = pytesseract.image_to_string(img, config='--psm 7')
        # string = ''
        # while True:
        #     for num in photo_num:
        #         if num == ' ':
        #             pass
        #         else:
        #             string += num
        #     if not len(string) == 10:
        #         string = ''
        #         continue
        #     else:
        #         break
        self.photo_num = photo_num


    def get_html_data(self, html):

        parse_html = etree.HTML(html)

        price_dict = {}
        for k, v in zip(self.html_str, self.photo_num):
            price_dict[k] = v
        # print(price_dict)
        html_price = re.findall('<span class="rmb">￥</span>(.*?)</div>', html, re.S)

        room_price = []
        for price in html_price:
            result = re.findall('background-position: (.*?)"></span>', price, re.S)
            room_price.append(result)
        print("我是room_price",room_price)

        string = ''
        real_price = []
        for price in room_price:
            for num in price:
                string += price_dict[num]
            real_price.append('price：'+ string + '元')
            string = ''
        print(self.i)
        print(real_price)


        titles = []
        area_floors = []
        subway_meters = []
        house_info = parse_html.xpath('/html/body/section/div[3]/div[2]/div/div[2]')
        for info in house_info:
            title = info.xpath('./h5/a/text()')[0]
            area_floor = info.xpath('./div[1]/div[1]/text()')[0]
            subway_meter = info.xpath('/html/body/section/div[3]/div[2]/div[1]/div[2]/div[1]/div[2]/text()')[0].strip(
                '\n').split()[0]
            titles.append('house_info：'+ title)
            area_floors.append('area_floor：' + area_floor)
            subway_meters.append('subway_meter：'+subway_meter)

        for n,a,p,s in zip(titles,area_floors,real_price,subway_meters):
            print(n,a,p,s)
            with open('ZIROOM00.csv','a+',newline='',encoding='utf-8') as f:
                writer = csv.writer(f)
                writer.writerow([(n),(a),(p),(s)])


    def main(self):
        self.start_url()


if __name__ == '__main__':
    spider = Ruroom_Spider()
    spider.main()
