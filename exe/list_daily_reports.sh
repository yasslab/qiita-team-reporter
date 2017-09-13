#!/bin/sh

qiita_team_reporter() {
    if [ $# -eq 0 ]
    then
	echo "* Fetching all daily reports from YassLab's Qiita:Team"
	# 日報全体のタイトルを出力 (100 articles/page)
	envchain qiita-team-reporter qiita list_tag_items 日報/2017/09 per_page=100 page=1 -t yasslab | jq -r '.[] | .title'

    else
	echo "* Fetching $1's daily reports from YassLab's Qiita:Team"
	# ユーザー指定する
	envchain qiita-team-reporter qiita list_tag_items 日報/2017/09 per_page=100 page=1 -t yasslab | jq --raw-output --arg USERNAME "$1" '.[] | select(.user.id == $USERNAME) | .title'
    fi 
}

# Check number of given arguments
if [ $# -ne 1 ]
then
    echo "Usage: ./list_daily_reports.sh USERNAME"
    echo "  Ex.: ./list_daily_reports.sh yasulab"
    exit
fi

# Check required commands
COMMANDS=( "envchain" "qiita" "jq" )
cmd_check() {
    type $1 > /dev/null 2>&1
    if [ $? != 0 ]
    then
	echo "'$1' not found"
	echo "Please install this command via Homebrew or RubyGems"
	echo ""
	exit
    fi
}
for cmd in ${COMMANDS[@]}
do
    cmd_check $cmd
done

# Exec with given arguments if ready
qiita_team_reporter $@
