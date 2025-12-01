ip addr | tail -4 | head -1 | cut -d ' ' -f 6 | tr -d '/24'
