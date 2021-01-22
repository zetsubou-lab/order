#!/usr/bin/env bash
#����+������Ŀվ��
 
#��Ҫ�������²���
# ��Ŀ·��, ��Execute Shell��������Ŀ·��, pwd �Ϳ��Ի�ø���Ŀ·��
export PROJ_PATH=/usr/java/tomcat/apache-tomcat-9.0.41/webapps/jenkins/workspace
 
# ������Ļ�����tomcat��ȫ·��
export TOMCAT_APP_PATH=/usr/java/tomcat/apache-tomcat-9.0.41
 
### base ����
killTomcat()
{
    #pid=`ps -ef|grep tomcat|grep java|awk '{print $2}'`
    #echo "tomcat Id list :$pid"
    #if [ "$pid" = "" ]
    #then
    #  echo "no tomcat pid alive"
    #else
    #  kill -9 $pid
    #fi
    #����ע�͵Ļ��������
    cd $TOMCAT_APP_PATH/bin
    sh shutdown.sh
}
cd $PROJ_PATH/order
mvn clean install
 
# ͣtomcat
killTomcat
 
# ɾ��ԭ�й���
rm -rf $TOMCAT_APP_PATH/webapps/ROOT
rm -f $TOMCAT_APP_PATH/webapps/ROOT.war
rm -f $TOMCAT_APP_PATH/webapps/order.war
 
# �����µĹ��̵�tomcat��
cp $PROJ_PATH/order/target/order.war $TOMCAT_APP_PATH/webapps/
 
cd $TOMCAT_APP_PATH/webapps/
mv order.war ROOT.war
 
# ����Tomcat
cd $TOMCAT_APP_PATH/
sh bin/startup.sh