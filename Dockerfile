FROM centos:centos7
WORKDIR /usr/api_app
RUN yum -y install curl sudo
RUN sudo curl --silent --location https://rpm.nodesource.com/setup_9.x | sudo bash -
RUN sudo yum -y install nodejs
RUN sudo yum -y install gcc-c++ make
RUN yum -y install git; yum clean all
COPY id_rsa /root/.ssh/
RUN ssh-keyscan -t rsa code.aliyun.com > ~/.ssh/known_hosts
RUN git clone https://github.com/dlrandy/blogs.abbyprog.com.git
WORKDIR koa-api
RUN npm install -g cnpm --registry=https://registry.npm.taobao.org
RUN cnpm install --only=production > /dev/null
EXPOSE 8000
CMD ["npm","run","prod"]
