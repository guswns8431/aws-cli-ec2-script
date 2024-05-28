#!/bin/bash

source ./scripts/colors.sh

PS3="사용할 키페어를 선택하세요"
echo

key_pairs=("aws5" "home" "기타" "뒤로가기")

while true; do
	index=1
	for key_pair in "${key_pairs[@]}"
	do
		echo -e "${COLOR_RED_START}${index}. ${key_pair}${COLOR_END}"
		((index++))
	done
	echo

	read -p "원하는 key pair를 선택하세요($(echo -e ${COLOR_YELLOW_START})1, 2, 3, 4$(echo -e ${COLOR_END})) : " menu

	case $menu in
	"1")
		echo
		echo -e "${COLOR_GREEN_START}${key_pairs[0]}${COLOR_END}를 선택하셨습니다"
        	key_pair=${key_pairs[0]}
		break
      	 	;;
	"2")
		echo
		echo -e "${COLOR_GREEN_START}${key_pairs[1]}${COLOR_END}를 선택하셨습니다"
        	key_pair=${key_pairs[1]}
		break
      	 	;;
	"3")
		echo -e "${COLOR_GREEN_START}${BOLD}3. 기타${BOLD_END}${COLOR_END}를 선택하셨습니다\n"
		read -p "원하는 $(echo -e ${COLOR_YELLOW_START}KEY PAIR${COLOR_END})를 작성해주세요 : " key_pair
		echo -e "${COLOR_GREEN_START}${key_pair}${COLOR_END}를 선택하셨습니다"
		break
        	;;
	"4")
		echo -e "${COLOR_GREEN_START}${BOLD}4. 뒤로가기${BOLD_END}${COLOR_END}하겠습니다"
		./scripts/module/instance-type-select.sh
		exit 0
		;;
	*)
		echo -e "${COLOR_YELLOW_START}잘못된 선택${COLOR_END}입니다. 선택 가능한 옵션은 ${COLOR_YELLOW_START}${BOLD}1, 2, 3, 4 ${BOLD_END}${COLOR_END}입니다."
		;;
	esac
	echo
done

export key_pair
