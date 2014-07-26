package com.aberlemont.display;

import com.aberlemont.Tools;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.filters.ColorMatrixFilter;
import openfl.geom.ColorTransform;
import openfl.geom.Point;
import openfl.geom.Rectangle;

/**
 * @author André Berlemont
 * http://www.andreberlemont.com
 */

class Color
{
	public var num:UInt = 0; // 0xAARRGGBB
	
	public function new(value:UInt = 0, alpha:UInt = 255) 
	{
		this.num = value;
		if(alpha < 255)	setAlpha(alpha);
	}

	public function getColor():UInt {
		return num;
	}
	
	public function setAlpha(v:Int):Void {
		num = rgbaToUint(getComponentValue(num, "r"), getComponentValue(num, "g"), getComponentValue(num, "b"), v);
	}

	public function toString():String {
		var str:String = "ColorManager >> ";

		// http://www.adobe.com/devnet/flash/articles/bitwise_operators_print.html

		str += " A:" + ((num & 0xFF000000) >>> 24);
		str += " R:" + ((num & 0x00FF0000) >>> 16);
		str += " G:" + ((num & 0x0000FF00) >>> 8);
		str += " B:" + (num & 0x000000FF);

		return str;
	}

	// ###### STATIC

	static public function setSpriteColor(sprite:Sprite, color:UInt):Void {
		var r:Int = color >> 16 & 0xFF;
		var g:Int = color >> 8 & 0xFF;
		var b:Int = color & 0xFF;
		sprite.transform.colorTransform = new ColorTransform(0, 0, 0, 255, r, g, b, 255);
	}

	static public function changeAlpha(target:BitmapData, alpha:UInt = 255):Void {
					var ct:ColorTransform = new ColorTransform();
					ct.alphaMultiplier = alpha;
					target.colorTransform(new Rectangle(0, 0, target.width, target.height), ct);
			}

	static public function setColor(target:BitmapData, color:UInt, alpha:UInt = 255):Void {
					var ct:ColorTransform = new ColorTransform();
					ct.color = color;
					ct.alphaMultiplier = alpha;
					target.colorTransform(new Rectangle(0, 0, target.width, target.height), ct);
			}


	static public function drawCross(length:Float = 10, tickness:Float = 1, color:UInt = 0xFF0000):Sprite {
		var s:Sprite = new Sprite();
		s.graphics.lineStyle(3, color);
		s.graphics.moveTo( -length, 0);
		s.graphics.lineTo(length, 0);
		s.graphics.moveTo(0, -length);
		s.graphics.lineTo(0, length);

		return s;
	}

	static public function rgbaToUint(r:Int = 0, g:Int = 0, b:Int = 0, a:Int = 255):UInt
	{
		return (0 & 0xFFFFFFFF) + (a << 24) + (r << 16) + (g << 8 ) + b;
		//return (a + 0xFF) + (r & 0x00FF0000) + (g & 0x0000FF00) + (b & 0x000000FF);
	}

	//public static function uintToRgba(color:uint,component:String)

	static public function getPixelComponent(map:BitmapData, x:Int, y:Int, component:String):Int
	{
		return  getComponentValue(map.getPixel32(x, y), component);
	}

	static public function getComponentValue(color:UInt, component:String):Int
	{
		switch(component) {
			case "a" : return ((color & 0xFF000000) >>> 24);
			case "r" : return ((color & 0x00FF0000) >>> 16);
			case "g" : return ((color & 0x0000FF00) >>> 8);
			case "b" : return (color & 0x000000FF);
			default : trace("Color >> getPixelCompo error");
		}

		return -1;
	}

	static public function uintToTransform(color:UInt, alpha:Int = 255):ColorTransform {
		var r:Int = color >> 16 & 0xFF;
		var g:Int = color >> 8 & 0xFF;
		var b:Int = color & 0xFF;

		return new ColorTransform(0, 0, 0, 0, r, g, b, alpha);
	}

	static public function getRandomColorComponent(component:String = "r", alpha:Float = 255):UInt {
		var r:Int = 0;
		var g:Int = 0;
		var b:Int = 0;

		switch(component) {
			case "r" : r = Tools.rangeInt(0, 255);
			case "g" : g = Tools.rangeInt(0, 255);
			case "b" : b = Tools.rangeInt(0, 255);
		}

		alpha = Tools.threshold(0, 255, alpha);
		return new ColorTransform(0, 0, 0, 0, r,g,b, alpha).color;
	}

	static public function getRandomColor(alpha:Int = 255):UInt {
		alpha = Tools.thresholdInt(0, 255, alpha);
		return new ColorTransform(0, 0, 0, 0, Tools.rangeInt(0, 255),Tools.rangeInt(0, 255),Tools.rangeInt(0, 255), alpha).color;
	}

	static public function getRandomGrayscale(alpha:Int = 255, min:Int = 0, max:Int = 255):UInt {
		alpha = Tools.thresholdInt(0, 255, alpha); //cap
		var rand:Int = Tools.rangeInt(min, max);
		return new ColorTransform(0, 0, 0, 0, rand, rand, rand, alpha).color;
	}
	
}
