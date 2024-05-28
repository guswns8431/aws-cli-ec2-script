#!/bin/bash

source ./scripts/colors.sh

PS3="생성할 인스턴스 타입을 선택하세요"
echo

instance_types=("t2.micro" "기타" "뒤로가기")

while true; do
	index=1
	for instance_type in "${instance_types[@]}"
	do
		echo -e "${COLOR_RED_START}${index}. ${instance_type}${COLOR_END}"
		((index++))
	done
	echo

	read -p "원하는 인스턴스 타입을 선택하세요($(echo -e ${COLOR_YELLOW_START})1, 2, 3$(echo -e ${COLOR_END})) : " menu

	case $menu in
	"1")
		echo
		echo -e "${COLOR_GREEN_START}${instance_types[0]}${COLOR_END} 개를 선택하셨습니다"
        	instance_type=${instance_types[0]}
		break
      	 	;;
	"2")
		echo -e "${COLOR_GREEN_START}${BOLD}2. 기타${BOLD_END}${COLOR_END} 선택하셨습니다\n"
		read -p "원하는 $(echo -e ${COLOR_YELLOW_START}인스턴스 타입${COLOR_END})을 작성해주세요 : " instance_type
		echo -e "${COLOR_GREEN_START}${instance_type}${COLOR_END}을 선택하셨습니다"
		break
        	;;
	"3")
		echo -e "${COLOR_GREEN_START}${BOLD}4. 뒤로가기${BOLD_END}${COLOR_END}하겠습니다"
		./scripts/module/instance-number-select.sh
		exit 0
		;;
	*)
		echo -e "${COLOR_YELLOW_START}잘못된 선택${COLOR_END}입니다. 선택 가능한 옵션은 ${COLOR_YELLOW_START}${BOLD}1, 2, 3, 4 ${BOLD_END}${COLOR_END}입니다."
		;;
	esac
	echo
done

export instance_type
