# 91xcode.github.com



'''
由于chrome浏览器不支持跨域url访问，因此请使用safr或者windows edge 浏览器，某些链接可能失效。






github pages自动使用https 而访问http的链接报错 以及Chrome浏览器DPlayer在https网页播放http的m3u8视频失败相关MixedContent和CORS问题记录

问题：网站首页用DPlayer来播放直播流，发现Safri和UC等浏览器都可以播放成功。但是Chrome浏览器却提示错误：

hls.js@latest:1 Mixed Content: The page at ‘https://www.yuv420.com/' was loaded over HTTPS, but requested an insecure XMLHttpRequest endpoint ‘http://ivi.bupt.edu.cn/hls/cctv10.m3u8'. This request has been blocked; the content must be served over HTTPS.

原因：Mixed Content 和CORS 问题导致。

解决方案：目前还没有找到比较好的方案。  Safri浏览器 暂时可以


参考：https://segmentfault.com/q/1010000005872734

'''