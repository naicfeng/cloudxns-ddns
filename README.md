# cloudxns-ddns

cloudxns的简易ddns客户端
参考了

https://www.xdty.org/1907

http://www.anrip.com/ddnspod




##使用方法

修改cloudxns.conf里的API信息

然后在cloudxns.sh底部添加需要解析的域名



###例：

根域

```
DdnsCheck "weicn.org"
```

子域

```
DdnsCheck "weicn.org" "www"
```


依次添加即可
