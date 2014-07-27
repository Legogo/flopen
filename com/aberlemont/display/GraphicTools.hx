package com.aberlemont.display;

import flash.display.BitmapData;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import openfl.Lib;
import openfl.display.Bitmap;
import openfl.Assets;

/**
 * ...
 * @author A.Berlemont
 */
class GraphicTools
{

  static public function getStageWidth():Int { return Lib.current.stage.stageWidth; }
  static public function getStageHeight():Int { return Lib.current.stage.stageHeight; }
  
	static public function getAsset(path:String):Bitmap {
		return new Bitmap(Assets.getBitmapData("assets/"+path));
	}
	
  static public function getAssetPng(path:String):Bitmap
  {
    return new Bitmap(Assets.getBitmapData("assets/"+path+".png"));
  }
  static public function getAssetPngData(path:String):BitmapData {
		return Assets.getBitmapData("assets/"+path+".png");
	}
	
  static public function display_stageInfo():Void {
    trace("stage " + getStageWidth() + ", " + getStageHeight());
  }
	
	static public function getImageFromSheet(sheet:BitmapData, size:Rectangle, pos:Point):BitmapData {
		var bmp:BitmapData = new BitmapData(Math.floor(size.width), Math.floor(size.height), true, 0);
		bmp.copyPixels(sheet, size, pos, sheet, new Point());
		return bmp;
	}
	
	/* return rectangles of given color in a bitmap (original bitmapdata is override with debug color) */
	static public function solveShapesBbox(shape:BitmapData, seekColor:Int):Array<Rectangle> {
		var rect:Rectangle = null;
		var rs:Array<Rectangle> = new Array<Rectangle>();
		
		for (i in 0...shape.width) {
			for (j in 0...shape.height) {
				
				var c:Color = new Color(shape.getPixel32(i, j));
				//trace(i + "," + j + " " + seekColor +" || " + c + ", " + c.num);
				
				if (shape.getPixel32(i, j) == seekColor) {
					var progressx:Int = i;
					var progressy:Int = j;
					
					while (shape.getPixel32(progressx, j) == seekColor)	progressx++;
					while (shape.getPixel32(i, progressy) == seekColor)	progressy++;
					
					rect = new Rectangle(i, j, progressx - i, progressy - j);
					
					var doublon:Bool = false;
					for (k in 0...rs.length) {
						if (rs[k].containsRect(rect)) doublon = true;
					}
					if (!doublon) {
						rs.push(rect);
						shape.fillRect(rect, 0xFFFF00FF); // remove
					}
					
				}
				
			}
		}
		
		return rs;
	}
}