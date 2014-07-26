package com.aberlemont.display;

import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.display.Bitmap;
import openfl.geom.Point;
import openfl.geom.Rectangle;

/**
 * ...
 * @author A.Berlemont
 */
class GraphicObject extends Sprite
{
  var sheet:Bitmap;
  var canvas:Bitmap;
  
	var moveSpeed:Int = 100;
	
	var frameTimeSpeed:Float = 0.15;
	var frameTime:Float = 0;
	
  var pt:Point = new Point();
	var rect:Rectangle = new Rectangle(0, 0, 84, 84);
  
  public function new(path:String) 
  {
    super();
    sheet = GraphicTools.getAsset(path);
    if (sheet == null) {
      trace("GraphicObject :: no sheet found for path : " + path);
      return;
    }
    
		setSize(Math.floor(sheet.width), Math.floor(sheet.height)).setFrame(0, 0);
    addChild(canvas);
  }
  
  public function setSize(width:Int, height:Int):GraphicObject {
    rect.width = width;
    rect.height = height;
    if (canvas == null) {
      canvas = new Bitmap(new BitmapData(width, height, true, 0));
    }else {
      canvas.bitmapData = new BitmapData(width, height, true, 0);
    }
    
    draw();
    return this;
  }
  
	public function setFrame(row:Int, col:Int):Void {
		rect.x = col * rect.width;
		rect.y = row * rect.height;
		frameTime = frameTimeSpeed;
		draw();
	}
	
	private function draw():Void {
		canvas.bitmapData.copyPixels(sheet.bitmapData, rect, pt, sheet.bitmapData, pt);
	}
	
}
