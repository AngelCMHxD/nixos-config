{ inputs, pkgs, ... }:
{
    imports = [
        inputs.mangowm.hmModules.mango
    ];

    wayland.windowManager.mango = {
        enable = true;
        settings = {
            xkb_rules_layout = "latam";
            trackpad_natural_scrolling = 1;
            sloppyfocus = 0;
            numlockon = 1;

            border_radius = 3;
            rootcolor = "0xc6a0f6ff";
            maximizescreencolor = "0xc6a0f6ff";
            focuscolor = "0xc6a0f6ff";
            bordercolor = "0x6e738dff";

            animation_duration_move = 200;
            animation_duration_open = 200;
            animation_duration_tag = 200;
            animation_duration_close = 200;
            animation_duration_focus = 200;

            gappih = 4;
            gappiv = 4;
            gappoh = 4;
            gappov = 4;

            exec-once = [
                "noctalia"
           	];

            tagrule = [
                "id:1,layout_name:scroller"
                "id:2,layout_name:scroller"
                "id:3,layout_name:scroller"
                "id:4,layout_name:scroller"
                "id:5,layout_name:scroller"
                "id:6,layout_name:scroller"
                "id:7,layout_name:scroller"
                "id:8,layout_name:scroller"
                "id:9,layout_name:scroller"
            ];

            gesturebind = [
                "none,left,3,viewtoright_have_client"
                "none,right,3,viewtoleft_have_client"
            ];

           	bind = [
                "SUPER+SHIFT,r,reload_config"
                "SUPER,Return,spawn,ghostty"
                "SUPER,Backspace,killclient,"
                "SUPER,F,togglemaximizescreen,"

                # Noctalia
                "SUPER,r,spawn,noctalia msg panel-toggle launcher"
                "SUPER,l,spawn,noctalia msg screen-lock"
                "SUPER+CTRL+SHIFT,s,spawn,noctalia msg settings-toggle"
                "SUPER+CTRL+SHIFT,w,spawn,noctalia msg panel-toggle wallpaper"
                "SUPER,v,spawn,noctalia msg panel-toggle clipboard"
                "SUPER+CTRL+SHIFT,n,spawn,pkill noctalia ; noctalia -d"
                "NONE,XF86PowerOff,spawn,noctalia msg panel-toggle session"
                "NONE,Print,spawn,noctalia msg screenshot-region"
                "SUPER+SHIFT,s,spawn,noctalia msg screenshot-region"
                "SHIFT,Print,spawn,noctalia msg screenshot-fullscreen"

                # Resize windows
                "SUPER,minus,resizewin,-10,0"
                "SUPER,plus,resizewin,+10,0"

                # Switch window focus
                "SUPER,Left,focusdir,left"
                "SUPER,Right,focusdir,right"
                "SUPER,Up,focusdir,up"
                "SUPER,Down,focusdir,down"

                # Swap windows
                "SUPER+SHIFT,Up,exchange_client,up"
                "SUPER+SHIFT,Down,exchange_client,down"
                "SUPER+SHIFT,Left,exchange_client,left"
                "SUPER+SHIFT,Right,exchange_client,right"

                # Switch tags with arrow keys
                "CTRL+SUPER,Left,viewtoleft,left"
                "CTRL+SUPER,Right,viewtoright,right"

                # Switch to tag
                "SUPER,1,view,1,0"
                "SUPER,2,view,2,0"
                "SUPER,3,view,3,0"
                "SUPER,4,view,4,0"
                "SUPER,5,view,5,0"
                "SUPER,6,view,6,0"
                "SUPER,7,view,7,0"
                "SUPER,8,view,8,0"
                "SUPER,9,view,9,0"

                # Move window to tag
                "SUPER+SHIFT,1,tag,1,0"
                "SUPER+SHIFT,2,tag,2,0"
                "SUPER+SHIFT,3,tag,3,0"
                "SUPER+SHIFT,4,tag,4,0"
                "SUPER+SHIFT,5,tag,5,0"
                "SUPER+SHIFT,6,tag,6,0"
                "SUPER+SHIFT,7,tag,7,0"
                "SUPER+SHIFT,8,tag,8,0"
                "SUPER+SHIFT,9,tag,9,0"
            ];
        };
    };
}
