#!/bin/sh

list=`echo $(curl --silent http://teamspeak.com/downloads | grep "http://[a-zA-Z0-9/._-]*.tar.bz2" -o)`
mir1=""
mir2=""
out="server.tar.bz2"
if [ `uname -m` == "x86_64" ]; then
  arch="amd64"
else
  arch="x86"
fi

for l in $list; do
  case "$l" in
    *4players*linux*$arch*)
      mir1=$l
      ;;
    *gamed*linux*$arch*)
      mir2=$l
      ;;
    *)
      :
      ;;
  esac
done

exitonerr() {
  if [ $2 != "0" ]; then
    echo "$1"
    exit $2
  fi
}

# workarround for a snapcraft bug
pkgget() {
  echo "[download] $1"
  apt-get download $1 > /dev/null
  f=`dir -w 1 | grep "^$1"`
  echo "[unpack  ] $f"
  dpkg-deb -R $f sq
}
mkdir sq
mkdir bin
pkgget sqlite3
pkgget coreutils
cp sq/usr/bin/* ./bin
rm -rf sq
# [/]

for m in $mir1 $mir2; do
  wget $m -O $out
  if [ $? == "0" ]; then
    tar xfj $out
    exitonerr "Cannot uncompress $out" $?
    mv teamspeak3-server_linux_$arch ts3server
    exitonerr "Cannot rename file" $?
    v=`echo $m | grep "/[0-9.][0-9.]*/" -o | grep "[0-9.]*" -o`
    echo "$v" > ts3server/VERSION
    chmod 777 -R ts3server
    echo "[OK]"
    exit 0
  else
    rm $out
  fi
done

#still here? - download failed
echo "[ERR] download failed!!!"
exit 2
