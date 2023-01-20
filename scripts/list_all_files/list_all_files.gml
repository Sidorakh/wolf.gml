
/// @description Gets a list of files associated with the given game
/// @param {String} dir Directory to find files in
/// @param {Enum.WOLF_VERSIONS} version
function get_wolfenstein_files(dir = program_directory, version=WOLF_VERSIONS.SHAREWARE) {
	if (!string_ends_with(dir,"\\")) {
		dir += "\\";
	}
	switch (version) {
		case WOLF_VERSIONS.SHAREWARE:
			return wolfenstein_shareware(dir)
		break;
		case WOLF_VERSIONS.REGISTERED:
			return wolfenstein_registered(dir)
		break;
		case WOLF_VERSIONS.NOCTURNAL_MISSIONS:
			return wolfenstein_nocturnal_missions(dir)
		break;
		default:
			return wolfenstein_shareware(dir)
		break;
	}
}

function wolfenstein_shareware(dir) {
	return {
		audiot: dir + "AUDIOT.WL1",
		audiohead: dir + "AUDIOHEAD.WL1",
		config: dir + "CONFIG.WL1",
		gamemaps: dir + "GAMEMAPS.WL1",
		maphead: dir + "MAPHEAD.WL1",
		vgadict: dir + "VGADICT.WL1",
		vgagraph: dir + "VGAGRAPH.WL1",
		vgahead: dir + "VGAHEAD.WL1",
		vswap: dir + "VSWAP.WL1",
	}
}
function wolfenstein_registered(dir)  {
	return {
		audiot: dir + "AUDIOT.WL3",
		audiohead: dir + "AUDIOHEAD.WL3",
		config: dir + "CONFIG.WL3",
		gamemaps: dir + "GAMEMAPS.WL3",
		maphead: dir + "MAPHEAD.WL3",
		vgadict: dir + "VGADICT.WL3",
		vgagraph: dir + "VGAGRAPH.WL3",
		vgahead: dir + "VGAHEAD.WL3",
		vswap: dir + "VSWAP.WL3",
	}
}
function wolfenstein_nocturnal_missions(dir) {
	return {
		audiot: dir + "AUDIOT.WL6",
		audiohead: dir + "AUDIOHEAD.WL6",
		config: dir + "CONFIG.WL6",
		gamemaps: dir + "GAMEMAPS.WL6",
		maphead: dir + "MAPHEAD.WL6",
		vgadict: dir + "VGADICT.WL6",
		vgagraph: dir + "VGAGRAPH.WL6",
		vgahead: dir + "VGAHEAD.WL6",
		vswap: dir + "VSWAP.WL6",
	}
}