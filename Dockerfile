FROM maven:3.3-jdk-8 AS bulid

# ENV DB_DIALECT HSQLDB
# ENV DB_URL jdbc:hsqldb:file:lavagna
# ENV DB_USER root
# ENV DB_PASS root
# ENV SPRING_PROFILE dev
# ENV DB_DIALECT MYSQL
# ENV DB_URL jdbc:mysql://my_db:3306/lavagna
# ENV DB_USER root
# ENV DB_PASS root
# ENV SPRING_PROFILE dev
WORKDIR /app
COPY . .
EXPOSE 8080
RUN  mvn verify
RUN echo "hi"


FROM openjdk:8u212-jre-alpine3.9
RUN apk add openjdk8-jre
ENV DB_DIALECT MYSQL
ENV DB_URL jdbc:mysql://that-kill-me.cmrjltrhhkei.eu-west-3.rds.amazonaws.com:3306/lavagna?useSSL=false
ENV DB_USER admin
ENV DB_PASS password
ENV SPRING_PROFILE dev
COPY --from=bulid /app/entrypoint.sh .
COPY --from=bulid /app/target /target
ENTRYPOINT ./entrypoint.sh