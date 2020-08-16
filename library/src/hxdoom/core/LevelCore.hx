package hxdoom.core;

import hxdoom.Engine;
import hxdoom.lumps.Directory;
import hxdoom.component.LevelMap;
import hxdoom.typedefs.data.EpisodeProperties;
import hxdoom.typedefs.data.MapProperties;

/**
 * ...
 * @author Kaelan
 */
class LevelCore 
{
	public var levelData:Array<MapProperties>;
	public var episodeData:Array<EpisodeProperties>;
	public var currentMap:LevelMap;
	public var currentMapData:MapProperties;
	public var currentEpisodeData:EpisodeProperties;
	
	public var needToRebuild:Bool = true;
	
	public function new() 
	{
		
	}
	
	public function startEpisode(_index:Int) {
		if (episodeData == null) {
			trace("Episode data undefined!");
			return;
		}
		startMap(episodeData[_index].firstLevel);
	}
	
	public function startMap(_index:Int) {
		if (levelData == null) {
			trace("Level data undefined!");
			return;
		}
		loadMap(levelData[_index].internalName);
		currentMapData = levelData[_index];
	}
	public function exitMapNormal() {
		if (levelData == null) {
			trace("Level data undefined!");
			return;
		}
		currentMapData = levelData[currentMapData.nextMap];
		loadMap(currentMapData.internalName);
	}
	public function exitMapSecret() {
		if (levelData == null) {
			trace("Level data undefined!");
			return;
		}
		currentMapData = levelData[currentMapData.nextMapSecret];
		loadMap(currentMapData.internalName);
	}
	
	
	public function loadMap(_mapMarker:String):Bool {
		
		if (!Engine.WADDATA.wadContains([_mapMarker])) {
			return false;
		}
		
		var place:Int = 0;
		var numitems:Int = 0;
		
		var _map = new LevelMap();
		var mapmarker:Directory = Engine.WADDATA.getGeneralDir(_mapMarker);
		var byteData = Engine.WADDATA.getWadByteArray(mapmarker.wad);
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		//Load things
		////////////////////////////////////////////////////////////////////////////////////////////////////
		if (Engine.WADDATA.getWadSpecificDir(mapmarker.wad, mapmarker.index + 1).name != hxdoom.enums.eng.KeyLump.THINGS) {
			Engine.log("Map data corrupt: Expected Things, found: " + Engine.WADDATA.getWadSpecificDir(mapmarker.wad, mapmarker.index + 1).name);
			return false;
		}
		numitems = Std.int(Engine.WADDATA.getWadSpecificDir(mapmarker.wad, mapmarker.index + 1).size / Reader.THING_LUMP_SIZE);
		place = Engine.WADDATA.getWadSpecificDir(mapmarker.wad, mapmarker.index + 1).dataOffset;
		for (a in 0...numitems) {
			_map.things[a] = Reader.readThing(byteData, place + a * Reader.THING_LUMP_SIZE);
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		//Load linedefs
		////////////////////////////////////////////////////////////////////////////////////////////////////
		if (Engine.WADDATA.getWadSpecificDir(mapmarker.wad, mapmarker.index + 2).name != hxdoom.enums.eng.KeyLump.LINEDEFS) {
			Engine.log("Map data corrupt: Expected Linedefss, found: " + Engine.WADDATA.getWadSpecificDir(mapmarker.wad, mapmarker.index + 2).name);
			return false;
		}
		numitems = Std.int(Engine.WADDATA.getWadSpecificDir(mapmarker.wad, mapmarker.index + 2).size / Reader.LINEDEF_LUMP_SIZE);
		place = Engine.WADDATA.getWadSpecificDir(mapmarker.wad, mapmarker.index + 2).dataOffset;
		for (a in 0...numitems) {
			_map.linedefs[a] = Reader.readLinedef(byteData, place + a * Reader.LINEDEF_LUMP_SIZE);
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		//Load sidedefs
		////////////////////////////////////////////////////////////////////////////////////////////////////
		if (Engine.WADDATA.getWadSpecificDir(mapmarker.wad, mapmarker.index + 3).name != hxdoom.enums.eng.KeyLump.SIDEDEFS) {
			Engine.log("Map data corrupt: Expected Sidedefs, found: " + Engine.WADDATA.getWadSpecificDir(mapmarker.wad, mapmarker.index + 3).name);
			return false;
		}
		numitems = Std.int(Engine.WADDATA.getWadSpecificDir(mapmarker.wad, mapmarker.index + 3).size / Reader.SIDEDEF_LUMP_SIZE);
		place = Engine.WADDATA.getWadSpecificDir(mapmarker.wad, mapmarker.index + 3).dataOffset;
		for (a in 0...numitems) {
			_map.sidedefs[a] = Reader.readSideDef(byteData, place + a * Reader.SIDEDEF_LUMP_SIZE);
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		//Load vertexes
		////////////////////////////////////////////////////////////////////////////////////////////////////
		if (Engine.WADDATA.getWadSpecificDir(mapmarker.wad, mapmarker.index + 4).name != hxdoom.enums.eng.KeyLump.VERTEXES) {
			Engine.log("Map data corrupt: Expected Vertexes, found: " + Engine.WADDATA.getWadSpecificDir(mapmarker.wad, mapmarker.index + 4).name);
			return false;
		}
		numitems = Std.int(Engine.WADDATA.getWadSpecificDir(mapmarker.wad, mapmarker.index + 4).size / Reader.VERTEX_LUMP_SIZE);
		place = Engine.WADDATA.getWadSpecificDir(mapmarker.wad, mapmarker.index + 4).dataOffset;
		for (a in 0...numitems) {
			_map.vertexes[a] = Reader.readVertex(byteData, place + a * Reader.VERTEX_LUMP_SIZE);
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		//Load segments
		////////////////////////////////////////////////////////////////////////////////////////////////////
		if (Engine.WADDATA.getWadSpecificDir(mapmarker.wad, mapmarker.index + 5).name != hxdoom.enums.eng.KeyLump.SEGS) {
			Engine.log("Map data corrupt: Expected Segments, found: " + Engine.WADDATA.getWadSpecificDir(mapmarker.wad, mapmarker.index + 5).name);
			return false;
		}
		numitems = Std.int(Engine.WADDATA.getWadSpecificDir(mapmarker.wad, mapmarker.index + 5).size / Reader.SEG_LUMP_SIZE);
		place = Engine.WADDATA.getWadSpecificDir(mapmarker.wad, mapmarker.index + 5).dataOffset;
		for (a in 0...numitems) {
			_map.segments[a] = Reader.readSegment(byteData, place + a * Reader.SEG_LUMP_SIZE);
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		//Load Subsectors
		////////////////////////////////////////////////////////////////////////////////////////////////////
		if (Engine.WADDATA.getWadSpecificDir(mapmarker.wad, mapmarker.index + 6).name != hxdoom.enums.eng.KeyLump.SSECTORS) {
			Engine.log("Map data corrupt: Expected Subsectors, found: " + Engine.WADDATA.getWadSpecificDir(mapmarker.wad, mapmarker.index + 6).name);
			return false;
		}
		numitems = Std.int(Engine.WADDATA.getWadSpecificDir(mapmarker.wad, mapmarker.index + 6).size / Reader.SSECTOR_LUMP_SIZE);
		place = Engine.WADDATA.getWadSpecificDir(mapmarker.wad, mapmarker.index + 6).dataOffset;
		for (a in 0...numitems) {
			_map.subsectors[a] = Reader.readSubSector(byteData, place + a * Reader.SSECTOR_LUMP_SIZE);
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		//Load nodes
		////////////////////////////////////////////////////////////////////////////////////////////////////
		if (Engine.WADDATA.getWadSpecificDir(mapmarker.wad, mapmarker.index + 7).name != hxdoom.enums.eng.KeyLump.NODES) {
			Engine.log("Map data corrupt: Expected Nodes, found: " + Engine.WADDATA.getWadSpecificDir(mapmarker.wad, mapmarker.index + 7).name);
			return false;
		}
		numitems = Std.int(Engine.WADDATA.getWadSpecificDir(mapmarker.wad, mapmarker.index + 7).size / Reader.NODE_LUMP_SIZE);
		place = Engine.WADDATA.getWadSpecificDir(mapmarker.wad, mapmarker.index + 7).dataOffset;
		for (a in 0...numitems) {
			_map.nodes[a] = Reader.readNode(byteData, place + a * Reader.NODE_LUMP_SIZE);
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		//Load sectors
		////////////////////////////////////////////////////////////////////////////////////////////////////
		if (Engine.WADDATA.getWadSpecificDir(mapmarker.wad, mapmarker.index + 8).name != hxdoom.enums.eng.KeyLump.SECTORS) {
			Engine.log("Map data corrupt: Expected Sectors, found: " + Engine.WADDATA.getWadSpecificDir(mapmarker.wad, mapmarker.index + 8).name);
			return false;
		}
		numitems = Std.int(Engine.WADDATA.getWadSpecificDir(mapmarker.wad, mapmarker.index + 8).size / Reader.SECTOR_LUMP_SIZE);
		place = Engine.WADDATA.getWadSpecificDir(mapmarker.wad, mapmarker.index + 8).dataOffset;
		for (a in 0...numitems) {
			_map.sectors[a] = Reader.readSector(byteData, place + a * Reader.SECTOR_LUMP_SIZE);
		}
		
		//Map name as stated in WAD, IE E#M#/MAP##
		_map.name = Engine.WADDATA.getWadSpecificDir(mapmarker.wad, mapmarker.index).name;
		
		currentMap = _map;
		currentMap.parseThings();
		currentMap.setOffset();
		currentMap.build();
		
		needToRebuild = true;
		
		return true;
	}
}