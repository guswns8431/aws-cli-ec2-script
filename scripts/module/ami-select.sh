#!/bin/bash

source ./scripts/colors.sh

PS3="원하는 AMI를 선택하세요"
echo

amis=("ami-0e6f2b2fa0ca704d0" "기타" "뒤로가기")

while true; do
	index=1
	for ami in "${amis[@]}"
	do
		echo -e "${COLOR_RED_START}${index}. ${ami}${COLOR_END}"
		((index++))
	done
	echo

	read -p "원하는 AMI를 선택하세요($(echo -e ${COLOR_YELLOW_START})1, 2, 3$(echo -e ${COLOR_END})) : " menu

	case $menu in
	"1")
		echo
		echo -e "${COLOR_GREEN_START}${amis[0]}(Ubuntu Server 24.04 LTS (HVM), SSD Volume Type, Free tier)${COLOR_END}를 선택하셨습니다"
        	ami=${amis[0]}
		break
      	 	;;
	"2")
		echo -e "${COLOR_GREEN_START}${BOLD}2. 기타${BOLD_END}${COLOR_END} 선택하셨습니다\n"
		echo "Amazon의 AMI 목록을 출력합니다.(시간이 소요됩니다)"
		aws ec2 describe-images --owners amazon --output table
		read -p "원하는 $(echo -e ${COLOR_YELLOW_START}AMI${COLOR_END})를 작성해주세요 : " ami
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

export ami
