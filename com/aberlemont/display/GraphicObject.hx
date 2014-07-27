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
  var anim:GraphicAnim;
	
	var sheet:Bitmap;
  var canvas:Bitmap;
  
	var moveSpeed:Int = 100;
	
	var frameTimeSpeed:Float = 0.15;
	var frameTime:Float = 0;
	
  var pt:Point = new Point();
	var rect:Rectangle = new Rectangle(0, 0, 84, 84);
	
	#if debug
	var debug:Sprite = new Sprite();
	#end
	
	public function new(path:String) 
  {
    super();
		if (path.length > 0) {
			sheet = GraphicTools.getAsset(path);
			if (sheet == null) {
				trace("GraphicObject :: no sheet found for path : " + path);
				return;
			}
			
			setSize(Math.floor(sheet.width), Math.floor(sheet.height)).setFrame(0, 0);
		}else {
			setSize();
		}
    
    addChild(canvas);
  }
	
	public function addAdnim():Void {
		anim = new GraphicAnim(this);
	}
	
	public function update():Void {
		if (anim != null)	anim.update();
	}
  
  public function setSize(width:Int = 1, height:Int = 1):GraphicObject {
    rect.width = width;
    rect.height = height;
    if (canvas == null) {
      canvas = new Bitmap(new BitmapData(width, height, true, 0));
    }else {
      canvas.bitmapData = new BitmapData(width, height, true, 0);
    }
    
    if(sheet != null)	draw();
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
	
	public function getSheet():BitmapData {
		return sheet.bitmapData;
	}
	public function getSymbol():BitmapData {
		return canvas.bitmapData.clone();
	}
	
	public function getWidth():Int {
		return Math.floor(canvas.width);
	}
	public function getHeight():Int {
		return Math.floor(canvas.height);
	}
	
	public function setPosition(x:Float, y:Float):Void { this.x = x; this.y = y; }
}
