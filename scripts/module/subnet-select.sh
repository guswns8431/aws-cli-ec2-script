#!/bin/bash

source ./scripts/colors.sh

PS3="원하는 SUBNET을 선택하세요"
echo

subnets=("subnet-0bd8b860941533019" "기타" "뒤로가기")

while true; do
	index=1
	for subnet in "${subnets[@]}"
	do
		echo -e "${COLOR_RED_START}${index}. ${subnet}${COLOR_END}"
		((index++))
	done
	echo

	read -p "원하는 subnet을 선택하세요($(echo -e ${COLOR_YELLOW_START})1, 2, 3$(echo -e ${COLOR_END})) : " menu

	case $menu in
	"1")
		echo
		echo -e "${COLOR_GREEN_START}${subnets[0]}${COLOR_END}를 선택하셨습니다"
        	subnet=${subnets[0]}
		break
      	 	;;
	"2")
		echo -e "${COLOR_GREEN_START}${BOLD}2. 기타${BOLD_END}${COLOR_END} 선택하셨습니다\n"
		echo "현재 선택 가능한 subnet 목록을 출력합니다.\n"
		aws ec2 describe-subnets
		read -p "원하는 $(echo -e ${COLOR_YELLOW_START}subnet${COLOR_END})을 작성해주세요 : " subnet
		break
        	;;
	"3")
		echo -e "${COLOR_GREEN_START}${BOLD}3. 뒤로가기${BOLD_END}${COLOR_END}하겠습니다"
		./scripts/module/key-pair-select.sh
		exit 0
		;;
	*)
		echo -e "${COLOR_YELLOW_START}잘못된 선택${COLOR_END}입니다. 선택 가능한 옵션은 ${COLOR_YELLOW_START}${BOLD}1, 2, 3 ${BOLD_END}${COLOR_END}입니다."
		;;
	esac
	echo
done

export subnet
