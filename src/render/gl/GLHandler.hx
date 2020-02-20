package render.gl;

import lime.graphics.RenderContext;
import lime.graphics.WebGLRenderContext;
import lime.graphics.opengl.GLProgram;
import lime.math.Matrix4;
import lime.math.Vector4;
import lime.ui.Window;
import lime.utils.Float32Array;
import lime.graphics.opengl.GL;
import lime.graphics.opengl.GLShader;

import render.gl.programs.GLAutoMap;

import hxdoom.Engine;
import hxdoom.com.Environment;

/**
 * ...
 * @author Kaelan
 * 
 */
class GLHandler 
{
	var gl:WebGLRenderContext;
	var context:RenderContext;
	var window:Window;
	
	var programAutoMap:GLAutoMap;
	
	public function new(_context:RenderContext, _window:Window) 
	{
		gl = _context.webgl;
		window = _window;
		context = _context;
		
		programAutoMap = new GLAutoMap(gl);
	}
	
	public function render_scene() {
		
		gl.viewport(0, 0, window.width, window.height);
		
		if (Environment.IS_IN_AUTOMAP) {
			
			programAutoMap.render(window.width, window.height);
			
		}
	}
}