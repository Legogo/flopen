package com.aberlemont.input;

import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.events.TouchEvent;
import openfl.ui.Multitouch;
import openfl.ui.MultitouchInputMode;
import openfl.Lib;

/**
 * ...
 * @author A.Berlemont
 */
class InputTouch
{	
	public var state:String = TouchEvent.TOUCH_END;
	public var localx:Int = 0;
	public var localy:Int = 0;
	public var x:Int = 0;
	public var y:Int = 0;
	
	public function update(state:String, x:Int, y:Int, lx:Int, ly:Int):InputTouch {
		this.state = state;
		localx = lx;
		localy = ly;
		this.x = x;
		this.y = y;
		return this;
	}
	public function toString():String {
		return state+" | " + x + "," + y;
	}
}