bootstrap-server = broker1:9092

start:
	docker compose up -d
	docker compose logs -f

start-producers:
	docker compose -f docker-compose.yaml -f producers.yaml run producer-example-1

cleanup:
	docker compose down --remove-orphans

remove:
	docker compose -f docker-compose.yaml -f services.yaml run --rm tools bash -c "rm -rf /data/*"


build:
	docker compose build

tools:
	docker compose -f docker-compose.yaml -f services.yaml run tools
 
topic-create:
	@read -p "Enter topic name: " topic; \
	read -p "Enter partitions number: " partitions; \
	read -p "Enter replication factor: " replication; \
	docker compose -f docker-compose.yaml -f services.yaml run --rm tools bash -c \
		"./bin/kafka-topics.sh --bootstrap-server $(bootstrap-server) --create --partitions $$partitions --replication-factor $$replication --topic $$topic"

topic-delete:
	@read -p "Enter topic name: " topic; \
	docker compose -f docker-compose.yaml -f services.yaml run --rm tools bash -c \
		"./bin/kafka-topics.sh --bootstrap-server $(bootstrap-server) --delete --topic $$topic"

topic-describe:
	@read -p "Enter topic name: " topic; \
	docker compose -f docker-compose.yaml -f services.yaml run --rm tools bash -c \
		"./bin/kafka-topics.sh --bootstrap-server $(bootstrap-server) --describe --topic $$topic"

topic-list:
	docker compose -f docker-compose.yaml -f services.yaml run --rm tools bash -c \
		"./bin/kafka-topics.sh --bootstrap-server $(bootstrap-server) --list"

group-describe:
	@read -p "Enter group name: " group; \
	docker compose -f docker-compose.yaml -f services.yaml run --rm tools bash -c \
		"./bin/kafka-consumer-groups.sh --bootstrap-server $(bootstrap-server) --describe --group $$group"

group-list:
	docker compose -f docker-compose.yaml -f services.yaml run --rm tools bash -c \
		"./bin/kafka-consumer-groups.sh --bootstrap-server $(bootstrap-server) --list"



console-consumer:
	@read -p "Enter topic name: " topic; \
	docker compose -f docker-compose.yaml -f services.yaml run --rm tools bash -c \
		"./bin/kafka-console-consumer.sh --bootstrap-server $(bootstrap-server) --topic $$topic"

console-consumer-fb:
	@read -p "Enter topic name: " topic; \
	docker compose -f docker-compose.yaml -f services.yaml run --rm tools bash -c \
		"./bin/kafka-console-consumer.sh --bootstrap-server $(bootstrap-server) --topic $$topic --from-beginning"

console-producer:
	@read -p "Enter topic name: " topic; \
	docker compose -f docker-compose.yaml -f services.yaml run --rm tools bash -c \
		"./bin/kafka-console-producer.sh --bootstrap-server $(bootstrap-server) --topic $$topic"

node:
	docker compose -f producers.yaml run --rm producer-example-1 bash
