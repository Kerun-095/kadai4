#!/bin/bash

LOG_FILE="./calc_gcd.log"
MAX=20

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

error_exit() {
    log "エラー終了: $1"
    echo "エラー: $1" >&2
    echo "使用方法: $0 <自然数> <自然数>" >&2
    exit 1
}

# 引数チェック
[[ $# -ne 2 ]] && error_exit "引数は2つ必要です"

for arg in "$1" "$2"; do
    [[ ! "$arg" =~ ^[1-9][0-9]*$ ]] && error_exit "自然数（1以上）を指定してください（'$arg'）"
    [[ ${#arg} -gt $MAX ]] && error_exit "最大${MAX}桁までの自然数を指定してください（'$arg'）"
done

log "実行開始: 引数1='$1', 引数2='$2'"

# ユークリッドの互除法による最大公約数計算
gcd() {
    local a=$1 b=$2
    while [ "$b" -ne 0 ]; do
        local tmp=$b
        b=$((a % b))
        a=$tmp
    done
    echo "$a"
}

RESULT=$(gcd "$1" "$2")
log "最大公約数: $RESULT"
echo "$RESULT"
