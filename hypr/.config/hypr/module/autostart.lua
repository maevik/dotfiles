-- https://wiki.hypr.land/Configuring/Basics/Autostart/

hl.on("hyprland.start", function ()
    hl.exec_cmd("waybar")
    hl.exec_cmd("hyprsunset")
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("awww img Documents/Wallpapers/castorice-5k-anime-3840x2160-22295.jpg")
end)
