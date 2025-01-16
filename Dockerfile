FROM ubuntu:24.10

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Yerevan

RUN apt update
RUN apt dist-upgrade -y
RUN apt install -y meson pkg-config libudev-dev libmtdev-dev libevdev-dev libwacom-dev libgtk-3-dev check

RUN cat <<EOF > /build.sh
#!/bin/bash
meson setup --prefix=/usr builddir/ && ninja -C builddir/
EOF
RUN chmod +x /build.sh

WORKDIR /build

CMD ["/build.sh"]

# How to run it:
# clone repo
# cd libinput
# sudo docker build -t libinput-builder .
# sudo docker run -v .:/build libinput-builder
# sudo cp builddir/libinput.so.10.13.0 /lib/x86_64-linux-gnu/libinput.so.10.13.0
