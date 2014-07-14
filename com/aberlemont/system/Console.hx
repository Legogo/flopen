package com.aberlemont.system;
import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
import flash.events.KeyboardEvent;
import flash.ui.Keyboard;
import openfl.geom.Point;
import openfl.text.TextField;
import openfl.display.FPS;

/**
 * ...
 * @author A.Berlemont
 */
class Console extends Sprite
{
  static public var console;
  private var tf_system:TextField;
  private var tf_console:TextField;
  
  private var fps:FPS;
  
  public function new() 
  {
    super();
    console = this;
    
    tf_system = new TextField();
    tf_console = new TextField();
    
    setupTextfield(tf_system);
    setupTextfield(tf_console);
    
    Lib.current.addEventListener(KeyboardEvent.KEY_UP, kRelease);
    Lib.current.addChild(this);
    
    fps = new FPS();
    fps.x = Lib.current.stage.stageWidth - 50;
    addChild(fps);
    
    toggle();
  }
  
  private function setupTextfield(tf:TextField):Void {
    tf.width = 300;
    tf.height = 500;
    tf.selectable = false;
    tf.mouseEnabled = false;
    addChild(tf);
  }
  
  private function kRelease(e:KeyboardEvent):Void {
    if (e.keyCode == Keyboard.BACKSPACE) {
      toggle();
    }
  }
  
  private function toggle():Void {
    //update position and size if screen changed size
    tf_console.x = 10;
    tf_console.y = 10;
    tf_console.width = Lib.current.stage.stageWidth * 0.75;
    tf_system.height = tf_console.height = Lib.current.stage.stageHeight * 0.9;
    
    tf_system.x = tf_console.x + tf_console.width + 2;
    tf_system.y = 25;
    tf_system.width = Lib.current.stage.stageHeight * 0.25;
    
    visible = !visible;
  }
  
  static public function setSystemInfo(content:String):Void {
    console.tf_system.text = content;
  }
  
  static public function log(context:String, content:String):Void {
    trace("(" + context + ") " + content);
  }
}