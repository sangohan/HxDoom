package hxdoom.core;

import hxdoom.common.Environment;
import hxdoom.common.CheatHandler;

/**
 * ...
 * @author Kaelan
 */

class IOCore
{
	public static var IGNORE_SHIFT:Bool = true;
	public static var SHIFT_IS_DOWN:Bool = false;
	
	//This structure should allow for multiple binds to be attached to an action
	public var keyPressAction:Map<Int, Array<Void -> Void>>;
	public var keyReleaseAction:Map<Int, Array<Void -> Void>>;
	
	public function new() 
	{
		keyPressAction = new Map();
		keyReleaseAction = new Map();
	}
	
	public function keyPress(_keyCode:Int) {
		
		switch(_keyCode) {
			case HXDKeyCode.TAB : 
				Environment.IS_IN_AUTOMAP = !Environment.IS_IN_AUTOMAP;
			case HXDKeyCode.W_UPPER | HXDKeyCode.W_LOWER:
				Environment.PLAYER_MOVING_FORWARD = true;
		}
		
	}
	public function keyRelease(_keyCode:Int) {
		switch(_keyCode) {
			case HXDKeyCode.W_UPPER | HXDKeyCode.W_LOWER:
				Environment.PLAYER_MOVING_FORWARD = false;
		}
	}
	
	function keyCharToInt(keyChar:String):Int
	{
		return 0;
	}
}

enum abstract HXDKeyCode(Int) from Int {
	var NULL:Int = 0x0;
	var BACKSPACE:Int = 0x08;
	var TAB:Int = 0x09;
	var ESCAPE:Int = 0x1B;
	var SPACE:Int = 0x20;
	//Going to rely on implicit casting from here on
	var EXCLAMATION:Int;
	var QUOTE:Int;
	var OCTOTHORPE:Int;
	var DOLLAR:Int;
	var PERCENT:Int;
	var AMPERSAND:Int;
	var APOSTROPHE:Int;
	var OPEN_PARENTHESIS:Int;
	var CLOSE_PARENTHESIS:Int;
	var ASTERISK:Int;
	var PLUS:Int;
	var ACUTE_DIACRITIC:Int;
	var HYPHEN:Int;
	var MINUS:Int;
	var PERIOD:Int;
	var FOWARD_SLASH:Int;
	var ZERO:Int;
	var ONE:Int;
	var TWO:Int;
	var THREE:Int;
	var FOUR:Int;
	var FIVE:Int;
	var SIX:Int;
	var SEVEN:Int;
	var EIGHT:Int;
	var NINE:Int;
	var COLON:Int;
	var SEMICOLON:Int;
	var LESSTHAN:Int;
	var EQUALS:Int;
	var GREATERTHAN:Int;
	var QUESTION:Int;
	var AT:Int;
	var A_UPPER:Int;
	var B_UPPER:Int;
	var C_UPPER:Int;
	var D_UPPER:Int;
	var E_UPPER:Int;
	var F_UPPER:Int;
	var G_UPPER:Int;
	var H_UPPER:Int;
	var I_UPPER:Int;
	var J_UPPER:Int;
	var K_UPPER:Int;
	var L_UPPER:Int;
	var M_UPPER:Int;
	var N_UPPER:Int;
	var O_UPPER:Int;
	var P_UPPER:Int;
	var Q_UPPER:Int;
	var R_UPPER:Int;
	var S_UPPER:Int;
	var T_UPPER:Int;
	var U_UPPER:Int;
	var V_UPPER:Int;
	var W_UPPER:Int;
	var X_UPPER:Int;
	var Y_UPPER:Int;
	var Z_UPPER:Int;
	var OPEN_BRACKET:Int;
	var BACK_SLASH:Int;
	var CLOSE_BRACKET:Int;
	var CARET:Int;
	var UNDERSCORE:Int;
	var GRAVE_DIACRITIC:Int;
	var A_LOWER:Int;
	var B_LOWER:Int;
	var C_LOWER:Int;
	var D_LOWER:Int;
	var E_LOWER:Int;
	var F_LOWER:Int;
	var G_LOWER:Int;
	var H_LOWER:Int;
	var I_LOWER:Int;
	var J_LOWER:Int;
	var K_LOWER:Int;
	var L_LOWER:Int;
	var M_LOWER:Int;
	var N_LOWER:Int;
	var O_LOWER:Int;
	var P_LOWER:Int;
	var Q_LOWER:Int;
	var R_LOWER:Int;
	var S_LOWER:Int;
	var T_LOWER:Int;
	var U_LOWER:Int;
	var V_LOWER:Int;
	var W_LOWER:Int;
	var X_LOWER:Int;
	var Y_LOWER:Int;
	var Z_LOWER:Int;
	var OPEN_BRACE:Int;
	var PIPE:Int;
	var CLOSE_BRACE:Int;
	var TILDE:Int;
	var DEL:Int;
}