
//file = buffer_load("E:\\dev\\id\\wolfenstein\\palette.pal");
//palette = [];

//repeat (256) {
//	var r = buffer_read(file,buffer_u8);
//	var g = buffer_read(file,buffer_u8);
//	var b = buffer_read(file,buffer_u8);
//	var c = make_color_rgb(b,g,r); // create as bgr, to export rgb
//	array_push(palette,c);
//}

//clipboard_set_text(json_stringify(palette));

// You can download the shareware version of Wolfenstein here: https://archive.org/details/wolf3dsw

var shareware_dir = "E:\\dev\\id\\wolfenstein\\shareware";
var nocturnal_missions_dir = "E:\\dev\\id\\wolfenstein\\nocturnal";

var version = WOLF_VERSIONS.NOCTURNAL_MISSIONS;
var dir = shareware_dir;

switch (version) {
	case WOLF_VERSIONS.SHAREWARE:
		dir = shareware_dir;
	break
	case WOLF_VERSIONS.NOCTURNAL_MISSIONS:
		dir = nocturnal_missions_dir;
	break
}


global.files = get_wolfenstein_files(dir,version);

global.resources = decode_vswap(global.files.vswap);

global.maps = wolf_decode_map_files(global.files.maphead,global.files.gamemaps)

global.current_map = 0;



room_goto(rm_game_test);
