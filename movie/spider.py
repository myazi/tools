#!/user/bin env python
# 获取电影天堂详细信息
import requests
import time
from lxml import etree
#import pymysql
import json
import random
requests.adapters.DEFAULT_RETRIES = 5

# 伪装浏览器
HEADERS ={
    #'User-Agent':'Mozilla/5.(Windows NT 10.0; WOW64) AppleWebKit/537.3(KHTML, like Gecko) Chrome/63.0.3239.13Safari/537.36',
    'User-Agent':'Mozilla/5.(Windows NT 10.0; WOW64) AppleWebKit/537.3(KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36',
    'Host':'www.dy2018.com'
}

# 定义全局变量
BASE_DOMAIN = 'https://www.dy2018.com/'

# 获取首页网页信息并解析
def getUrlText(url,coding):
    time.sleep(2)
    s = requests.session()
    #print("获取首页网页信息并解析：", url)
    #print("请求URL：", url)
    respons = s.get(url,  headers=HEADERS)
    if(coding=='c'):
        urlText = respons.content.decode('gbk')
        html = etree.HTML(urlText)  # 使用lxml解析网页
    else:
        urlText = respons.text
        html = etree.HTML(urlText)  # 使用lxml解析网页
    s.keep_alive = False
    return html

# 获取电影详情页的href,text解析
def getHref(url):
    html = getUrlText(url,'t')
    aHref = html.xpath('//table[@class="tbspan"]//a/@href')
    #print("获取电影详情页的href,text解析```")
    htmlAll = map(lambda url:BASE_DOMAIN+url,aHref) # 给每个href补充BASE_DOMAIN
    return htmlAll

key_map = {
        "movie_title" : ["片名","片名","影片原名","原片名","中文名","中文名称","中文片名","中文译名","原名"],
        "translation" : ["译名","别名","外文别名","英文名","英文别名","又名"],
        "director" : ["导演", "编剧"],
        "stars" : ["主演","演员","主要演员"],
        "category" : ["类别","影片类型","类型"],
        "tags" : ["标签"],
        "douban_score" : ["IMDb评分","豆瓣评分","IMDB评分"],
        "movie_place" : ["产地","国家","国家地区","地区"],
        "release_date": ["上映日期","年代","出品年代","上映","上映时间","首映日期","首映"],
        "introduction" : ["简介","电影简介","剧情","剧情介绍","剧情简介","内容介绍","影片简评","主演介绍"],
        "awards" : ["获奖情况","获奖","获奖记录","获得奖项"],
        "language" : ["语言","对白语言"],
        "subtitle" : ["字幕","字幕语言"],
        "file_length" : ["片长","时长","影片时长","影片长度"],
        "other" : ["点评","影片评价","相关评论","一句话评论","影评","影片评论","站长点评","友情提醒","电影花絮","花絮","幕后","幕后故事","幕后花絮","幕后制作","格式","文件格式","配音","视频尺寸","视频大小","文件大小","文件体积","下载地址","迅雷下载地址","影片班底","影片长度","影片级别","影片截图","影片颜色","影片制作","精彩对白","穿帮镜头","导演阐述","关于导演","关于演员","关于影片","关于原著","关于原著作者","精彩对白","惊险一幕","剧本","影片幕后","有关影片","出品公司","发行公司"]
        }

# 使用content解析电影详情页，并获取详细信息数据
def getPage(url):
    html = getUrlText(url,'c')
    movieInfo = {}  # 定义电影信息
    mName = html.xpath('//div[@class="title_all"]//h1/text()')[0]
    movieInfo['movie_name'] = [mName]
    movieInfo['movie_url'] = url
    mDiv = html.xpath('//div[@id="Zoom"]')[0]
    #mImgSrc = mDiv.xpath('.//img/@src')
    #moveInfo['image_path'] = mImgSrc[0]  # 获取海报src地址
    #if len(mImgSrc) >= 2:
    #    moveInfo['screenshot'] = mImgSrc[1]  # 获取电影截图src地址
    mContnent = mDiv.xpath('.//text()')
    def pares_info(info,rule):
        '''
        :param info: 字符串
        :param rule: 替换字串
        :return:  指定字符串替换为空，并剔除左右空格
        '''
        return info.replace(rule,'').strip()
    pre_key = ""
    for index,t in enumerate(mContnent):
        t = t.replace(u'\u200b', '').replace("\r\n","") ##去除无效字符
        stop_key = [" ", "　","◎","【","】",":","："] ##去除修饰符
        for key in stop_key:
            t = t.replace(key,"")
        flag = False
        for key in key_map:
            for v in key_map[key]:
                if t.startswith(v):
                    movieInfo.setdefault(key, [])
                    movieInfo[key].append(pares_info(t,v))
                    flag = True
                    pre_key = key
                    break
            if flag == True:
                break
        if flag == False and pre_key != "":
            movieInfo.setdefault(pre_key, [])
            movieInfo[pre_key].append(t)
    return movieInfo

# 获取前n页所有电影的详情页href
def spider():
    movies = []
    m = 0
    n = 100
    for k in range(0,1):
        #print("index===========" + str(k))
        for i in range(m,n+1):
            if i == 1:
                #url = "https://www.dy2018.com/html/gndy/dyzz/" ##最新
                url = "https://www.dy2018.com/html/gndy/jddyy/" ##经典
                #url = "https://www.dy2018.com/html/gndy/jddy/" ##综合
                #url = "https://www.dy2018.com/" + str(k) + "/"
            else:
                #base_url = 'https://www.dy2018.com/html/gndy/dyzz/index_{}.html' ##最新
                base_url = "https://www.dy2018.com/html/gndy/jddyy/index_{}.html" ##经典
                #base_url = "https://www.dy2018.com/html/gndy/jddy/index_{}.html" ##综合
                #base_url = "https://www.dy2018.com/" + str(k) + "/index_{}.html"
                url = base_url.format(i)
            moveHref = getHref(url)
            #print("休息1s后再进行操作")
            time.sleep(1)
            for index,mhref in enumerate(moveHref):
                try:
                    movie = getPage(mhref)
                except:
                    print("EXCEPT 请求URL：", url)
                    continue
                movies.append(movie)
                print(json.dumps(movie, ensure_ascii=False))

if __name__ == '__main__':
	spider()
