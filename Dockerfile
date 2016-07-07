From ubuntu:trusty
MAINTAINER chepaika

# Set noninteractive mode for apt-get
ENV DEBIAN_FRONTEND noninteractive

# Update
RUN apt-get update

# Start editing
# Install package here for cache
RUN apt-get -y install supervisor postfix sasl2-bin opendkim opendkim-tools mailutils wget gnupg python-gpgme sudo

# Add files
ADD assets/install.sh /opt/install.sh
RUN chmod +x /opt/install.sh

#Congigure zeyple
RUN adduser --system --no-create-home --disabled-login zeyple
RUN mkdir -p /var/lib/zeyple/keys && chmod 700 /var/lib/zeyple/keys && chown zeyple: /var/lib/zeyple/keys
RUN wget --quiet --output-document=/usr/local/bin/zeyple.py https://raw.github.com/infertux/zeyple/master/zeyple/zeyple.py
RUN chmod 744 /usr/local/bin/zeyple.py && chown zeyple: /usr/local/bin/zeyple.py
RUN touch /var/log/zeyple.log && chown zeyple: /var/log/zeyple.log

# Run
CMD /opt/install.sh;/usr/bin/supervisord -c /etc/supervisor/supervisord.conf
