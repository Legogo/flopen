package com.aberlemont.gui;
import flash.display.Sprite;
import flash.events.MouseEvent;
import haxe.Constraints.Function;
import openfl.utils.Object;

/**
 * ...
 * @author A.Berlemont
 */
class InteractiveZone extends Sprite
{
  
  public var clickCallback:Object->Void;
  
  public function new(w:Int, h:Int) 
  {
    super();
    
    graphics.clear();
    var alpha:Float = 0;
    
    #if debug
    //alpha = 0.5;
    #end
    
    graphics.beginFill(0xFF00FF, alpha);
    graphics.drawRect(0, 0, w, h);
    graphics.endFill();
    
    addEventListener(MouseEvent.MOUSE_DOWN, mDown);
  }
  
  private function mDown(e:MouseEvent):Void {
    if (clickCallback != null) clickCallback({zone:this, mouseX:e.stageX, mouseY:e.stageY});
  }
  
}