#ifndef __HAIRSIM_DEBUGDRAWUTILITY__
#define __HAIRSIM_DEBUGDRAWUTILITY__

//---------
// generic

float3 ColorCycle(uint index, uint count)
{
    float t = frac(float(index) / float(count - 1));

	// source: https://www.shadertoy.com/view/4ttfRn
	float3 c = 3.0 * float3(abs(t - 0.5), t.xx) - float3(1.5, 1.0, 2.0);
	return 1.0 - c * c;
}

float3 ColorRamp(uint index, uint count)
{
    float t = 1.0 - frac(float(index) / float(count - 1));

	// source: https://www.shadertoy.com/view/4ttfRn
	float3 c = 2.0 * t - float3(0.0, 1.0, 2.0);
	return 1.0 - c * c;
}

//------------
// quantities

float3 ColorDensity(float rho)
{
	return saturate(rho).xxx;
}

float3 ColorDivergence(float div)
{
    if (div < 0.0)// inward flux (increases pressure)
        return saturate(float3(-div, -div, 0.0));
    else
        return saturate(float3(0.0, div, div));
}

float3 ColorPressure(float p)
{
	p *= 1000.0;
	if (p > 0.0)
		return saturate(float3(p, 0.0, 0.0));
	else
		return saturate(float3(0.0, 0.0, -p));
}

float3 ColorGradient(float3 n)
{
	float d = dot(n, n);
	if (d > 1e-11)
		return 0.5 + 0.5 * (n * rsqrt(d));
	else
		return 0.0;

	//return (0.5 + 0.5 * normalize(n.xzy));
}

float3 ColorVelocity(float3 v)
{
    return saturate(float3(v.z, 0.0, -v.z));
}

#endif//__HAIRSIM_DEBUGDRAWUTILITY__
