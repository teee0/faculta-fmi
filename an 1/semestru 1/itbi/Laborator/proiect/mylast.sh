#!/bin/bash

# Funcție pentru afișarea mesajului de utilizare
help() {
    echo "Utilizare: $0 [-n] [-p] [-s] [-t] [--failed]"
    echo "Opțiuni:"
    echo "  -n    Afișează ultimele N înregistrări."
    echo "  -p    Filtrează după punct de acces (tty, pts, etc.)."
    echo "  -s    Afișează înregistrările de la această dată."
    echo "  -t    Afișează înregistrările până la această dată."
    echo "  --failed    Afișează doar încercările de autentificare eșuate."
    exit 1
}

# Variabile implicite
num_records=""
start_date=""
end_date=""
point=""
failed="false"

# Procesarea argumentelor
while [[ $# -gt 0 ]]; do
    case "$1" in
        -n)
            num_records="$2"
            shift 2
            ;;
        -p)
            point="$2"
            shift 2
            ;;
        -s)
            start_date="$2"
            shift 2
            ;;
        -t)
            end_date="$2"
            shift 2
            ;;
        --failed)
            failed="true"
            shift
            ;;
        *)
            help
            ;;
    esac
done

# Combina toate fișierele auth.log
log_files="/var/log/auth.log /var/log/auth.log.[1-4].gz"
logs=$(zcat -f $log_files 2>/dev/null)

# Filtrare încercări eșuate (dacă este activat flag-ul --failed)
if [[ "$failed" == "true" ]]; then
    logs=$(echo "$logs" | grep -i "failed password")
else
    logs=$(echo "$logs" | grep -i "session opened")
fi

# Filtrare după punct de acces
if [[ -n "$point" ]]; then
    logs=$(echo "$logs" | grep "$point")
fi

# Filtrare timp
if [[ -n "$start_date" ]]; then
    logs=$(echo "$logs" | awk -v start="$start_date" '$0 >= start')
fi

if [[ -n "$end_date" ]]; then
    logs=$(echo "$logs" | awk -v end="$end_date" '$0 <= end')
fi

# ultimele N înregistrări
if [[ -n "$num_records" ]]; then
    logs=$(echo "$logs" | tail -n "$num_records")
fi

# Afișare rezultate
echo "$logs"
