package com.aberlemont.display;

import flash.Lib;
import flash.display.Bitmap;
import openfl.Assets;

/**
 * ...
 * @author A.Berlemont
 */
class GraphicTools
{

  static public function getAsset(path:String):Bitmap
  {
    return new Bitmap(Assets.getBitmapData("assets/"+path+".png"));
  }
  static public function getStageWidth():Int { return Lib.current.stage.stageWidth; }
  static public function getStageHeight():Int { return Lib.current.stage.stageHeight; }
  
  static public function display_stageInfo():Void {
    trace("stage " + getStageWidth() + ", " + getStageHeight());
  }
}