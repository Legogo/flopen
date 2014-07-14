package com.aberlemont.graphics;

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
}