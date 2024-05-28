#!/bin/bash

source ./scripts/colors.sh

PS3="PUBLIC IP 설정"
echo

publics=("예" "아니오" "뒤로가기")

while true; do
	index=1
	for public in "${publics[@]}"
	do
		echo -e "${COLOR_RED_START}${index}. ${public}${COLOR_END}"
		((index++))
	done
	echo

	read -p "Public IP 설정을 하시겠습니까($(echo -e ${COLOR_YELLOW_START})1, 2, 3$(echo -e ${COLOR_END})) : " menu

	case $menu in
	"1")
		echo
		echo -e "${COLOR_GREEN_START}${publics[0]}${COLOR_END}를 선택하셨습니다"
        	public="--associate-public-ip-address"
		break
      	 	;;
	"2")
		echo -e "${COLOR_GREEN_START}${BOLD}아니오${BOLD_END}${COLOR_END} 선택하셨습니다\n"
		public="--no-associate-public-ip-address"
		break
        	;;
	"3")
		echo -e "${COLOR_GREEN_START}${BOLD}3. 뒤로가기${BOLD_END}${COLOR_END}하겠습니다"
		exit 0
		;;
	*)
		echo -e "${COLOR_YELLOW_START}잘못된 선택${COLOR_END}입니다. 선택 가능한 옵션은 ${COLOR_YELLOW_START}${BOLD}1, 2, 3 ${BOLD_END}${COLOR_END}입니다."
		;;
	esac
	echo
done

export public
