#===========
#Build Stage
#===========
FROM bitwalker/alpine-elixir:1.6.6 as build

#Copy the source folder into the Docker image
COPY . .

ARG ENV

#Install dependencies and build Release
ENV MIX_ENV=$ENV
RUN apk update && \
    apk add -u musl musl-dev musl-utils nodejs-npm build-base
RUN apk --no-cache add postgresql-client 
RUN mix deps.get
RUN mix compile
RUN cd assets && \
    npm install && \
    node ./node_modules/brunch/bin/brunch b -p && \
    cd .. && \
    mix phx.digest
RUN mix release

#Extract Release archive to /rel for copying in next stage
RUN APP_NAME="ex_typeracer" && \
    RELEASE_DIR=`ls -d _build/$ENV/rel/$APP_NAME/releases/*/` && \
    mkdir /export && \
    tar -xf "$RELEASE_DIR/$APP_NAME.tar.gz" -C /export

#================
#Deployment Stage
#================
FROM pentacent/alpine-erlang-base:latest

#Set environment variables and expose port
EXPOSE 4000
ENV REPLACE_OS_VARS=true \
    PORT=4000

#Copy and extract .tar.gz Release file from the previous stage
COPY --from=build /export/ ${HOME}

#Change user
USER default

#Set default entrypoint and command
ENTRYPOINT ["/opt/app/bin/ex_typeracer"]
CMD ["foreground"]