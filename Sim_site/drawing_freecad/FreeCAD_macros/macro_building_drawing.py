#***********************************************************************
#*                                                                     *
#*   File:                                                             *
#*   	macro_building_drawing.py                                      *
#*                                                                     *
#*   Author:                                                           *
#*      Amritpal Singh <amrit3701@gmail.com>                           *
#*                                                                     *
#*   Brief:                                                            *
#*      This program file contain FreeCAD macros.                      *
#*                                                                     *
#***********************************************************************

import csv, sys
sys.path.insert(0, '.')

from building_func import *
print 23
FreeCAD.newDocument("project")
FreeCAD.setActiveDocument("project")
#plinth_lev = int(plinth_lev)

i = 0
j = 0
k = 0
nodes = []
z = 0
print 0
#Drawing ground plane to depict ground level
plane([-3, -3, plinth_lev - 2 * plinth_lev], x_sum(no_spans_len) + 6, y_sum(no_span_wid) + 6)
print 2
#Drawing plinth plane to depict plinth level
plane([0, 0, 0], x_sum(no_spans_len), y_sum(no_span_wid))

print 1

while z <= stories:
	x = 0
	while x <= no_spans_len:
		y = 0
		while y <= no_span_wid:
			coords = [x_sum(x), y_sum(y), z_sum(z)]
			nodes.append(coords)

			# If building is 0 storey, height will be equal to ground level
			if z == 0:
				col_name = "Column" + str(i)
				i = i + 1

				# If column is rectangular
				if col_type == 1:
				 	make_box(col_name, len_col, wid_col, dep_of_foun + plinth_lev, [coords[0] - len_col / 2.0, coords[1] - wid_col / 2.0, dep_of_foun + plinth_lev - 2 * (dep_of_foun + plinth_lev)], [0.00, 0.00, 0.00, 1.00])

				# If column is cylinderical
				else:
				 	make_cylinder(col_name, radius_col, dep_of_foun + plinth_lev, [coords[0], coords[1], dep_of_foun + plinth_lev - 2 * (dep_of_foun + plinth_lev)], [0.00, 0.00, 0.00, 1.00])
			else:
				col_name = "Column" + str(i)
				i = i + 1
				if col_type == 1:
                                        # make_box(name, length, width, height, base_vector, base_rotation)
					make_box(col_name, len_col, wid_col, z_sum(z) -  z_sum(z-1), [coords[0] - len_col/2.0, coords[1] - wid_col/2.0, z_sum(z-1)], [0.00, 0.00, 0.00, 1.00])
				else:
					make_cylinder(col_name, radius_col, z_sum(z) - z_sum(z-1), [coords[0], coords[1], z_sum(z-1)], [0.00, 0.00, 0.00, 1.00])

			# Creating beams width wise.
			if y != 0 and z != 0:
				beam_name = "Beam" + str(j)
				j = j + 1
				make_box(beam_name, wid_beam, y_sum(y) - y_sum(y - 1), dep_beam, [coords[0] - wid_beam / 2.0, y_sum(y - 1), z_sum(z) - dep_beam / 2.0], [0.00, 0.00, 0.00, 1.00])

			# Creating beams length wise.
			if x != 0 and z != 0:
				beam_name = "Beam" + str(j)
				j = j + 1
				make_box(beam_name, x_sum(x) - x_sum(x - 1), wid_beam, dep_beam, [x_sum(x - 1), coords[1] - wid_beam / 2.0, z_sum(z) - dep_beam / 2.0], [0.00, 0.00, 0.00, 1.00])

			y = y + 1
		x = x + 1

	# If building has some height, i.e. "z != 0", only then slab can come into existance.
	if z != 0:
		slab_name = "Slab" + str(k)
		k = k + 1
		make_box(slab_name, x_sum(no_spans_len), y_sum(no_span_wid), dep_slab, [0, 0, z_sum(z) + dep_beam / 2.0 - dep_slab], [0.00, 0.00, 0.00, 1.00])

	z = z + 1
#FreeCAD.Gui.SendMsgToActiveView("ViewFit")
#FreeCAD.Gui.activeDocument().activeView().viewAxometric()
FreeCAD.Console.PrintMessage("fdfffdf\n")
print z_sum

# Storing all objects (i.e parts of building like column, beams and slabs)
# in obj_list
obj_list = FreeCAD.ActiveDocument.Objects

# Adding object 'Compound' in active document. The Compound object stores
# all parts of the building
FreeCAD.activeDocument().addObject("Part::Compound","Compound")

# Links all the objects present in obj_list to Compound
FreeCAD.activeDocument().Compound.Links = obj_list
