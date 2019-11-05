FROM httpd:2.4-alpine
RUN apk update; \
    apk upgrade;
COPY conf/macro.conf /usr/local/apache2/conf
COPY ssl /usr/local/apache2/ssl
RUN echo "Include /usr/local/apache2/conf/macro.conf" \
    >> /usr/local/apache2/conf/httpd.conf
RUN sed -i \
    -e 's/^#\(LoadModule .*mod_macro.so\)/\1/' \
    -e 's/^#\(LoadModule .*mod_ssl.so\)/\1/' \
    -e 's/^#\(LoadModule .*mod_socache_shmcb.so\)/\1/' \
    conf/httpd.conf
