FROM litespeedtech/openlitespeed:latest
COPY install.sh /usr/local/bin/

LABEL version="0.0.2"
LABEL description="Redirect Domain with Litespeed"
LABEL maintainer="Alan Mosko<falecom@alanmosko.com.br>"

ENV VIRTUAL_HOST="domain.com"
ENV REDIRECT_FOR="newdomain.com"

RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y wget cron nano zip unzip curl git
RUN wget -O - http://rpms.litespeedtech.com/debian/enable_lst_debain_repo.sh | bash
RUN apt-get install -y lsphp74-ldap
RUN apt-get clean
RUN apt-get autoclean
RUN apt-get autoremove --purge -y wget
RUN rm -rf /var/lib/apt/lists/*

ENV PATH="${PATH}:/usr/local/lsws/lsphp74/bin/"

WORKDIR /var/www/vhosts/localhost/html

CMD ["sh", "/usr/local/bin/install.sh"]

RUN /usr/local/lsws/bin/lswsctrl restart
