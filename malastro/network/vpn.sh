sudo openconnect url_address.com --no-cert-check -u user_name --passwd-on-stdin < vpn_pass.txt #--script ./vpnc.sh
#firefox url_address
# OPENCONNECT_PID=""
# function checkOpenconnect{
#     ps -p "${OPENCONNECT_PID}"
#     # print the status so we can check in the main loop
#     echo $?
# }

# function startOpenConnect {
#     # start here open connect with your params and grab its pid
#     openconnect [your params] & OPENCONNECT_PID=$!
# }

# startOpenConnect

# while true
# do
#     # sleep a bit of time
#     sleep 30
#     OPENCONNECT_STATUS=$(checkOpenconnect)
#     [ $OPENCONNECT_STATUS -ne 0 ] && startOpenConnect
# done

