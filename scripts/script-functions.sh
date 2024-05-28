check_unzip_installed() {
    if command -v unzip &> /dev/null; then
        return 0
    else
        return 1
    fi
}

check_aws_cli_installed() {
	if command -v aws &> /dev/null; then
		return 0
	else
		return 1
	fi
}
