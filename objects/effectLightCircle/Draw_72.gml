if (instance_exists(effectLightController))
{
	surface_set_target(effectLightController._surface);
	gpu_set_blendmode(bm_add);
	draw_sprite_ext(sprite_index, 0, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
	gpu_set_blendmode(bm_normal);
	surface_reset_target();
}