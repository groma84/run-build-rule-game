docker volume create run-build-rule-db

docker container run --detach --publish 5432:5432 --name run-build-rule-db --volume run-build-rule-db:/var/lib/postgresql/data --env POSTGRES_PASSWORD=postgres postgres:13.2
docker container run --mount type=bind,source=/home/mgrotz/source/run-build-rule-game/server,target=/opt/app/src -it --publish 4000:4000 --name phx-dev bitwalker/alpine-elixir-phoenix:1.11.3
docker-compose run --service-ports phx sh
