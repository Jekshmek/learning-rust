FROM rust:1.36

ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

COPY ./app /usr/src/app
COPY docker/ /files
RUN cp -rf /files/* /
RUN rm -rf /files

WORKDIR /usr/src/app
RUN cargo build

ENTRYPOINT ["dockerize", "-template", "/env.tmpl:/usr/src/app/.env"]

CMD ["sh", "/start.sh"]