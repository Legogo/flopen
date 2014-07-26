package com.aberlemont.system ;

import openfl.utils.SystemPath;
import sys.FileSystem;
import sys.io.File;
import sys.io.FileInput;

/**
 * ...
 * @author ab&kl
 */
class FileTools
{
	
	static public function getSourcePath():String {
		
		var path:String = SystemPath.applicationDirectory; // neko/bin/
		
		var foundPath:Bool = false;
		
		var idx = path.length;
		var safe:Int = 30;
		if (path.indexOf("\\") > -1) {
			while (!foundPath && idx > 0) {
				while (path.charAt(idx) != "\\"){ idx--; }
				path = path.substr(0, idx);
				foundPath = FileSystem.exists(path + "/LevelDesign");
			}
		}
		
		return path;
	}
	
	static public function getText(filePath:String):String {
		
		if (!FileSystem.exists(filePath)) {
			trace("File " + filePath + " does not exist");
			return null;
		}
		
		var f:FileInput = File.read(filePath, false);
		var content:String = "";
		while (!f.eof()) {
			content += "\n"+f.readLine();
		}
		return content;
	}
	static public function getXml(path:String):Xml {
		return Xml.parse(getText(path));
	}
	
}