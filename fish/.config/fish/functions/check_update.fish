#! /usr/bin/env/fish
function check_update
set target_file ~/.last_update
# 3 Tage in Sekunden (3 * 86400)
set limit 259200 

# Wir prüfen erst, ob das Siegel überhaupt existiert
if test -f $target_file
    # 'date -r' holt sich den Zeitstempel der letzten Änderung der Datei
    set last_touch (date -r $target_file +%s)
    set current_time (date +%s)
    set age (math $current_time - $last_touch)

    if test $age -ge $limit
        echo "⚠️  There may be Updates for your system. Please run the sysupdate command. 🐉"
        # Hier könntest du dein Update-Skript direkt triggern
    else
        # Optional: Nur damit du weißt, dass alles okay ist
        # echo "Alles ruhig im Warp. Letztes Update war vor "(math $age / 3600)" Stunden."
    end
end
end
