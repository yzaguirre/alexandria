export SMTP_USER_PASS=""
ASUNTO=""
BODY="body.html"
TO="address1@gmail.com"
#TO="address2@gmail.com"
FROM="fromaddress@gmail.com"

mailsend-go -sub "$ASUNTO"  -smtp smtp.gmail.com -port 587 \
     auth \
      -user "$FROM" \
     -from "$FROM" -to  "$TO" \
     body \
       -msg "hello, world!"
mailsend -to $TO -from $FROM -ssl -port 465 -auth -smtp smtp.gmail.com -sub "$ASUNTO" +cc +bc -v -user $FROM -mime-type "text/html" body -msg "hello, world
