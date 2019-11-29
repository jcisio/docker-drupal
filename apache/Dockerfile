FROM httpd:2.4-alpine
RUN apk update; \
    apk upgrade;
COPY conf/macro.conf /usr/local/apache2/conf
COPY ssl /usr/local/apache2/ssl
RUN echo "Include /usr/local/apache2/conf/macro.conf" \
    >> /usr/local/apache2/conf/httpd.conf
RUN sed -i \
    -e 's/^#\(LoadModule .*mod_authn_file.so\)/\1/' \
    -e 's/^#\(LoadModule .*mod_deflate.so\)/\1/' \
    -e 's/^#\(LoadModule .*mod_expires.so\)/\1/' \
    -e 's/^#\(LoadModule .*mod_http2.so\)/\1/' \
    -e 's/^#\(LoadModule .*mod_include.so\)/\1/' \
    -e 's/^#\(LoadModule .*mod_ldap.so\)/\1/' \
    -e 's/^#\(LoadModule .*mod_macro.so\)/\1/' \
    -e 's/^#\(LoadModule .*mod_negotiation.so\)/\1/' \
    -e 's/^#\(LoadModule .*mod_proxy.so\)/\1/' \
    -e 's/^#\(LoadModule .*mod_proxy_fcgi.so\)/\1/' \
    -e 's/^#\(LoadModule .*mod_proxy_http2.so\)/\1/' \
    -e 's/^#\(LoadModule .*mod_rewrite.so\)/\1/' \
    -e 's/^#\(LoadModule .*mod_socache_shmcb.so\)/\1/' \
    -e 's/^#\(LoadModule .*mod_ssl.so\)/\1/' \
    conf/httpd.conf
