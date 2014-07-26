package com.aberlemont.system;

import openfl.display.Sprite;
import openfl.events.Event;
import openfl.Lib;
import openfl.display.Stage;

/**
 * ...
 * @author A.Berlemont
 * 
 * http://stackoverflow.com/questions/21869271/extra-long-frame-times-in-openfl-flash
 */
class GameTime
{
  public var timeScale:Float = 1;
  private var last:Float = 0;
  private var delta:Float = 0;
  
  public function new() 
  {
    Lib.current.addEventListener(Event.ENTER_FRAME, update);
  }
  
  private function update(e:Event):Void {
    var current:Float = Lib.getTimer() / 1000.0;
    delta = (current - last);
    last = current;
    
    deltaTime = delta * timeScale;
  }
  
  static public var deltaTime:Float = 0;
  static public function get():GameTime { return new GameTime(); }
}