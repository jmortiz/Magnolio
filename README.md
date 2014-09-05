Magnolio
========
An open source 3D-printed quadcopter designed with <a href="http://www.openscad.org/">OpenSCAD</a>.

<img src="http://make.kinamics.com/wp-content/uploads/2014/08/new-drone.png">

Although this project is currently at a very early development stage, you will be able to build a quadcopter with the current code. You can read about the project's progress at <a href="http://make.kinamics.com">Kinamics Blog</a>.

<h2>Usage</h2>
All of the parts are coded as a module library on file <a href="https://github.com/jmortiz/Magnolio/blob/master/3D/Magnolio_parts.scad">3D/Magnolio_parts.scad</a>. The assembled result, as seen on the above picture, is generated on file <a href="https://github.com/jmortiz/Magnolio/blob/master/3D/Magnolio_assembly.scad">3D/Magnolio_assembly.scad</a>.
Folder <a href="https://github.com/jmortiz/Magnolio/tree/master/3D/prints">3D/prints</a> contains code for generating individual parts for exporting to STL format and print. STL files already exported are provided on said folder as well.

<h2>Design</h2>
The design of the main parts is done in its entirety on OpenSCAD. The STL files for printing without modification are provided as well.

TODO:
<ul>
  <li>Provide detailed Bill of Materials including non-printed parts</li>
  <li>Build instructions</li>
</ul>

<h2>Hardware</h2>

This quadcopter and the build instructions are designed for <a href="http://copter.ardupilot.com/">Arducopter</a>, an open-source multicopter UAV controller. However, it's up to you to change it for the flight controller of your choosing, as there should be enough room for almost any controller out there.

<h2>Firmware</h2>
The original <a href="http://copter.ardupilot.com/">Arducopter</a> firmware is used for now. Some customization will be added later.


<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/4.0/88x31.png" /></a><br /><span xmlns:dct="http://purl.org/dc/terms/" property="dct:title">Magnolio</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="http://make.kinamics.com" property="cc:attributionName" rel="cc:attributionURL">Kinamics</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Attribution-ShareAlike 4.0 International License</a>.
