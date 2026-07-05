-- https://wiki.hypr.land/Configuring/Basics/Autostart/

hl.on("hyprland.start", function ()
    hl.exec_cmd("waybar")
    hl.exec_cmd("hyprsunset")

    hl.exec_cmd("awww-daemon")
    
    hl.exec_cmd("~/.config/hypr/wallpaper.sh")
end)
