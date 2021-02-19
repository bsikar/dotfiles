#!/bin/bash

dte() {
    echo "$(date +"%A, %B %d - %I:%M %p ")"
}

cpu() {
    printf "%.2f%%" "$(awk '/cpu / {print ($2+$4)*100/($2+$4+$5)}' /proc/stat)"
}

ram() {
    printf "%.2f%%" "$(free -m | awk '/Mem/ {print ($3/$2)*100}')"
}

swp() {
    printf "%.2f%%" "$(free -m | awk '/Swap/ {print ($3/$2)*100}')"
}

while true; do
    xsetroot -name "ram: $(ram) swap: $(swp) cpu: $(cpu) $(dte)"
    sleep 30s
done
