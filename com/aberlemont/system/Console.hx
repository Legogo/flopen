package com.aberlemont.system;

import com.aberlemont.display.GraphicTools;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.Lib;
import openfl.events.KeyboardEvent;
import openfl.ui.Keyboard;
import openfl.geom.Point;
import openfl.text.TextField;
import openfl.display.FPS;

/**
 * ...
 * @author A.Berlemont
 */
class Console extends Sprite
{
  static public var console:Console;
  private var tf_system:TextField;
  private var tf_console:TextField;
  
  private var lines:Array<String> = new Array<String>();
  private var fps:FPS;
  
	public var cb_onOpen:Array<Void->Void> = new Array<Void->Void>();

  public function new() 
  {
    super();
    console = this;
		
    tf_system = new TextField();
    tf_console = new TextField();
    
    setupTextfield(tf_system);
    setupTextfield(tf_console);
    
    fps = new FPS();
    addChild(fps);
    
    addEventListener(Event.ADDED_TO_STAGE, added);
  }
  
  private function added(e:Event):Void {
    removeEventListener(Event.ADDED_TO_STAGE, added);
		
		#if debug
    stage.addEventListener(KeyboardEvent.KEY_UP, kRelease);
		#end
		
    toggle(); // hide at start
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
    visible = !visible;
    if (!visible) return;
    
		for (i in 0...cb_onOpen.length) {
			cb_onOpen[i]();
		}
		
		//on top
		if(stage != null) Lib.current.addChild(this);
		
    var w:Int = Math.floor(Lib.current.stage.stageWidth);
    var h:Int = Math.floor(Lib.current.stage.stageHeight);
    w -= 30;
    h -= 20;
    
    //update position and size if screen changed size
    tf_console.x = 10;
    tf_console.width = w * 0.7;
    tf_system.width = w * 0.3;
    tf_system.x = tf_console.x + tf_console.width + 10;
    tf_system.height = tf_console.height = h;
    tf_system.y = tf_console.y = 10;
    
    //trace(w + "," + h+"  "+tf_console.width+","+tf_console.height);
    //trace(width + "," + height);
    if (fps != null) {
      fps.x = Lib.current.stage.stageWidth - 60;
      fps.y = Lib.current.stage.stageHeight - 30;
    }
    
    graphics.clear();
    graphics.beginFill(0xFFFFFF, 0.8);
    //graphics.drawRect(0,0, width, height);
    graphics.drawRect(tf_console.x, tf_console.y, tf_console.width, tf_console.height);
    graphics.drawRect(tf_system.x, tf_system.y, tf_system.width, tf_system.height); 
    graphics.endFill();
    
		updateText();
		//addEventListener(Event.ENTER_FRAME, updateText);
  }
  
  private function updateText():Void {
    var start:Int = lines.length - 35;
    if (start < 0) start = 0;
    var end:Int = lines.length;
    
    var content:String = "";
    for (i in start...end) {
      content += lines[i];
    }
    tf_console.text = content;
  }
  
  private function addLine(context:String, content:String):Void {
    lines.push("\n(" + context + ") " + content);
    updateText();
  }
  
  static public function get():Console {
    if (console == null) {
      console = new Console();
      Lib.current.addChild(console);
    }
    return console;
  }
  
  static public function setSystemInfo(content:String):Void {
    if (console == null) get();
    console.tf_system.text = content;
  }
  
  static public function log(context:String, content:String):Void {
    if (console == null) get();
    trace("(" + context + ") " + content);
    console.addLine(context, content);
  }
}