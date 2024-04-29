# Author: Technel © 2024
# Ref: https://www.howtoforge.com/how-to-install-and-configure-nexus-repository-manager-on-ubuntu-20-04/

apt-get update -y

apt-get install openjdk-8-jdk -y

java -version

useradd -M -d /opt/nexus -s /bin/bash -r nexus

echo "nexus ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/nexus

mkdir /opt/nexus

wget https://sonatype-download.global.ssl.fastly.net/repository/downloads-prod-group/3/nexus-3.29.2-02-unix.tar.gz

tar xzf nexus-3.29.2-02-unix.tar.gz -C /opt/nexus --strip-components=1

chown -R nexus:nexus /opt/nexus

nano /opt/nexus/bin/nexus.vmoptions


# Set Java max memory size and replaced "../sonatype-work" with "./sonatype-work":
-Xms1024m
-Xmx1024m
-XX:MaxDirectMemorySize=1024m

-XX:LogFile=./sonatype-work/nexus3/log/jvm.log
-XX:-OmitStackTraceInFastThrow
-Djava.net.preferIPv4Stack=true
-Dkaraf.home=.
-Dkaraf.base=.
-Dkaraf.etc=etc/karaf
-Djava.util.logging.config.file=/etc/karaf/java.util.logging.properties
-Dkaraf.data=./sonatype-work/nexus3
-Dkaraf.log=./sonatype-work/nexus3/log
-Djava.io.tmpdir=./sonatype-work/nexus3/tmp

# Save and close the file then edit the nexus.rc file and define the run as user:

nano /opt/nexus/bin/nexus.rc
## run_as_user="nexus"

sudo -u nexus /opt/nexus/bin/nexus start

# ss -altnp | grep 8081

# /opt/nexus/bin/nexus stop

nano /etc/systemd/system/nexus.service
# Add the following lines:

[Unit]
Description=nexus service
After=network.target

[Service]
Type=forking
LimitNOFILE=65536
ExecStart=/opt/nexus/bin/nexus start
ExecStop=/opt/nexus/bin/nexus stop
User=nexus
Restart=on-abort

[Install]
WantedBy=multi-user.target

# Save and exit


systemctl daemon-reload
systemctl start nexus
systemctl enable nexus
systemctl status nexus
