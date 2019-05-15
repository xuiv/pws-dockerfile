# pws-dockerfile
for PWS docker 
```
cf login -a https://api.run.pivotal.io
cf delete appname 
cf push appname --docker-image  xuiv/pws-dockerfile -m 128M -k 256M -f manifest.yml
cf map-route appname xxx.xxx --hostname appname
```
客户端运行
```
gost -L tcp://:7083/:1083 -F quic+wss://appname.xxx.xxx:8443
socat -t 10 udp-listen:7082,reuseaddr,fork tcp:127.0.0.1:7083
udpspeeder -c -l0.0.0.0:7081 -r127.0.0.1:7082  -f20:10 -k "passwd"
gost -L :1080 -F quic://localhost:7081
```
