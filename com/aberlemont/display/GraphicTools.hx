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
}