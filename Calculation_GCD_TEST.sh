#!/bin/bash

SCRIPT="./Calculation_GCD.sh"
EXIT_CODE=0

run_test() {
    local description="$1"
    local expected_output="$2"
    local expected_status="$3"
    shift 3
    local output status

    echo "▶ テスト: $description"
    output=$($SCRIPT "$@" 2>&1)
    status=$?

    if [ "$status" -ne "$expected_status" ]; then
        echo "   終了コードエラー：期待=$expected_status, 実際=$status"
        echo "  出力: $output"
        EXIT_CODE=1
    elif [ "$expected_status" -eq 0 ] && [ "$output" != "$expected_output" ]; then
        echo "   出力不一致：期待='$expected_output', 実際='$output'"
        EXIT_CODE=1
    else
        echo "  OK"
    fi
    echo
}

# -------------------
# 正常系テスト
# -------------------
run_test "60と48の最大公約数" "12" 0 60 48
run_test "17と13の最大公約数（互いに素）" "1" 0 17 13
run_test "100と10の最大公約数" "10" 0 100 10

# -------------------
# 異常系テスト（エラー終了を期待）
# -------------------
run_test "引数なし" "" 1
run_test "引数1つ" "" 1 42
run_test "引数3つ" "" 1 10 20 30
run_test "0を含む" "" 1 0 5
run_test "負の数" "" 1 -10 15
run_test "文字列" "" 1 abc 123
run_test "桁数超過（21桁）" "" 1 123456789012345678901 123

exit $EXIT_CODE
