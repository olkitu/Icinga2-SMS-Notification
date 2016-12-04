# Icinga2-SMS-Notification

Simple SMS Notification to Icinga2. 

## Requirements

* Curl

## Download & Configure

Download sms-host-notification.sh to scripts directory.

constrants.conf
```
const SmsUsername "demo"
const SmsPassword "demo"
```

commands.conf

```
object NotificationCommand "sms-host-notification" {
  import "plugin-notification-command"

  command = [ SysconfDir + "/icinga2/scripts/sms-host-notification.sh" ]

  env = {
    NOTIFICATIONTYPE = "$notification.type$"
    HOSTALIAS = "$host.display_name$"
    HOSTADDRESS = "$address$"
    HOSTSTATE = "$host.state$"
    LONGDATETIME = "$icinga.long_date_time$"
    HOSTOUTPUT = "$host.output$"
    NOTIFICATIONAUTHORNAME = "$notification.author$"
    NOTIFICATIONCOMMENT = "$notification.comment$"
    HOSTDISPLAYNAME = "$host.display_name$"
    SMS_USERNAME = SmsUsername
    SMS_PASSWORD = SmsPassword
    SMS_PHONE = "$user.vars.sms_phone$"
  }
}
```
notifications.conf

```
apply Notification "sms-notification" to Host {
  import "sms-host-notification"

  user_groups = host.vars.notification.sms.groups
  users = host.vars.notification.sms.users


  interval = 0


  assign where host.vars.notification.sms
}
```

templates.conf

```
template Notification "sms-host-notification" {
  command = "sms-host-notification"

  states = [ Down ]
  types = [ Problem, Recovery ]


  period = "24x7"
}
```

users.conf

```

object User "icingaadmin" {
  import "generic-user"

  display_name = "Icinga 2 Admin"
  groups = [ "icingaadmins" ]
  
  vars.sms_phone = "<phonenumber>"
}
  
 ````
