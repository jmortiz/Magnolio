/*
Battery Holder Case
---------

Print settings (Sli3r v1.1.7, these are merely my sugestions, not necessarily the best ones):
- Black ABS, 3mm filament
- layer height: 0.3
- perimeters: 4
- Solid layers: 8 (top), 8 (bottom)
- Infill: 40% honeycomb
- Speed: 50mm/s (permeters), 80mm/s (infill)
- Support Material:
	- Overhang threshold: 45º
	- Pattern: pillars
- Brim: 4mm
- Temperature: 240ºC (extruder), 120ºC (bed)

Other info:
- 3mm glass bed with kapton tape
- nozzle diameter: 0.35mm
- bed size: 170 (x), 180 (y)
- G-Code flavor: RepRap Marlin

*/

include <../body_v0.3.scad>

rotate([0,180,0]) battery_holder_case();