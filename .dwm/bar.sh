dte() {
	dte="$(date +"%A, %B %d - %I:%M %p")"
	echo -e "$dte"
}

while true; do
	xsetroot -name "$(dte)"
	sleep 30s
done
