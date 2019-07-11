FROM jwilder/dockerize AS dockerize

FROM rust:1.36

COPY --from=dockerize /usr/local/bin/dockerize /usr/local/bin

COPY ./app /usr/src/app
COPY docker/ /files
RUN cp -rf /files/* /
RUN rm -rf /files

WORKDIR /usr/src/app
RUN cargo build

ENTRYPOINT ["dockerize", "-template", "/env.tmpl:/usr/src/app/.env"]

CMD ["sh", "/start.sh"]