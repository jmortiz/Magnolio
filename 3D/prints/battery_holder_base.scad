/*
Battery Holder Base

Print settings (Sli3r v1.1.7, these are merely my sugestions, not necessarily the best ones):
- Black ABS, 3mm filament
- layer height: 0.3
- perimeters: 4
- Solid layers: 3 (top), 3 (bottom)
- Infill: 100% rectilinear
- Speed: 50mm/s (permeters), 80mm/s (infill)
- Support Material: No
- Temperature: 240ºC (extruder), 120ºC (bed)

Other info:
- 3mm glass bed with kapton tape
- nozzle diameter: 0.35mm
- bed size: 170 (x), 180 (y)
- G-Code flavor: RepRap Marlin

*/

include <../Magnolio_parts.scad>

battery_holder_base();