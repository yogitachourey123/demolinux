function Linuxprereq(){

	local timezone="$1" # ex America/Los_Angeles  
	local preReqsPath="$1" #ex /root/CentOS_Offline_PreReqs
	local tarName="$2" #ex docker-18.09.6.tgz
  local composeFolder="$3" #ex docker-compose-Linux-x86_64 
	local dialogFilename="$2" #ex dialog-1.2-5.20130523.el7.x86_64.rpm
	local JDKFilename="$2" #ex jdk-8u241-linux-x64.rpm

    echo "Setting timezone and restarting chrony"
    timedatectl set-timezone $timezone
    systemctl restart chronyd
	
	  echo "Disabling firewall"
    systemctl stop firewalld
    systemctl disable firewalld

    echo "Setting up Docker"
    cd $preReqsPath
    tar xzvf $preReqsPath/$tarName
    cp docker/* /usr/bin/
    cp $preReqsPath/docker.s* /etc/systemd/system
    systemctl enable docker
    systemctl start docker
    
    cp $preReqsPath/$composeFolder /usr/sbin/docker-compose
    chmod +x /usr/sbin/docker-compose
	
    echo "Installing Dialog"
    rpm -i $preReqsPath/$dialogFilename

    echo "Installing JDK"
    rpm -ivh $preReqsPath/$JDKFilename
}
Linuxprereq "$@"

