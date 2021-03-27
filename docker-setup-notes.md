docker volume create run-build-rule-db

docker container run --detach --publish 5432:5432 --name run-build-rule-db --volume run-build-rule-db:/var/lib/postgresql/data --env POSTGRES_PASSWORD=postgres postgres:13.2
