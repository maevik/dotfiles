#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "--- Must be run with sudo or as root."
   exit 1
fi

echo "--- Cleaning DNF caches and unused files..."
dnf clean all
rm -rf /var/cache/dnf/*

echo "--- Checking for and removing orphaned packages..."
while true; do
    orphans=$(dnf repoquery --uninstalled --qf "%{name}")
    if [[ -n "$orphans" ]]; then
        echo "    -- Removing orphans: $orphans"
        dnf remove -y $orphans
    else
        echo "    -- No more orphaned packages found."
        break
    fi
done

echo "--- Cleaning system journal logs..."
journalctl --vacuum-time=1d

echo "--- Cleaning temporary directories..."
rm -rf /tmp/* /var/tmp/*

echo "--- Performing deep clean on all user directories..."
rm -rf /home/*/.cache/*

rm -rf /home/*/.local/share/Trash/files/*
rm -rf /home/*/.local/share/Trash/info/*

rm -rf /home/*/.var/app/*/cache/*

if command -v update-desktop-database &> /dev/null; then
    update-desktop-database &> /dev/null || true
fi

echo "--- Deep cleanup completed successfully!"
