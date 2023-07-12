# -*- coding:utf-8 -*-
import time,datetime,calendar
#print datetime.datetime.now().strftime('YYYYMMDD')
year = 2019 #指定年份
# year_month = ['%s%s'%(year,i) for i in ['01','02','03','04','05','06','07','08','09','10','11','12']]
year_month = ['%s%s'%(year,i) for i in ['11']]
for i in year_month:#月份循环
    monthRange = calendar.monthrange(int(i[0:4]),int(i[4:6]))
    for num in range(monthRange[1]):
        day = datetime.datetime.strptime('%s-%s-%s'%(i[0:4],i[4:6],'01'),'%Y-%m-%d')+datetime.timedelta(days =+num)
        aa = str(day)[0:10]
        print aa.replace("-", ""),
        # print str(day)[0:10],
    # print '\n'



