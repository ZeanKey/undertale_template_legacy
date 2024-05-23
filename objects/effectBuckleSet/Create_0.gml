/// @desc
_counter = 0;
_time = 90;
_clockScaleNum = 0;

Anim_Target(id, "_clockScaleNum", 30, 30, ANIM_TWEEN.SINE);

_clockScaleRad = 100;
_clockScaleRadIdeal = 100;

_clockScaleTinyRad = 0;
_clockScaleTinyRadIdeal = 42;

_rateGlobal = 1;

_blankRingSpinA = {
	_start		: _clockScaleRadIdeal,
	_end		: _clockScaleRadIdeal,
	_idealStart	: 90,
	_idealEnd	: 97
}

_blankRingSpinB = {
	_start		: _clockScaleRadIdeal,
	_end		: _clockScaleRadIdeal,
	_idealStart	: 73,
	_idealEnd	: 75
}

_blankRingSpinC = {
	_start		: 73,
	_end		: 73,
	_idealStart	: 115,
	_idealEnd	: 120
}

_blankRingSpinD = {
	_start		: 0,
	_end		: 0,
	_idealStart	: 50,
	_idealEnd	: 53
}

self._createRing = function (paraStart, paraEnd, paraStartIdeal, paraEndIdeal) constructor
{
	self._start			= paraStart;
	self._end			= paraEnd;
	self._idealStart	= paraStartIdeal;
	self._idealEnd		= paraEndIdeal;
}

self._launchRing = function (paraRing)
{
	Anim_New(paraRing, "_start", ANIM_TWEEN.CUBIC, ANIM_EASE.IN_OUT, paraRing._start, paraRing._idealStart - paraRing._start, _time);
	Anim_New(paraRing, "_end", ANIM_TWEEN.CUBIC, ANIM_EASE.IN_OUT, paraRing._end, paraRing._idealEnd - paraRing._end, _time);
}

Anim_New(id, "_clockScaleRad", ANIM_TWEEN.CUBIC, ANIM_EASE.IN_OUT, _clockScaleRad, _clockScaleRadIdeal - _clockScaleRad, _time);
Anim_New(id, "_clockScaleTinyRad", ANIM_TWEEN.CUBIC, ANIM_EASE.IN_OUT, _clockScaleTinyRad, _clockScaleTinyRadIdeal - _clockScaleTinyRad, _time);

Anim_New(_blankRingSpinA, "_start", ANIM_TWEEN.CUBIC, ANIM_EASE.IN_OUT, _blankRingSpinA._start, _blankRingSpinA._idealStart - _blankRingSpinA._start, _time - 30, 30);
Anim_New(_blankRingSpinA, "_end", ANIM_TWEEN.CUBIC, ANIM_EASE.IN_OUT, _blankRingSpinA._end, _blankRingSpinA._idealEnd - _blankRingSpinA._end, _time - 30, 30);

Anim_New(_blankRingSpinB, "_start", ANIM_TWEEN.CUBIC, ANIM_EASE.IN_OUT, _blankRingSpinB._start, _blankRingSpinB._idealStart - _blankRingSpinB._start, _time);
Anim_New(_blankRingSpinB, "_end", ANIM_TWEEN.CUBIC, ANIM_EASE.IN_OUT, _blankRingSpinB._end, _blankRingSpinB._idealEnd - _blankRingSpinB._end, _time);

self._launchRing(_blankRingSpinC);
self._launchRing(_blankRingSpinD);


_rectSingle = {
	_width	: 3,
	_height : 10
};

_rectSingleTiny = {
	_width	: 1,
	_height : 5
};

self._drawAimTriangle = function (paraPos, paraRads, paraAngle, paraDurAngle)
{
	var RAD_S = paraRads[0];
	var RAD_E = paraRads[1];
	var ANGLE_OFFSET = paraDurAngle / 2;
	var RAD_D = RAD_E - RAD_S;
	var VEC_OFFSET = [	lengthdir_x(RAD_S, paraAngle),
						lengthdir_y(RAD_S, paraAngle)];
	var VEC_1 = [	lengthdir_x(RAD_D, paraAngle - ANGLE_OFFSET),
					lengthdir_y(RAD_D, paraAngle - ANGLE_OFFSET)];
	var VEC_2 = [	lengthdir_x(RAD_D, paraAngle + ANGLE_OFFSET),
					lengthdir_y(RAD_D, paraAngle + ANGLE_OFFSET)];
	
	var POS0_X = paraPos[0] + VEC_OFFSET[0];
	var POS0_Y = paraPos[1] + VEC_OFFSET[1];
	var POS1_X = POS0_X + VEC_1[0];
	var POS1_Y = POS0_Y + VEC_1[1];
	var POS2_X = POS0_X + VEC_2[0];
	var POS2_Y = POS0_Y + VEC_2[1];
	
	draw_triangle(POS0_X, POS0_Y, POS1_X, POS1_Y, POS2_X, POS2_Y, false);
}

self._drawTriangle = function (paraPos, paraRadEnd, paraStart, paraEnd)
{
	var POS1_X, POS1_Y, POS2_X, POS2_Y, POS3_X, POS3_Y;
	var paraBlankAngleStart, paraBlankAngleEnd
	
	if paraEnd > paraStart + 90 
	{
		var COUNTER_FINAL = (paraEnd - paraStart) div 90;
		for (var COUNTER = 0; COUNTER < (paraEnd - paraStart) div 90; COUNTER ++)
		{
			self._drawTriangleRaw(paraPos, paraRadEnd, paraStart + COUNTER * 90, paraStart + COUNTER * 90 + 90);
		}
		self._drawTriangleRaw(paraPos, paraRadEnd, paraStart + COUNTER_FINAL * 90, paraEnd);
	}
	else
	{
		self._drawTriangleRaw(paraPos, paraRadEnd, paraStart, paraEnd);
	}
}

self._drawTriangleRaw = function (paraPos, paraRadEnd, paraStart, paraEnd)
{
	var POS1_X, POS1_Y, POS2_X, POS2_Y, POS3_X, POS3_Y;
	var paraBlankAngleStart, paraBlankAngleEnd
	
	paraBlankAngleStart = paraStart;
	paraBlankAngleEnd	= paraEnd;
	POS1_X = paraPos[0];
	POS1_Y = paraPos[1];
	POS2_X = POS1_X + lengthdir_x(paraRadEnd * 2, paraBlankAngleStart);
	POS2_Y = POS1_Y + lengthdir_y(paraRadEnd * 2, paraBlankAngleStart);
	POS3_X = POS1_X + lengthdir_x(paraRadEnd * 2, paraBlankAngleEnd);
	POS3_Y = POS1_Y + lengthdir_y(paraRadEnd * 2, paraBlankAngleEnd);
		
	draw_triangle(POS1_X, POS1_Y, POS2_X, POS2_Y, POS3_X, POS3_Y, false);
}

self._drawRing = function (paraPos, paraRadStart, paraRadEnd, paraBlanks, paraAlpha, paraColor = c_white)
{
	draw_reset();
	global.SurfaceSetTemporary();
	{
		var ALPHA_ORI = image_alpha;
		draw_set_alpha(1);
		draw_clear_alpha(c_black, 0);
		draw_sprite_ext(sprCircle, 0, paraPos[0], paraPos[1], paraRadEnd / 512, paraRadEnd / 512, 0, paraColor, paraAlpha);
		draw_sprite_ext(sprCircle, 0, paraPos[0], paraPos[1], paraRadStart / 512, paraRadStart / 512, 0, c_black, 1);
		draw_set_color(c_black);
		
		var POS1_X, POS1_Y, POS2_X, POS2_Y, POS3_X, POS3_Y;
		var paraBlankAngleStart, paraBlankAngleEnd;
		
		//draw_set_alpha(1);
		for (var BLANK_COUNT = 0; BLANK_COUNT < array_length(paraBlanks); BLANK_COUNT ++) 
		{
			paraBlankAngleStart = paraBlanks[BLANK_COUNT][0];
			paraBlankAngleEnd	= paraBlanks[BLANK_COUNT][1];
			self._drawTriangle(paraPos, paraRadEnd, paraBlankAngleStart, paraBlankAngleEnd);
		}
		draw_set_alpha(ALPHA_ORI);
	}
	surface_reset_target()
	
	gpu_set_blendmode(bm_add);
	draw_surface_ext(global.TempSurface, 0, 0, 1, 1, 0, -1, paraAlpha);
	gpu_set_blendmode(bm_normal);
}

self._drawClockScales = function(paraPos, paraAngleOffset, paraRadInner, paraSingleSize, paraNums, paraColor, paraAlpha)
{
	var DELTA_ANGLE = 360 / paraNums;
	var RECT_WIDTH = paraSingleSize[0] / 2;
	var CUR_ANGLE, CUR_X_OFFSET, CUR_Y_OFFSET, CUR_X, CUR_Y;
	
	for (var COUNTER = 0; COUNTER < paraNums; COUNTER ++)
	{
		CUR_ANGLE = paraAngleOffset + DELTA_ANGLE * COUNTER;
		CUR_X = paraPos[0] + lengthdir_x(paraRadInner, CUR_ANGLE);
		CUR_Y = paraPos[1] + lengthdir_y(paraRadInner, CUR_ANGLE);
		draw_sprite_ext(sprPixel2, 0, CUR_X, CUR_Y, paraSingleSize[1], RECT_WIDTH, CUR_ANGLE, paraColor, paraAlpha);
	}
}
