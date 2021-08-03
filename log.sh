# This script parses maillog and write some analytics to result.txt
# IUziev

# 2020-08-24 11:21:03.531103500 - Date and time of record
# info - log level
# (32407) - PID?
# Message processed - info details
# from=email: test1@mail.ru
# to=email: user@test.local
# archived=Y - Y/N archived factor
# sent=N - Y/N sent factor
# w_time=2446 - wasted?waited? time in msec
# msec - w_time measurement
# msg_size=102980 - message size
# bytes - message size measurement
# events=3 - what was happening with the message
# blocked=Y - Y/N blocked factor

touch result.txt

days=( $(awk ' !seen[$1]++ {print $1}' data.log) )

for day in "${days[@]}"
do  
    s=$(grep $day data.log | awk -F "msg_size=" '{ sum += $NF-0 } END {print sum/1024/1024}')
    echo "$day $s MB" >> result.txt
done

for day in "${days[@]}"
do  
    s=$(grep $day data.log | awk -F "w_time=" '{ sum += $(NF)} END {print sum/NR}')
    echo "$day $s" >> result.txt
done

s=$(grep 'archived=N\|sent=N' data.log | wc -l)
echo "$day $s" >> result.txt

s=$(grep 'archived=Y\|blocked=Y' data.log | wc -l)
echo "$day $s" >> result.txt

wc -l data.log >> result.txt

size=$(grep 'from=email: test@ya.ru' data.log | awk -F "msg_size=" '{ sum += $(NF) } END {print sum/NR}')
time=$(grep 'from=email: test@ya.ru' data.log | awk -F "w_time=" '{ sum += $(NF)} END {print sum/NR}')
echo "$size $time" >> result.txt