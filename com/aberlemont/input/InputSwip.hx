package com.aberlemont.input;

import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.TouchEvent;
import openfl.events.MouseEvent;
import openfl.geom.Point;

/**
 * ...
 * @author A.Berlemont
 */
class InputSwip extends Sprite
{
  static public var input:InputSwip;

  public var touchX:Int = 0;
  public var touchY:Int = 0;
  public var touchXEnd:Int = 0;
  public var touchYEnd:Int = 0;

  public function new() 
  {
    super();
    input = this;
    addEventListener(Event.ADDED_TO_STAGE, added);
  }
  
  private function added(e:Event):Void {
    removeEventListener(Event.ADDED_TO_STAGE, added);
    
    /*
    stage.addEventListener( TouchEvent.TOUCH_BEGIN, touch_begin );
    stage.addEventListener( TouchEvent.TOUCH_MOVE, touch_move );
    stage.addEventListener( TouchEvent.TOUCH_END, touch_end );
    */
    stage.addEventListener( MouseEvent.MOUSE_DOWN, mouse_down );
    stage.addEventListener( MouseEvent.MOUSE_MOVE, mouse_move );
    stage.addEventListener( MouseEvent.MOUSE_UP, mouse_up );
  }
  
  private function touch_begin(e:TouchEvent):Void { onTouchBegin(Math.floor(e.stageX), Math.floor(e.stageY)); }
  private function touch_move(e:TouchEvent):Void { }
  private function touch_end(e:TouchEvent):Void { onTouchEnd(Math.floor(e.stageX), Math.floor(e.stageY)); }
  
  private function mouse_down(e:MouseEvent):Void { onTouchBegin(Math.floor(e.stageX), Math.floor(e.stageY)); }
  private function mouse_move(e:MouseEvent):Void { }
  private function mouse_up(e:MouseEvent):Void { onTouchEnd(Math.floor(e.stageX), Math.floor(e.stageY)); }
  
  
  private function onTouchBegin(stageX:Int, stageY:Int):Void {
    touchX = stageX;
    touchY = stageY;
  }
  private function onTouchEnd(stageX:Int, stageY:Int):Void {
    
    touchXEnd = stageX;
    touchYEnd = stageY;
    
    var gap:Int = 30;

    var dist:Float = Math.abs(touchX - touchXEnd);
    //swip not big enought
    if (dist < gap) {
      trace("swip's too short (X)");
      return;
    }
    
    var dir:Int = (touchXEnd > touchX) ? 1 : -1;
    event_slide(dir);
  }
  private function event_slide(dir:Int):Void {
  }
}