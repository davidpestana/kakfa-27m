const { Kafka } = require('kafkajs')

const kafka = new Kafka({
  clientId: 'miClientId',
  brokers: ['broker1:9092', 'broker2:9092', 'broker3:9092'],
});

const producer = kafka.producer()


send = async () => {
    await producer.connect();
    var counter = 0;
    setInterval(async () => {
        await producer.send({
        topic: 'topic-test',
        messages: [
            { value: 'Hello KafkaJS user!  ' + counter ++ },
        ],
        })
    },1000);
}

send().then(()=>{})