package packages.wad;

import packages.wad.Directory;
import packages.wad.maplumps.LineDef;
import packages.wad.maplumps.Node;
import packages.wad.maplumps.Segment;
import packages.wad.maplumps.SubSector;
import packages.wad.maplumps.Thing;
import packages.wad.maplumps.Vertex;

/**
 * ...
 * @author Kaelan
 */
class Reader 
{
	public static inline var VERTEX_LUMP_SIZE:Int = 4;
	public static inline var LINEDEF_LUMP_SIZE:Int = 14;
	public static inline var THING_LUMP_SIZE:Int = 10;
	public static inline var NODE_LUMP_SIZE:Int = 28;
	public static inline var SSECTOR_LUMP_SIZE:Int = 4;
	public static inline var SEG_LUMP_SIZE:Int = 12;
	
	public function new() { }
	
	public function readDirectory(_data:Array<Int>, _offset:Int):Directory {
		return new Directory(
			getFourBytes(_data, _offset),
			getFourBytes(_data, _offset + 0x04),
			stringFromBytesRange(_data, _offset + 0x08, _offset + 0x10)
		);
	}
	
	public function readThing(_data:Array<Int>, _offset:Int):Thing {
		return new Thing(
			getTwoBytes(_data, _offset, true),
			getTwoBytes(_data, _offset + 2, true),
			getTwoBytes(_data, _offset + 4, true),
			getTwoBytes(_data, _offset + 6, true),
			getTwoBytes(_data, _offset + 8, true)
		);
	}
	
	public function readLinedef(_data:Array<Int>, _offset:Int, _vertexes:Array<Vertex>):LineDef {
		return new LineDef(
			_vertexes,
			getTwoBytes(_data, _offset),
			getTwoBytes(_data, _offset + 2),
			getTwoBytes(_data, _offset + 4),
			getTwoBytes(_data, _offset + 6),
			getTwoBytes(_data, _offset + 8),
			getTwoBytes(_data, _offset + 10),
			getTwoBytes(_data, _offset + 12)
		);
	}
	
	public function readVertex(_data:Array<Int>, _offset:Int):Vertex {
		return new Vertex(
			getTwoBytes(_data, _offset, true),
			getTwoBytes(_data, _offset + 2, true)
		);
	}
	
	public function readSegment(_data:Array<Int>, _offset:Int, _linedefs:Array<LineDef>):Segment {
		return new Segment(
			_linedefs,
			getTwoBytes(_data, _offset + 4, true),
			getTwoBytes(_data, _offset + 6),
			getTwoBytes(_data, _offset + 8),
			getTwoBytes(_data, _offset + 10)
		);
	}
	
	public function readSubSector(_data:Array<Int>, _offset:Int, _segments:Array<Segment>):SubSector {
		return new SubSector(
			_segments,
			getTwoBytes(_data, _offset),
			getTwoBytes(_data, _offset + 2)
		);
	}
	
	public function readNode(_data:Array<Int>, _offset:Int):Node {
		return new Node(
			getTwoBytes(_data, _offset, true),
			getTwoBytes(_data, _offset + 2, true),
			getTwoBytes(_data, _offset + 4, true),
			getTwoBytes(_data, _offset + 6, true),
			getTwoBytes(_data, _offset + 8, true),
			getTwoBytes(_data, _offset + 10, true),
			getTwoBytes(_data, _offset + 12, true),
			getTwoBytes(_data, _offset + 14, true),
			getTwoBytes(_data, _offset + 16, true),
			getTwoBytes(_data, _offset + 18, true),
			getTwoBytes(_data, _offset + 20, true),
			getTwoBytes(_data, _offset + 22, true),
			getTwoBytes(_data, _offset + 24),
			getTwoBytes(_data, _offset + 26)
		);
	}
	/**
	 * Get a 16bit value from provided address by "reading" a byte of information.
	 * @param	_data Data of current wad loaded
	 * @param	_offset Position of data needed
	 * @param	_signed Is value an signed value?
	 * @return Returns an integer from specified position
	 */
	public function getTwoBytes(_data:Array<Int>, _offset:Int, _signed:Bool = false):Int //16 bits
	{
		var val = (_data[_offset + 1] << 8) | _data[_offset];
		return(_signed == true && val > 32768 ? val - 65536 : val);
	}
	/**
	 * Get a 32bit value from provided address by "reading" two bytes of information.
	 * @param	_data Data of current wad loaded
	 * @param	_offset Position of data needed
	 * @return Returns an integer from specified position
	 */
	public function getFourBytes(_data:Array<Int>, _offset:Int):Int {
		return((_data[_offset + 3] << 24) | (_data[_offset + 2] << 16) | (_data[_offset + 1] << 8) | _data[_offset]);
	}
	/**
	 * Get a string value from specified range 
	 * @param	_data Data of current wad loaded
	 * @param	_start Start position of string
	 * @param	_end End position of string
	 * @return	Returns a UTF8 compatible string. Automatically removes null and empty characters.
	 */
	public function stringFromBytesRange(_data:Array<Int>, _start:Int, _end:Int):String {
		var str:String = "";
		for (a in _start..._end) {
			if (_data[a] != 0 && Math.isNaN(_data[a]) == false) str += String.fromCharCode(_data[a]);
		}
		return str;
	}
}