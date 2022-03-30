#!/bin/bash

Usage() {
  echo "fileSystemRestart.sh [options] -s <signal>"
  echo "可选参数可以下列参数组合:"
  echo "    -h help       : 帮助信息"
  echo "    -o option     : 任务名称 all/download/compression/upload"
  echo "    -s signal     : 可选 safestop（安全）/forcedstop（强制）"
  exit 0
}

while getopts "o: s: h" opt; do
  case $opt in
  h)
    Usage
    ;;
  o)
    o=$OPTARG
    ;;
  s)
    s=$OPTARG
    ;;
  \?)
    echo "-$OPTARG needs an argument"
    exit 1
    ;;
  *)
    echo "-$opt not recognized"
    exit 1
    ;;
  esac
done

if [ 0"$s" = "0" ] || [ 0"$o" = "0" ]; then
  echo "-s|-o not found"
  exit 1
fi

consoleName=()
case $o in
'download')
  consoleName+=('FileSystem:download')
  ;;
"compression")
  consoleName+=('FileSystem:compression')
  ;;
"upload")
  consoleName+=('FileSystem:upload')
  ;;
"all")
  consoleName+=('FileSystem:download' 'FileSystem:compression' 'FileSystem:upload')
  ;;
*)
  echo "option is not allow"
  exit 1
  ;;
esac

if [ $s = "forcedstop" ]; then
  singleId=9
else
  if [ $s = 'safestop' ]; then
    singleId=15
  else
    echo "single error"
    exit 1
  fi
fi

for console in "${consoleName[@]}"; do
  pids=$(ps aux | grep "$console" | grep -v grep | tr -s ' ' | cut -d ' ' -f 2)
  if [ "$pids" != "" ]; then
    echo "$pids" | xargs kill -$singleId
  fi
done

echo "success"
exit 0
