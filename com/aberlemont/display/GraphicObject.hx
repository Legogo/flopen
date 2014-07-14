package com.aberlemont.display;

import flash.display.BitmapData;
import flash.display.Sprite;
import flash.display.Bitmap;
import flash.geom.Point;
import openfl.geom.Rectangle;

/**
 * ...
 * @author A.Berlemont
 */
class GraphicObject extends Sprite
{
  var sheet:Bitmap;
  var frame:Bitmap;
  
  public function new(path:String) 
  {
    super();
    sheet = GraphicTools.getAsset(path);
    frame = new Bitmap(new BitmapData(1, 1, true, 0));
    setFrameBySize(0, Math.floor(sheet.width), Math.floor(sheet.height));
    
    addChild(frame);
  }
  
  public function setFrameBySize(idx:Int, width:Int, height:Int):Void {
    //trace(width, height);
    frame.bitmapData = new BitmapData(width, height, true, 0);
    
    frame.bitmapData.copyPixels(
      sheet.bitmapData,
      new Rectangle(idx * width, 0, width, height),
      new Point(),
      sheet.bitmapData,
      new Point(),
      true);
  }
  
  public function setFrame(idx:Int):Void {
    setFrameBySize(idx, Math.floor(frame.width), Math.floor(frame.height));
  }
  
}