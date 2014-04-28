from   stackbrew/ubuntu:13.10

#run    dpkg-divert --local --rename --add /sbin/initctl
#run    ln -s /bin/true /sbin/initctl

run    apt-get --yes update
run    apt-get install -y -q software-properties-common
run    add-apt-repository -y "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) universe"

run apt-get -y install curl perl supervisor redis-server make rubygems libio-socket-ssl-perl
add ./vendor/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
add . /convos
run gem install sass
run cd /convos; ./vendor/bin/carton
expose 8080
entrypoint ["/usr/bin/supervisord"]
