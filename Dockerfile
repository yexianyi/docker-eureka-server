# This docker file is for creating springboot based websocket
FROM yexianyi/oracle-jdk:centos7

ARG GIT_PROJECT_URL=https://github.com/yexianyi/Chukonu.git
ARG SOURCE_PATH=/home/Chukonu
ARG SOURCE_PATH_1=$SOURCE_PATH/chukonu-springcloud-eureka-server
ARG TARGET_JAR_NAME=chukonu-springcloud-eureka-server.jar

ARG JDK_INSTALL_PATH=/usr/lib/java
ENV RUNNABLE_JAR_FILE=$TARGET_JAR_NAME
ENV CONSUL_AGENT=localhost
ENV JAVA_HOME=$JDK_INSTALL_PATH/jdk1.8.0_131
ENV PATH=$JAVA_HOME/bin:$PATH


MAINTAINER Xianyi Ye <https://cn.linkedin.com/in/yexianyi>
ADD https://api.github.com/repos/yexianyi/Chukonu/git/refs/heads/master version.json
RUN yum update -y \
	&& yum install -y maven \ 
	&& yum install -y git \ 
	&& cd /home \
	&& git clone https://github.com/yexianyi/Chukonu.git \
	&& cd $SOURCE_PATH_1 \
	&& mvn clean package -DskipTests \
	&& cp target/$TARGET_JAR_NAME /home/$TARGET_JAR_NAME \
	&& cd /home \
	&& rm -rf $SOURCE_PATH \
	
	#Uninstall unecessary package
	&& yum -y remove git \
	&& yum -y remove maven \
	&& yum clean all \
	&& yum autoremove -y
	
	#start up commands
	ENTRYPOINT [ "sh", "-c", "java -jar /home/$RUNNABLE_JAR_FILE" ]
