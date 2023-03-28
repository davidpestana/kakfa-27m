FROM ubuntu
RUN apt update && apt install -qqy nano wget openjdk-8-jdk iputils-ping
RUN wget https://downloads.apache.org/kafka/3.4.0/kafka_2.12-3.4.0.tgz && tar -xvf kafka_2.12-3.4.0.tgz && mv kafka_2.12-3.4.0 kafka 