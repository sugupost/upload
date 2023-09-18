HOST=192.168.0.18
USER=testuser
PASS=passwd
TARGET_FILE=test1.xlsx
TARGET_DIR=test1

expect -c "
spawn scp ${TARGET_FILE} ${USER}@${HOST}:${TARGET_DIR}
expect {
\"Are you sure you want to continue connecting (yes/no)? \" {
send \"yes\r\"
expect \"password:\"
send \"${PASS}\r\"
} \"password:\" {
send \"${PASS}\r\"
}
}
interact
"
