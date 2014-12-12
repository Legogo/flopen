package com.aberlemont.display;

import flash.display.BitmapData;
import flash.display.Sprite;
import flash.display.Bitmap;
import flash.geom.Point;
import flash.geom.Rectangle;
import openfl.text.TextField;

/**
 * ...
 * @author A.Berlemont
 */
class GraphicObject extends Sprite
{
  public var anim:GraphicAnim;
	
	var sheet:BitmapData;
  var canvas:Bitmap;
  
	var moveSpeed:Int = 100;
	
	var frameTimeSpeed:Float = 0.15;
	var frameTime:Float = 0;
	
	var position:Point = new Point();
	
	var bbox:Rectangle = new Rectangle();
	
  var draw_pt:Point = new Point();
	var draw_rect:Rectangle = new Rectangle(0, 0, 84, 84);
	
	#if debug
	public var debug:Sprite = new Sprite(); // you need to add debug where you want it
	public var debugTf:TextField = Tools.getStandardTextfield();
	#end
	
	public function new(path:String) 
  {
    super();
		
		if (path.length > 0) {
			sheet = GraphicTools.getAssetData(path);
			if (sheet == null) {
				trace("GraphicObject :: no sheet found for path : " + path);
				return;
			}
			
			setSize(Math.floor(sheet.width), Math.floor(sheet.height)).setFrame(0, 0);
		}else {
			setSize();
		}
    
    addChild(canvas);
		
		#if debug
		debug.addChild(debugTf);
		#end
  }
	
	public function addAdnim():Void {
		anim = new GraphicAnim(this);
	}
	
	public function update():Void {
		if (anim != null)	anim.update();
	}
  
  public function setSize(width:Int = 1, height:Int = 1):GraphicObject {
    draw_rect.width = width;
    draw_rect.height = height;
    if (canvas == null) {
      canvas = new Bitmap(new BitmapData(width, height, true, 0));
    }else {
      canvas.bitmapData = new BitmapData(width, height, true, 0);
    }
    
    if(sheet != null)	draw();
    return this;
  }
  
	public function pivotInCenter():Void {
		canvas.x = Math.floor(-width * 0.5);
		canvas.y = Math.floor(-height * 0.5);
	}
	
	public function setFrame(row:Int, col:Int):GraphicObject{
		draw_rect.x = col * draw_rect.width;
		draw_rect.y = row * draw_rect.height;
		frameTime = frameTimeSpeed;
		draw();
    return this;
	}
	
	public function getRow():Int { return Math.floor(draw_rect.y / draw_rect.height); }
	public function getCol():Int { return Math.floor(draw_rect.x / draw_rect.width); }
	
	private function draw():Void {
		canvas.bitmapData.copyPixels(sheet, draw_rect, draw_pt, sheet, draw_pt);
	}
	
	public function getSheet():BitmapData { return sheet; }
	public function getSymbol():BitmapData { return canvas.bitmapData.clone(); }
	public function getTopLeft():Point { return new Point(x - (getWidth() * 0.5), y - (getHeight() * 0.5)); }
	public function getBbox():Rectangle { return bbox; }
	public function getWidth():Int { return Math.floor(canvas.width); }
	public function getHeight():Int { return Math.floor(canvas.height); }
	public function toStringDebug():String { return name; }
	
	public function getPosition():Point { position.x = x; position.y = y; return position; }
	public function setPosition(x:Float, y:Float):Void { this.x = x; this.y = y; }
}
