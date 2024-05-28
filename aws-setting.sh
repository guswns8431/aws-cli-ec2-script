#!/bin/bash

source ./scripts/colors.sh

cat ./ascii-art/prof.chan
cat ./ascii-art/keyboard

echo -e "${BACK_COLOR_YELLOW_START}${BOLD}############################${BOLD_END}${COLOR_END}"
echo -e "${BACK_COLOR_YELLOW_START}${BOLD}#    aws-setting.sh 시작   #${BOLD_END}${COLOR_END}"
echo -e "${BACK_COLOR_YELLOW_START}${BOLD}############################${BOLD_END}${COLOR_END}"

menus=("1. AWS-CLI-환경설정" "2. key-pair-생성/삭제" "3. AWS-EC2-인스턴스-생성" "4. 종료")

echo
echo "잘못 입력한 경우 ctrl + u를 입력하면 지워집니다"

while true; do
	for item in "${menus[@]}"
	do
		echo -e "${COLOR_RED_START}${item}${COLOR_END}"
	done
	echo

	read -p "원하는 작업을 선택하세요($(echo -e ${COLOR_YELLOW_START})1, 2, 3, 4$(echo -e ${COLOR_END})) : " menu

	case $menu in
	"1")
		echo -e "${COLOR_GREEN_START}${BOLD}1. AWS CLI 환경설정${BOLD_END}${COLOR_END} 시작하겠습니다"
        	./scripts/aws-first-setting-for-macos.sh
      	 	 ;;
	"2")
		echo -e "${COLOR_GREEN_START}${BOLD}2. key pair 생성/삭제${BOLD_END}${COLOR_END} 시작하겠습니다"
	        ./scripts/aws-key-pair.sh
        	;;
	"3")
		echo -e "${COLOR_GREEN_START}${BOLD}3. AWS EC2 인스턴스 생성${BOLD_END}${COLOR_END} 시작하겠습니다"
		./scripts/aws-run-instance.sh
        	;;
	"4")
		echo -e "${COLOR_GREEN_START}${BOLD}4. 종료${BOLD_END}${COLOR_END}하겠습니다"
		exit 0
		;;
	*)
		echo -e "${COLOR_YELLOW_START}잘못된 선택${COLOR_END}입니다. 선택 가능한 옵션은 ${COLOR_YELLOW_START}${BOLD}1, 2, 3, 4 ${BOLD_END}${COLOR_END}입니다."
		;;
	esac
	echo
done
