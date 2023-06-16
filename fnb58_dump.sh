#!/bin/bash

# just change to your MAC....
BT_MAC="BA:03:1C:67:56:22";

OLD_IFS=$IFS;

IFS='
';


for CHARACTERISTICS_LIST_ITEM in $(gatttool --adapter=hci0 --device=$BT_MAC --char-desc); do
       # echo "$CHARACTERISTICS_LIST_ITEM";

       # HANDLE=$(echo "$CHARACTERISTICS_LIST_ITEM" | awk '{ print $12 }' | tr -d ',');
       HANDLE=$(echo "$CHARACTERISTICS_LIST_ITEM" | awk '{ print $3 }' | tr -d ',');
       # echo "HANDLE = $HANDLE";

       # UUID=$(echo "$CHARACTERISTICS_LIST_ITEM" | awk '{ print $15 }');
       UUID=$(echo "$CHARACTERISTICS_LIST_ITEM" | awk '{ print $6 }');
       # echo "UUID = $UUID";

       # echo "HANDLE = $HANDLE, UUID = $UUID";

       OUT_STRING=$(gatttool --adapter=hci0 --device=$BT_MAC --char-read --handle=$HANDLE 2>&1);

       OUT=$(echo "$OUT_STRING" | awk '{ s = ""; for (i = 3; i <= NF; i++) s = s $i " "; print s }');
       # echo "OUT = $OUT";

       FOUT=$( echo "$OUT_STRING" | grep 'Characteristic value/descriptor:');
       if [ -n "$FOUT" ]; then
	       echo "$UUID";
	       echo "73 74 72 69 6E 67 3A 20 ${OUT}" | sed -e 's#Characteristic value/descriptor: ##' | xxd -r -p | strings;
               # echo "$UUID $HANDLE ${FOUT}0A" | sed -e 's#Characteristic value/descriptor: ##';
               echo "$HANDLE ${FOUT}" | sed -e 's#Characteristic value/descriptor: ##';
	       echo;
       fi
       # sleep 0.1;
done

IFS=$OLD_IFS;

