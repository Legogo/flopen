package com.aberlemont.input;

import flash.utils.CompressionAlgorithm;
import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.events.TouchEvent;
import openfl.geom.Point;
import openfl.ui.Multitouch;
import openfl.ui.MultitouchInputMode;
import openfl.Lib;

/**
 * ...
 * @author A.Berlemont
 */
class InputTouch
{
	public var id:Int = -1;
	public var state:String = TouchEvent.TOUCH_END;
	public var x:Int = 0;
	public var y:Int = 0;
	public var moveGap:Point = new Point(); // diff btw start and end
	public var moveDelta:Point = new Point(); // diff at each frame
	
	public var moved:Bool = false; // to know if touch went through move phase
	public var movedThreshold:Int = -1; // don't use touch until a significant size of movement
	
	public function new(id:Int) {
		this.id = id;
	}
	
	public function move(movex:Int, movey:Int):Bool {
		if (state == TouchEvent.TOUCH_END)	return false;
		
		state = TouchEvent.TOUCH_MOVE;
		
		moveDelta.x = movex - moveGap.x;
		moveDelta.y = movey - moveGap.y;
		moveGap.x += moveDelta.x;
		moveGap.y += moveDelta.y;
		
		if (movedThreshold > 0)	movedThreshold--;
		moved = true;
		
		return true;
	}
	
	public function hasMovedEnought():Bool { return movedThreshold <= 0; }
	
	public function update(state:String, x:Int, y:Int):InputTouch {
		this.state = state;
		this.x = x;
		this.y = y;
		moveGap.x = x;
		moveGap.y = y;
		
		//reset
		
		if (state == TouchEvent.TOUCH_BEGIN) {
			movedThreshold = 5;
			moved = false;
		}else if (state == TouchEvent.TOUCH_END) {
			moveGap.x = moveGap.y = moveDelta.x = moveDelta.y = 0;
		}
		return this;
	}
	public function toString():String {
		var c:String = "[TOUCH][" + id + "]";
		if (state == TouchEvent.TOUCH_MOVE)	c += "\ndelta:" + moveDelta + " gap:" + moveGap;
		c += "\n" + x + "," + y;
		return c;
	}
}