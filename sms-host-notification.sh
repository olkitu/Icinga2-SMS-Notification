#!/bin/sh
template=$(cat <<TEMPLATE
*$NOTIFICATIONTYPE-$HOSTDISPLAYNAME-is-$HOSTSTATE*
TEMPLATE
)

/usr/bin/curl --output "/var/log/icinga2/smslog" "https://ip-address/send.html?l=${SMS_USERNAME}&p=${SMS_PASSWORD}&n=${SMS_PHONE}&m=${template}"