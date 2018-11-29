FROM debian:stretch
RUN apt-get update
RUN apt-get install -y apt-transport-https curl gnupg2 cron nano openssh-server
RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
RUN touch /etc/apt/sources.list.d/kubernetes.list
RUN echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list
RUN apt-get update
RUN apt-get install -y kubectl
EXPOSE 22
RUN crontab -l | { cat; echo "05 11 * * * /root/wp-deploy.sh"; } | crontab -
RUN crontab -l | { cat; echo "06 11 * * 1,4 /root/nginx-crashloop.sh"; } | crontab -
COPY Dockerfile /
ENTRYPOINT ["sshd","-D"]
