#!/bin/bash

source ./scripts/colors.sh

echo -e "${BACK_COLOR_YELLOW_START}${BOLD}#################################${BOLD_END}${COLOR_END}"
echo -e "${BACK_COLOR_YELLOW_START}${BOLD}#    aws-run-instance.sh 시작   #${BOLD_END}${COLOR_END}"
echo -e "${BACK_COLOR_YELLOW_START}${BOLD}#################################${BOLD_END}${COLOR_END}"


source ./scripts/module/ami-select.sh
source ./scripts/module/instance-number-select.sh
source ./scripts/module/instance-type-select.sh
source ./scripts/module/key-pair-select.sh
source ./scripts/module/subnet-select.sh
source ./scripts/module/security-group-select.sh
source ./scripts/module/public-ip-select.sh

aws ec2 run-instances \
	--image-id $ami \
	--count $count \
	--instance-type $instance_type \
	--subnet-id $subnet \
	--key-name $key_pair \
	--security-group-ids $security_group \
	$public
