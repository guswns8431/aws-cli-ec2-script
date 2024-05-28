#!/bin/bash

source ./scripts/colors.sh

echo -e "${BACK_COLOR_YELLOW_START}${BOLD}############################################${BOLD_END}${COLOR_END}"
echo -e "${BACK_COLOR_YELLOW_START}${BOLD}#    aws-first-setting-for-macos.sh 시작   #${BOLD_END}${COLOR_END}"
echo -e "${BACK_COLOR_YELLOW_START}${BOLD}############################################${BOLD_END}${COLOR_END}"

source ./scripts/script-functions.sh

if ! command -v brew &> /dev/null; then
        echo "Homebrew가 설치되어 있지 않습니다. 설치를 시작합니다."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo -e "${COLOR_RED_START}AWS-CLI 패키지를 다운 받습니다${COLOR_END}"

if check_aws_cli_installed; then
    echo "aws_cli 패치지가 이미 설치되어 있습니다."
else
    echo -e "aws_cli 패키지가 설치되어 있지 않습니다.\n관리자 권한으로 설치 진행합니다.\n${COLOR_YELLOW_START}패스워드${COLOR_END}를 입력해주세요"
    sudo curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "awscliv2.pkg"
    
    echo "패키지 설치를 진행합니다"
    sudo installer -pkg ./awscliv2.pkg -target /

    if check_aws_cli_installed; then
        echo -e "${COLOR_GREEN_START}AWS CLI 설치${COLOR_END}에 성공했습니다."
	echo

    else
        echo "aws_cli 설치에 실패했습니다."
        exit 1
    fi
fi

echo -e "${COLOR_RED_START}awscliv2.pkg를 삭제합니다${COLOR_END}"
rm -rf awscliv2.pkg

echo -e "\n${COLOR_RED_START}AWS CLI 설정을 시작합니다${COLOR_END}"

echo -e "\n여러분의 소중한 KEY 보호를 위해 입력값이 보이지 않습니다\n"
read -sp "$(echo -e ${COLOR_YELLOW_START}AWS Access Key${COLOR_END}를 입력하세요 : )" access_key
echo
read -sp "$(echo -e ${COLOR_YELLOW_START}AWS Secret Access Key${COLOR_END}를 입력하세요 : )" secret_access_key
echo

PS3="기본 region을 선택하세요($(echo -e ${COLOR_YELLOW_START}1, 2${COLOR_END})) : "

select region in "ap-northeast-2" "ap-northeast-2"
do
	echo
	echo -e "${COLOR_GREEN_START}${region}${COLOR_END}을 선택하셨습니다"
	echo
	break
done
PS3="기본 출력 형식을 선택하세요($(echo -e ${COLOR_YELLOW_START}1, 2, 3${COLOR_END})) : "
echo
select format in "text" "json" "table"
do
	echo
	echo -e "${COLOR_GREEN_START}${format}${COLOR_END}을 선택하였습니다"
	echo
	break
done

echo -e "${COLOR_GREEN_START}권한 설정${COLOR_END}이 필요합니다. ${COLOR_YELLOW_START}사용자 패스워드${COLOR_END}를 입력해주세요"
sudo chown -R $(whoami) ~/.aws
sudo chmod -R u+rw ~/.aws

aws configure set aws_access_key_id $access_key
aws configure set aws_secret_access_key $secret_access_key
aws configure set region $region
aws configure set output $format

echo

echo -e "${COLOR_GREEN_START}설정이 완료되었습니다.${COLOR_END}\n\n지금부터 EC2 인스턴스 생성이 가능합니다."
