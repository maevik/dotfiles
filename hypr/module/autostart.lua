-- https://wiki.hypr.land/Configuring/Basics/Autostart/

hl.on("hyprland.start", function ()
    hl.exec_cmd("waybar")
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("awww img Documents/Wallpapers/wallhaven-72odm9_3840x2160.png")
end)
