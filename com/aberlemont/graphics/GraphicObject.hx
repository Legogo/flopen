package com.aberlemont.graphics;

import flash.display.Sprite;
import flash.display.Bitmap;

/**
 * ...
 * @author A.Berlemont
 */
class GraphicObject extends Sprite
{
  var sheet:Bitmap;
  
  public function new(path:String) 
  {
    super();
    sheet = GraphicTools.getAsset(path);
    addChild(sheet);
  }
  
}