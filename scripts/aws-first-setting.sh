#!/bin/bash

echo -e "${BACK_COLOR_YELLOW_START}${BOLD}##################################${BOLD_END}${COLOR_END}"
echo -e "${BACK_COLOR_YELLOW_START}${BOLD}#    aws-first-setting.sh 시작   #${BOLD_END}${COLOR_END}"
echo -e "${BACK_COLOR_YELLOW_START}${BOLD}##################################${BOLD_END}${COLOR_END}"

source ./scripts/colors.sh
source ./scripts/script-functions.sh

if check_unzip_installed; then
    echo "unzip이 이미 설치되어 있습니다."
else
    echo "unzip이 설치되어 있지 않습니다. 설치를 진행합니다."
    apt install -y unzip

    if check_unzip_installed; then
        echo "unzip 설치에 성공했습니다."
    else
        echo "unzip 설치에 실패했습니다."
        exit 1
    fi
fi

echo -e "${COLOR_RED_START}Install AWS-CLI${COLOR_RED_END}"

if check_aws_cli_installed; then
    echo "aws_cli 패치지가 이미 설치되어 있습니다."
else
    echo "aws_cli 패키지가 설치되어 있지 않습니다. 설치를 진행합니다."
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    
    echo "압축 해제를 진행합니다"
    unzip awscliv2.zip;

    echo "aws-cli install을 진행합니다"
    ./aws/install --update

    if check_aws_cli_installed; then
        echo "aws_cli 설치에 성공했습니다."
	echo

	unzip awscliv2.zip

    else
        echo "aws_cli 설치에 실패했습니다."
        exit 1
    fi
fi

echo -e "$COLOR_RED_START Remove aws.zip$COLOR_RED_END"
rm -f awscliv2.zip

echo -e "\n $COLOR_RED_START AWS 설정 파일 설정$COLOR_RED_END\n"

echo -e "\n $COLOR_RED_START 여러분의 소중한 KEY 보호를 위해 입력값이 보이지 않습니다 $COLOR_RED_END\n"
read -sp "AWS Access Key를 입력하세요 : " accesskey
read -sp "AWS Secret Access Key를 입력하세요 : " secretaccesskey

PS3="\n기본 region을 선택하세요(1,2)"
echo
select region in "ap-northeast-2" "ap-northeast-2"
do
	echo
	echo "${region}(서울)을 선택하셨습니다"
	echo
	break
done
PS3="기본 출력 형식을 선택하세요(1,2,3)"
echo
select format in "text" "json" "table"
do
	echo
	echo "${format}을 선택하였습니다"
	echo
	break
done
echo "${accesskey} ${secretaccesskey} ${region} ${format}"
aws configure set aws_access_key_id $accesskey
aws configure set aws_secret_access_key $secretaccesskey
aws configure set region $region
aws configure set output $format

echo -e "\n $COLOR_RED_START 설정 끝? $COLOR_RED_END\n"
