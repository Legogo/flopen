package com.aberlemont.input;
import com.aberlemont.system.Console;
import haxe.Constraints.Function;
import openfl.display.Sprite;
import openfl.events.EventPhase;
import openfl.events.MouseEvent;
import openfl.events.TouchEvent;
import openfl.ui.Multitouch;
import openfl.ui.MultitouchInputMode;
import openfl.Lib;

/**
 * ...
 * @author A.Berlemont
 */
class InputTouchManager
{
	static public var manager:InputTouchManager;
	var touches:Array<InputTouch> = new Array<InputTouch>();
	
	public var tBegin_cb:InputTouch->Void;
	public var tEnd_cb:InputTouch->Void;
	
  public function new() 
  {
    InputTouchManager.manager = this;
		
		var multiTouchSupported:Bool = Multitouch.supportsTouchEvents;
    if (multiTouchSupported){
      Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
      Lib.current.addEventListener(TouchEvent.TOUCH_BEGIN, tBegin);
      Lib.current.addEventListener(TouchEvent.TOUCH_END, tEnd);
    }else {
			Console.log("InputManager", "multitouch not supported, using mouse event instead");
      Lib.current.addEventListener(MouseEvent.MOUSE_DOWN, mDown);
      Lib.current.addEventListener(MouseEvent.MOUSE_UP, mUp);
    }
		
  }
  
	public function mDown(e:MouseEvent):Void {
		touch_begin(0, TouchEvent.TOUCH_BEGIN, e.stageX, e.stageY, e.localX, e.localY);
	}
	public function mUp(e:MouseEvent):Void {
		touch_end(0, TouchEvent.TOUCH_END, e.stageX, e.stageY, e.localX, e.localY);
	}
	
	public function tBegin(e:TouchEvent):Void {
		touch_begin(e.touchPointID, TouchEvent.TOUCH_BEGIN, e.stageX, e.stageY, e.localX, e.localY);
	}
	public function tEnd(e:TouchEvent):Void {
		touch_end(e.touchPointID, TouchEvent.TOUCH_END, e.stageX, e.stageY, e.localX, e.localY);
	}
	
	function checkTouchArray(size:Int):Void {
		while (touches.length <= size){ touches.push(new InputTouch()); }
	}
	
	private function touch_end(id:Int, state:String, x:Float, y:Float, lx:Float, ly:Float):Void {
		checkTouchArray(id);
		touches[id].update(state, Math.floor(x), Math.floor(y), Math.floor(lx), Math.floor(ly));
		if(tEnd_cb != null)	tEnd_cb(touches[id]);
	}
	
  private function touch_begin(id:Int, state:String, x:Float, y:Float, lx:Float, ly:Float):Void {
		checkTouchArray(id);
		//Console.log("InputTouchManager", "touch begin. ID : " + e.touchPointID);
		touches[id].update(state, Math.floor(x), Math.floor(y), Math.floor(lx), Math.floor(ly));
		if(tBegin_cb != null)	tBegin_cb(touches[id]);
  }
  
}