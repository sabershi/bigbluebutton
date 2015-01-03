sudo chmod -R ugo+rwx /var/bigbluebutton
sudo chmod -R ugo+rwx /var/log/bigbluebutton
grails war
echo "grails war done;"
mv target/bigbluebutton-0.9.0.war target/bigbluebutton.war
echo "----bigbluebutton.war done!";
sudo cp target/bigbluebutton.war /var/lib/tomcat7/webapps
NGINX_IP=$(cat /etc/nginx/sites-available/bigbluebutton | sed -n '/server_name/{s/.*name[ ]*//;s/;//;p}')
echo "nginx ip is $NGINX_IP"

Salt=$(cat /var/lib/tomcat7/webapps/bigbluebutton/WEB-INF/classes/bigbluebutton.properties | grep securitySalt | cut -d= -f2)
echo "salt is $Salt"

sudo service tomcat7 restart
sudo sudo bbb-conf --setip $NGINX_IP
sudo bbb-conf --setsecret $Salt
sudo bbb-conf --check
