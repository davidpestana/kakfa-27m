const { Kafka } = require('kafkajs')

const kafka = new Kafka({
  clientId: 'miClientId',
  brokers: ['broker1:9092', 'broker2:9092', 'broker3:9092'],
});

const consumer = kafka.consumer({groupId: 'consumo-js-pruebas'})


const start = async () => {
    await consumer.connect()
    await consumer.subscribe({ topic: 'topic-2'})
    // await consumer.subscribe({ topic: 'topic2', fromBeginning: true })


    await consumer.run({
        eachMessage: async ({ topic, partition, message }) => {
        console.log({
            topic,
            partition,
            value: message.value.toString(),
        })
        },
    })
}

start().then(() => {})
