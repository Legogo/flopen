package com.aberlemont.display;

import com.aberlemont.system.GameTime;
import flash.display.BitmapData;
import flash.geom.Point;
import flash.geom.Rectangle;

/**
 * ...
 * @author 
a.berlemont
https://github.com/legogo
http://www.andreberlemont.com
 */
class GraphicAnim
{
	
	var parent:GraphicObject;
	
	var sheet:BitmapData;
	var rect:Rectangle = new Rectangle();
	var pt:Point = new Point();
	
	var timerMax:Float = 0.1;
	var timer:Float = 0;
	
	var isPlaying:Bool = false;
	
	var qty:Int = 3;
	var frameRow:Int = 0;
	var frameCol:Int = 0;
	
	public function new(parent:GraphicObject) 
	{
		this.parent = parent;
		sheet = parent.getSheet();
	}
	
	public function update():Void {
		if (!isPlaying)	return;
		
		if (timer > 0) {
			timer -= GameTime.deltaTime;
			return;
		}
		timer = timerMax;
		
		nextFrame();
	}
	
	function setFrame(row:Int, col:Int):Void {
		frameRow = row;
		frameCol = col;
	}
	
	public function play():Void {
		frameRow = 0;
		frameCol = 2;
		isPlaying = true;
		updateFrame();
	}
	public function stop():Void {
		frameRow = 0;
		frameCol = 1;
		isPlaying = false;
		updateFrame();
	}
	
	function updateFrame():Void {
		parent.setFrame(frameRow, frameCol);
	}
	
	function nextFrame():Void {
		frameCol++;
		if (frameCol > qty)	frameCol = 2;
		updateFrame();
	}
}