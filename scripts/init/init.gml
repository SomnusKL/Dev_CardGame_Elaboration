// v2.3.0的脚本资产已更改，请参见\ n // https://help.yoyogames.com/hc/en-us/articles/360005277377
gml_pragma("global", "init()");


#region Particle Types

//Basic PARTICLE
var _p = part_type_create();

part_type_shape(_p, pt_shape_disk);
part_type_life(_p, 20, 40);

part_type_alpha2(_p, 1,0);
part_type_color2(_p, c_red, c_white);
part_type_size(_p, 0.1,0.5, 0.02, 0.02);
part_type_speed(_p, 2, 4, 0,0);
part_type_direction(_p, 0, 360, 0,0);
part_type_gravity(_p, 0.1, 270);

global.ptBasic = _p;

#endregion