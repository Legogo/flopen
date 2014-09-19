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
 * 
 * tBeing, tEnd and tMove are arrays of callbacks !
 * To use that manager you just add your function(InputTouch):Void to these arrays
 */
class InputTouchManager
{
	var touches:Array<InputTouch> = new Array<InputTouch>();
	var multiTouchSupported:Bool = false;
	
	public var tBegin_cb:Array < InputTouch->Void > = new Array < InputTouch->Void >();
	public var tEnd_cb:Array < InputTouch->Void > = new Array < InputTouch->Void > ();
	public var tMove_cb:Array < InputTouch->Void > = new Array < InputTouch->Void > ();
	
  public function new() 
  {
    InputTouchManager.manager = this;
		
		multiTouchSupported = Multitouch.supportsTouchEvents;
    if (multiTouchSupported){
      Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
      Lib.current.addEventListener(TouchEvent.TOUCH_BEGIN, tBegin);
			Lib.current.addEventListener(TouchEvent.TOUCH_MOVE, tMove);
      Lib.current.addEventListener(TouchEvent.TOUCH_END, tEnd);
    }else {
			Console.log("InputManager", "multitouch not supported, using mouse event instead");
      Lib.current.addEventListener(MouseEvent.MOUSE_DOWN, mDown);
			Lib.current.addEventListener(MouseEvent.MOUSE_MOVE, mMove);
      Lib.current.addEventListener(MouseEvent.MOUSE_UP, mUp);
    }
		
  }
  
	function mDown(e:MouseEvent):Void { touch_begin(0, TouchEvent.TOUCH_BEGIN, e.stageX, e.stageY); }
	function mMove(e:TouchEvent):Void { touch_move(0, e.stageX, e.stageY); }
	function mUp(e:MouseEvent):Void { touch_end(0, TouchEvent.TOUCH_END, e.stageX, e.stageY); }
	
	function tBegin(e:TouchEvent):Void { touch_begin(e.touchPointID, TouchEvent.TOUCH_BEGIN, e.stageX, e.stageY); }
	function tMove(e:TouchEvent):Void { touch_move(e.touchPointID, e.stageX, e.stageY); }
	function tEnd(e:TouchEvent):Void { touch_end(e.touchPointID, TouchEvent.TOUCH_END, e.stageX, e.stageY); }
	
	function checkTouchArray(size:Int):Void {
		while (touches.length <= size){ touches.push(new InputTouch(touches.length)); }
	}
	
	function touch_move(id:Int, x:Float, y:Float):Void {
		checkTouchArray(id);
		if (touches[id].move(Math.floor(x), Math.floor(y))) {
			if(tMove_cb != null)	for(i in 0...tMove_cb.length) tMove_cb[i](touches[id]);
		}
		
	}
	
	function touch_end(id:Int, state:String, x:Float, y:Float):Void {
		checkTouchArray(id);
		touches[id].update(state, Math.floor(x), Math.floor(y));
		if(tEnd_cb != null)	for(i in 0...tEnd_cb.length) tEnd_cb[i](touches[id]);
	}
	
  function touch_begin(id:Int, state:String, x:Float, y:Float):Void {
		checkTouchArray(id);
		//Console.log("InputTouchManager", "touch begin. ID : " + e.touchPointID);
		touches[id].update(state, Math.floor(x), Math.floor(y));
		if(tBegin_cb != null)	for(i in 0...tBegin_cb.length) tBegin_cb[i](touches[id]);
  }
  
  static private var manager:InputTouchManager;
  static public function get():InputTouchManager {
    if (manager == null) new InputTouchManager();
    return manager;
  }
}