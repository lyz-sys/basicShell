#!/bin/bash
i=10

case $i in
10)
  echo "10"
  ;;
9)
  echo "123"
  ;;
*)
  echo "default"
  ;;
esac

array=(11 22 33)
echo "${array[2]}"

bar() {
  while :; do
    echo -en "\033[42m \033[0m"
    sleep 0.5
  done
}
bar &
ping 127.0.0.1 -c 100 -i 0.1 -W 1 &>/dev/null
kill $!
echo

#date=$(date +%Y%m%d)
#echo $date
