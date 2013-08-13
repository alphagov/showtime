until `./run.sh`; do
    echo "Showtime crashed with exit code $?.  Respawning.." >&2
    sleep 4
done