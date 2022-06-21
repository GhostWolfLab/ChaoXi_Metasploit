# ChaoXi_Metasploit

潮汐平台的Metasploit Docker容器构建

自带apache方便生成木马下载

启动命令：

```
docker run -it --rm -p 7681:7681 -p 4444:4444 -p 80:80 metasploit tini -- ttyd -p 7681 msfconsole
```

7681为ttyd固定端口，4444端口设置为监听端口用于创建监听，80端口为apache端口

启动后打开浏览器访问本机IP地址，docker默认桥接网络，例：http://192.168.8.112:7681，即可通过浏览器进行交互。

注意：生成木马需要使用外部地址，也就是你本机的IP地址，进入msfconsle会话设置监听时设置的lhost为容器的IP地址，可以输入命令

```
cat /etc/hosts
```

启动apache只需要输入命令

```
service apache2 start
```

将木马生成到/var/www/html/下即可下载。
