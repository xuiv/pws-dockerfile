# pws-dockerfile
for PWS docker 

cf login -a https://api.run.pivotal.io
cf delete appname 
cf push appname --docker-image  xuiv/pws-dockerfile -m 128M -k 256M
cf map-route appname xxx.xxx --hostname appname
