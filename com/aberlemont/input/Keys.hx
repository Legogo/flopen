package	com.aberlemont.input;

import openfl.display.Stage;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.ui.Keyboard;

/**
 * @author André Berlemont
 * http://www.andreberlemont.com
 * Github branch : https://github.com/Legogo/flopen.git
 * 
 * http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/ui/Keyboard.html
 */

class Keys
{
	static private var keys:Array<Bool> = new Array<Bool>(); // All keys
	static private var keysPress:Array<UInt> = new Array<UInt>();
	static private var keysRelease:Array<UInt> = new Array<UInt>();
	
	static private var _lastPressed:UInt; // Keycode
	static private var _lastReleased:UInt; // Keycode
	static private var _stage:Stage;
	
	static public function init(s:Stage = null):Bool
	{
		if (_stage != null) {
			if (s == null) return false;
			else return true;
		}
		
		_stage = s;
		
		for (i in 0...255) {
			keys.push(false);
			keysRelease.push(0);
			keysPress.push(0);
		}
		
		toggleKeys(true);
		
		return true;
	}
	
	static private function myKeyDown(e:KeyboardEvent):Void {
		pressKey(e.keyCode);
	}
	
	static private function myKeyUp(e:KeyboardEvent):Void {
		keys[e.keyCode] = false;
		keysRelease[e.keyCode] = 1;
		setLastReleased(e.keyCode);
	}
	
	static public function pressKey(keyCode:UInt):Void {
		if(keysPress[keyCode] <= 0)	keysPress[keyCode] = 1;
		keys[keyCode] = true;
		
		//justPressed.push(e.keyCode);
		setLastPressed(keyCode);
	}
	
	static public function getKeyState(keyCode:UInt):Bool {
		return keys[keyCode];
	}
	static public function getKeyPressState(keyCode:UInt):Bool {
		return (keysPress[keyCode] > 0 && keysRelease[keyCode] == 0);
	}
	static public function getKeyReleaseState(keyCode:UInt):Bool {
		return (!keys[keyCode] && keysRelease[keyCode] > 0);
	}
	
	// Remet toute les touches à false
	static public function clean():Void {
		var i:UInt = 0;
		for (i in 0...keys.length)	keys[i] = false;
		for (i in 0...keysRelease.length)	keysRelease[i] = 0;
	}
	
	static public function update(evt:Event):Void {
		var i:UInt = 0;
		for (i in 0...keysRelease.length)	if(keysRelease[i] > 0)	keysRelease[i]--;
		for (i in 0...keysPress.length)	if(keysPress[i] > 0)	keysPress[i]--;
	}
	
	// Si l'ensemble des touches sont actives ou non
	static public function toggleKeys(active:Bool):Void {
		
		if (!_stage.hasEventListener(KeyboardEvent.KEY_DOWN)) {
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, myKeyDown );
			_stage.addEventListener(KeyboardEvent.KEY_UP, myKeyUp);
			_stage.addEventListener(Event.ENTER_FRAME, update);
		}else if(_stage.hasEventListener(KeyboardEvent.KEY_DOWN)) {
			_stage.removeEventListener(KeyboardEvent.KEY_DOWN, myKeyDown);
			_stage.removeEventListener(KeyboardEvent.KEY_UP, myKeyUp);
			_stage.removeEventListener(Event.ENTER_FRAME, update);
			
			clean();
		}
	}
	
	static public function active():Bool {	return _stage.hasEventListener(KeyboardEvent.KEY_DOWN); }
	
	static private function getLastPressed():UInt { return _lastPressed; }
	static private function setLastPressed(v:UInt):Void { _lastPressed = v; }
	static private function getLastReleased():UInt { return _lastReleased; }
	static private function setLastReleased(v:UInt):Void { _lastReleased = v; }
	
	static public function moveKeysPressed():Bool {
		return (keys[Keyboard.LEFT] || keys[Keyboard.RIGHT] || keys[Keyboard.UP] || keys[Keyboard.DOWN]);
		
	}
}
