; homey.g
; called to home the Y axis
;
; generated by RepRapFirmware Configuration Tool v3.4.0-LPC-STM32+8 on Tue Mar 26 2024 13:50:11 GMT+0000 (Greenwich Mean Time)
M400                 ; make sure everything has stopped before we change the motor currents
M915 H200 X Y S64 R0 F0         ; set X and Y to sensitivity 3, do nothing when stall, unfiltered
M913 X50 Y50        ; drop motor currents to 20%

G91                 ; use relative positioning
G1 H2 Y1.0 F300    ; energise motors and move them 1mm in the +X direction to ensure they are not stalled
G1 H2 Z3 F5000        ; lift Z 3mm
G1 H1 Y125 F3000     ; move to the back up to 125mm, stopping at the endstop
G1 Y-5 F2000         ; move away from end
G1 H1 Y125 F3000     ; move to the back up to 125mm, stopping at the endstop
G1 Y-5 F2000         ; move away from end
G1 H2 Z-3 F1200        ; lower Z
G90                 ; back to absolute positioning

M400                 ; make sure everything has stopped before we reset the motor currents
M913 X100 Y100         ; motor currents back to 100%