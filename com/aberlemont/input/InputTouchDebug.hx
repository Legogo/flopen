package com.aberlemont.input;
import flash.display.Sprite;
import flash.events.TouchEvent;
import flash.Lib;

/**
 * ...
 * @author A.Berlemont
 */
class InputTouchDebug extends Sprite
{

  public function new() 
  {
    super();
    
    graphics.beginFill(0, 1);
    graphics.drawCircle(0, 0, 10);
    graphics.endFill();
    
    Lib.current.addEventListener(TouchEvent.TOUCH_BEGIN, touch_begin);
  }
  
  private function touch_begin(e:TouchEvent):Void {
    x = e.stageX;
    y = e.stageY;
  }
  
}