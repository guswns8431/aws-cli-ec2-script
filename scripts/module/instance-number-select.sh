#!/bin/bash

source ./scripts/colors.sh

PS3="생성할 인스턴스 수를 선택하세요"
echo

instance_numbers=("1" "2" "기타" "뒤로가기")

while true; do
	index=1
	for count in "${instance_numbers[@]}"
	do
		echo -e "${COLOR_RED_START}${index}. ${count}${COLOR_END}"
		((index++))
	done
	echo

	read -p "원하는 인스턴스 수를 선택하세요($(echo -e ${COLOR_YELLOW_START})1, 2, 3, 4$(echo -e ${COLOR_END})) : " menu

	case $menu in
	"1")
		echo
		echo -e "${COLOR_GREEN_START}${instance_numbers[0]}${COLOR_END} 개를 선택하셨습니다"
        	count=${instance_numbers[0]}
		break
      	 	;;
	"2")
		echo
		echo -e "${COLOR_GREEN_START}${instance_numbers[1]}${COLOR_END} 개를 선택하셨습니다"
        	count=${instance_numbers[1]}
		break
      	 	;;
	"3")
		echo -e "${COLOR_GREEN_START}${BOLD}3. 기타${BOLD_END}${COLOR_END} 선택하셨습니다\n"
		read -p "원하는 $(echo -e ${COLOR_YELLOW_START}인스턴스 수${COLOR_END})를 작성해주세요 : " count
		echo -e "${COLOR_GREEN_START}${count}${COLOR_END} 개를 선택하셨습니다"
		break
        	;;
	"4")
		echo -e "${COLOR_GREEN_START}${BOLD}4. 뒤로가기${BOLD_END}${COLOR_END}하겠습니다"
		./scripts/module/ami-select.sh
		exit 0
		;;
	*)
		echo -e "${COLOR_YELLOW_START}잘못된 선택${COLOR_END}입니다. 선택 가능한 옵션은 ${COLOR_YELLOW_START}${BOLD}1, 2, 3, 4 ${BOLD_END}${COLOR_END}입니다."
		;;
	esac
	echo
done

export count
