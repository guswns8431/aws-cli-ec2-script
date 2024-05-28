#!/bin/bash

source ./scripts/colors.sh

echo -e "${BACK_COLOR_YELLOW_START}${BOLD}#############################${BOLD_END}${COLOR_END}"
echo -e "${BACK_COLOR_YELLOW_START}${BOLD}#    aws-key-pair.sh 시작   #${BOLD_END}${COLOR_END}"
echo -e "${BACK_COLOR_YELLOW_START}${BOLD}#############################${BOLD_END}${COLOR_END}"

menus=("1. key-pair 생성" "2. key-pair 삭제")

for item in "${menus[@]}"
do
	echo -e "${COLOR_RED_START}${item}${COLOR_END}"
done
echo

read -p "원하는 작업을 선택하세요($(echo -e ${COLOR_YELLOW_START})1, 2$(echo -e ${COLOR_END})) : " menu

case $menu in
    "1")
	echo -e "${COLOR_GREEN_START}${BOLD}1. key pair 생성${BOLD_END}${COLOR_END} 시작하겠습니다"
	read -p "생성할 key 이름 : " key_name
	read -p "생성할 파일 이름(.pem 자동추가) : " file_name
	echo

	aws ec2 create-key-pair --key-name $key_name --query 'KeyMaterial' --output text > ${file_name}.pem
	if [ $? -eq 0 ]; then
		echo -e "${COLOR_GREEN_START}key-pair ${key_name} 생성에 성공${COLOR_END}했습니다."
		chmod 400 ${file_name}.pem       
	else
		echo -e "${COLOR_YELLOW_START}key-pair ${key_name} 생성에 실패${COLOR_END}했습니다."
	fi
        ;;
    "2")
	echo -e "${COLOR_GREEN_START}${BOLD}2. key pair 삭제${BOLD_END}${COLOR_END} 시작하겠습니다"
	read -p "삭제할 key 이름 : " key_name
	read -p "삭제할 파일 이름(확장자까지 정확하게 작성) : " file_name
	echo

	aws ec2 describe-key-pairs --key-names $key_name > /dev/null 2>&1

	if [ $? -eq 0 ]; then
		aws ec2 delete-key-pair --key-name $key_name > /dev/null 2>&1
		echo -e "${COLOR_GREEN_START}key-pair ${key_name} 삭제에 성공${COLOR_END}했습니다."
		rm -rf $file_name
	else
		echo -e "${COLOR_YELLOW_START}key-pair ${key_name} 삭제에 실패${COLOR_END}했습니다. 존재하지 않습니다"
	fi
        ;;
    *)
	echo "잘못된 선택입니다. 선택 가능한 옵션은 ${COLOR_YELLOW_START}${BOLD}1, 2${BOLD_END}${COLOR_END}입니다."
        ;;
esac



