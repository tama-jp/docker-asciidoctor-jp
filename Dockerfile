FROM asciidoctor/docker-asciidoctor:1.3.3
MAINTAINER tamatan

ENV COMPASS_VERSION 0.12.7
ENV ZURB_FOUNDATION_VERSION 4.3.2
ENV MERMAID_VERSION 7.0.9

RUN gem install asciidoctor-pdf-cjk-kai_gen_gothic -N && \
    gem install --version ${COMPASS_VERSION} compass -N && \
    gem install --version ${ZURB_FOUNDATION_VERSION} zurb-foundation -N && \
    asciidoctor-pdf-cjk-kai_gen_gothic-install

WORKDIR /root
RUN wget -O VLGothic.zip "http://osdn.jp/frs/redir.php?m=jaist&f=%2Fvlgothic%2F62375%2FVLGothic-20141206.zip" && \
    unzip VLGothic.zip && \
    mkdir -p /root/.fonts && \
    cp VLGothic/VL-Gothic-Regular.ttf /root/.fonts && \
    rm -rf /root/VLGothic*

RUN wget https://github.com/asciidoctor/asciidoctor-stylesheet-factory/archive/master.zip && \
    unzip master.zip && \
    cd asciidoctor-stylesheet-factory-master && \
    compass compile && \
    cp -pr stylesheets /

RUN NOKOGIRI_USE_SYSTEM_LIBRARIES=1 gem install asciidoctor-epub3 --pre

WORKDIR /documents
