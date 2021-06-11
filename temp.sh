LOG_FILE=./oc_temp.log
if [[ ! -f "./oc_temp.log" ]]
then touch oc_temp.log && echo "Created oc_temp.log file"
fi

echo -e "$(date) @ $(hostname)" | tee -a ${LOG_FILE}
echo -e "-------------------------------------------"
echo -e "CPU\t\t\tGPU\t\t\tTIME"

while true; do
cpu_temp=$(cat /sys/class/thermal/thermal_zone0/temp)
gpu_temp=$(vcgencmd measure_temp | cut -d = -f2 | cut -d . -f 1)
arm_clock=$(vcgencmd measure_clock arm  | cut -d = -f2)
gpu_clock=$(vcgencmd measure_clock core  | cut -d = -f2)

echo -e "$((cpu_temp/1000))'C\t$((arm_clock/1000000))MHz\t\t$((gpu_temp))'C\t$((gpu_clock/1000000))MHz\t\t$(date -I'seconds')" | tee -a ${LOG_FILE}
sleep 3
done
