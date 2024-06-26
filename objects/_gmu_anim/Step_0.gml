/// @desc Update
var IS_NOT_INST_STRUCT = variable_struct_exists(_inst, _var_name);

if instance_exists(_inst) or IS_NOT_INST_STRUCT or _inst == global
{
	if _delay <= 0
	{
		_time += 1;
		if _time < _duration
		{
			event_user(0);
		}
		else
		{
			if _inst != global
			{
				variable_instance_set(_inst, _var_name, _start + _change);
			}
			else if not IS_NOT_INST_STRUCT
			{
				variable_global_set(_var_name, _start + _change);
			}
			else
			{
				variable_struct_set(_inst, _var_name, _start + _change);
			}
			_finFn();
			instance_destroy();
		}
	}
	else
	{
		_delay -= 1;
	}
}
else
{
	instance_destroy();
}