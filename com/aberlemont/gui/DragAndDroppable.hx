package com.aberlemont.gui;
import com.aberlemont.graphics.GraphicObject;
import com.aberlemont.system.Console;
import flash.display.Sprite;
import haxe.Constraints.Function;
import openfl.geom.Point;

import flash.events.Event;
import flash.events.MouseEvent;
import flash.Lib;

/**
 * ...
 * @author A.Berlemont
 */
class DragAndDroppable extends Sprite
{
  
  private var drop:Bool = false;
  private var offset:Point = new Point();
  
  public function new() 
  {
    super();
    addEventListener(MouseEvent.MOUSE_DOWN, mDown);
  }
  
  private function mDown(e:MouseEvent):Void {
    callClick(Math.floor(e.stageX), Math.floor(e.stageY));
  }
  
  public function callClick(clickX:Int, clickY:Int):Void {
    drop = false;
    
    var global:Point = parent.localToGlobal(new Point(x, y));
    
    offset.x = clickX - global.x;
    offset.y = clickY - global.y;
    
    stage.addEventListener(Event.ENTER_FRAME, mDrag);
    addEventListener(MouseEvent.MOUSE_UP, mUp);
  }
  
  private function mUp(e:MouseEvent):Void {
    stage.removeEventListener(Event.ENTER_FRAME, mDrag);
    removeEventListener(MouseEvent.MOUSE_UP, mUp);
    
    drop = true;
    onDrop();
  }
  
  private function onDrop():Void {
  }
  
  public function isDropped():Bool { return drop; }
  
  private function mDrag(e:Event):Void {
    //trace(Lib.current.stageX);
    //trace(stage.mouseX);
    //Console.log("Drag&drop", stage.mouseX + "," + stage.mouseY);
    
    x = stage.mouseX + offset.x;
    y = stage.mouseY + offset.y;
  }
  
}