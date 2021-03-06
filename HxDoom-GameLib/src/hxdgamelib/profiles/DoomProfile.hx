package hxdgamelib.profiles;

import hxdoom.component.Actor;
import hxdoom.core.ProfileCore;
import hxdoom.definitions.EpisodeDef;
import hxdoom.definitions.MapDef;
import hxdoom.Engine;
import hxdoom.component.LevelMap;
import hxdgamelib.levelstruct.DoomLevel;
import hxdoom.utils.math.TableRNG;
import hxdoom.core.action.Enemy;
import hxdoom.core.action.Maputl;

/**
 * ...
 * @author Kaelan
 */
class DoomProfile extends ProfileCore 
{

	public var episodes:Array<EpisodeDef>;
	public var maps:Array<MapDef>;
	
	public function new(_shareware:Bool = true) 
	{
		super();
		
		LevelMap.CONSTRUCTOR = DoomLevel.new;
		
		//Until I can get my hands on the original table that maintains license, this
		//will have to go unused.
		/*Engine.GAME.random = TableRNG.fromPredeterminedIntArray([
			some code here that lets me use the original container, otherwise
			the default table is all values from 0 - 255. Doom vanilla does not
			posses every value in between, so it's behavior will not be identical.
		])*/
		
		episodes = new Array();
		
		episodes.push(
		{
			index : 0,
			name : "Knee Deep in The Dead",
			firstLevel : 0
		});
		
		maps = new Array();
		
		maps.push({
			internalName : "E1M1",
			levelName : "Hangar",
			levelIndex : 0,
			nextMap : 1,
			nextMapSecret : 1,
			episodeEnd : false,
		});
		maps.push({
			internalName : "E1M2",
			levelName : "Nuclear Plant",
			levelIndex : 1,
			nextMap : 2,
			nextMapSecret : 2,
			episodeEnd : false,
		});
		maps.push({
			internalName : "E1M3",
			levelName : "Toxin Refinery",
			levelIndex : 2,
			nextMap : 3,
			nextMapSecret : 8,
			episodeEnd : false,
		});
		maps.push({
			internalName : "E1M4",
			levelName : "Command Control",
			levelIndex : 3,
			nextMap : 4,
			nextMapSecret : 4,
			episodeEnd : false,
		});
		maps.push({
			internalName : "E1M5",
			levelName : "Phobos Lab",
			levelIndex : 4,
			nextMap : 5,
			nextMapSecret : 5,
			episodeEnd : false,
		});
		maps.push({
			internalName : "E1M6",
			levelName : "Central Processing",
			levelIndex : 5,
			nextMap : 6,
			nextMapSecret : 6,
			episodeEnd : false,
		});
		maps.push({
			internalName : "E1M7",
			levelName : "Computer Station",
			levelIndex : 6,
			nextMap : 7,
			nextMapSecret : 7,
			episodeEnd : false,
		});
		maps.push({
			internalName : "E1M8",
			levelName : "Phobos Anomaly",
			levelIndex : 7,
			nextMap : 7,
			nextMapSecret : 7,
			episodeEnd : true,
		});
		maps.push({
			internalName : "E1M9",
			levelName : "Military Base",
			levelIndex : 8,
			nextMap : 3,
			nextMapSecret : 3,
			episodeEnd : false,
		});
		
		if (!_shareware) {
			
			episodes.push(
			{
				index : 1,
				name : "The Shores of Hell",
				firstLevel : 9
			});
			episodes.push(
			{
				index : 2,
				name : "Inferno",
				firstLevel : 19
			});
			
			trace("to do: E2M1 through E4M9");
			
			if (Engine.WADDATA.wadContains(["E4M1", "E4M2", "E4M3", "E4M4", "E4M5", "E4M6", "E4M7", "E4M8", "E4M9"])) {
				episodes.push(
				{
					index : 3,
					name : "Thy Flesh Consumed",
					firstLevel : 29
				});
			}
		}
		
		Enemy.checkMissileRange = function(_actor:Actor):Bool
		{
			if (!_actor.flags.seetarget) {
				return false;
			}
			
			if (_actor.flags.justhit) {
				_actor.flags.justhit = false;
				return  true;
			}
			
			if (_actor.info.reactionTime > 0) return  false;
			
			var target = _actor.target;
			var dist = (Maputl.getApproxDistance(target.xpos - _actor.xpos, target.ypos - _actor.ypos)) - 64;
			
			if (_actor.info.meleeState == null) dist -= 128;
			
			//if Actor isn't a lost skull
			Engine.log(["Unfinished here"]);
			
			if (dist > 200) dist = 200;
			
			if (Engine.GAME.random.getRandom() < dist) return false;
			
			return true;
		}
		
	}
	
}