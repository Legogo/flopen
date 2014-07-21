package com.aberlemont.gui;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.geom.Point;
import openfl.geom.Rectangle;

/**
 * ...
 * @author A.Berlemont
 */
class LoadingBar extends Sprite
{
  var empty:Bitmap;
  var full:Bitmap;
  
  var canvas:Bitmap;
  var progress:Float = 0;
  
  var pt:Point = new Point();
  var rect:Rectangle = new Rectangle();
  
  public function new(size:Point = null) 
  {
    super();
    if (size == null)  size = new Point(100, 20);
    
    var w:Int = Math.floor(size.x);
    var h:Int = Math.floor(size.y);
    
    empty = new Bitmap(new BitmapData(w, h, true, 0x00000000));
    full = new Bitmap(new BitmapData(w, h, true, 0xFFDD1188));
    canvas = new Bitmap(new BitmapData(w, h, true, 0x00000000));
    
    addChild(empty);
    addChild(canvas);
  }
  
  public function resize(w:Int,h:Int):Void {
    empty.bitmapData = new BitmapData(w, h, true, 0xFF000000);
    full.bitmapData = new BitmapData(w, h, true, 0xFFDD1111);
    setProgress(progress);
  }
  
  public function setProgress(newProgress:Float):Void {
    progress = newProgress;
    
    rect.width = full.width * progress;
    rect.height = full.height;
    
    canvas.bitmapData.floodFill(0, 0, 0xFFFFFFFF);
    canvas.bitmapData.copyPixels(full.bitmapData,rect, pt, full.bitmapData, pt);
  }
  
}