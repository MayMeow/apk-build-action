FROM openjdk:11-jdk

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT["/entrypoint.sh"]