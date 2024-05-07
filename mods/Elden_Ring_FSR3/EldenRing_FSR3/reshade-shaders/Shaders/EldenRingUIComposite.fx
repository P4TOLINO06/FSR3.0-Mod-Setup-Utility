
#include "ReShade.fxh"

texture UITex : ERUI;
sampler SamplerUI { Texture = UITex; AddressU = Clamp; AddressV = Clamp; MipFilter = Linear; MinFilter = Linear; MagFilter = Linear; };

/*uniform float ERGAMMA <
    ui_category = "Image Settings";
    ui_label = "Gamma Correction";
    ui_max = 1.0;
    ui_min = -1.0;
    ui_step = 0.01;
    ui_tooltip = "Adjust the gamma of the image.";
    ui_type = "slider";
> = 0;*/

uniform bool ERHDR <
    ui_category = "UI Composite Settings";
    ui_label = "Is Using HDR";
    ui_tooltip = "Fix UI for HDR.";
> = false;

uniform float ERUIGAMMA <
    ui_category = "UI Composite Settings";
    ui_label = "UI Gamma Correction";
    ui_max = 1.0;
    ui_min = -1.0;
    ui_step = 0.01;
    ui_tooltip = "Adjust the gamma of the UI when using HDR.";
    ui_type = "slider";
> = 0.45;

/*=============================================================================
	Functions
=============================================================================*/

float3 unpack_hdr(float3 color)
{
    color  = saturate(color);
    color *= color;     
    color = color * rcp(1.04 - saturate(color));       
    return color;
}

float3 pack_hdr(float3 color)
{
    color =  1.04 * color * rcp(color + 1.0);   
    color  = saturate(color);    
    color = sqrt(color);   
    return color;     
}


float3 gamma(float3 color, float g)
{
    return pow(color, g);
}

static const float3x3 BT709_TO_BT2020 = float3x3(  // ref: ARIB STD-B62 and BT.2087
    float3(0.6274, 0.3293, 0.0433), 
	float3(0.0691, 0.9195, 0.0114), 
	float3(0.0164, 0.0880, 0.8956)
);

/*=============================================================================
	Bicubic
=============================================================================*/

float weight(float x)
{
	const float B = 0.333333;
	const float C = 0.333333;

	float ax = abs(x);

	if (ax < 1.0) {
		return (x * x * ((12.0 - 9.0 * B - 6.0 * C) * ax + (-18.0 + 12.0 * B + 6.0 * C)) + (6.0 - 2.0 * B)) / 6.0;
	} else if (ax >= 1.0 && ax < 2.0) {
		return (x * x * ((-B - 6.0 * C) * ax + (6.0 * B + 30.0 * C)) + (-12.0 * B - 48.0 * C) * ax + (8.0 * B + 24.0 * C)) / 6.0;
	} else {
		return 0.0;
	}
}

float4 weight4(float x)
{
	return float4(
		weight(x - 2.0),
		weight(x - 1.0),
		weight(x),
		weight(x + 1.0));
}

float4 Bicubic(float2 uv)
{
	float2 inputSize = BUFFER_SCREEN_SIZE;
	const float2 inputPt = BUFFER_PIXEL_SIZE;

	uv *= inputSize;
	float2 pos1 = floor(uv - 0.5) + 0.5;
	float2 f = uv - pos1;

	float4 rowtaps = weight4(1 - f.x);
	float4 coltaps = weight4(1 - f.y);

	// make sure all taps added together is exactly 1.0, otherwise some (very small) distortion can occur
	rowtaps /= rowtaps.r + rowtaps.g + rowtaps.b + rowtaps.a;
	coltaps /= coltaps.r + coltaps.g + coltaps.b + coltaps.a;

	float2 uv1 = pos1 * inputPt;
	float2 uv0 = uv1 - inputPt;
	float2 uv2 = uv1 + inputPt;
	float2 uv3 = uv2 + inputPt;

	float u_weight_sum = rowtaps.y + rowtaps.z;
	float u_middle_offset = rowtaps.z * inputPt.x / u_weight_sum;
	float u_middle = uv1.x + u_middle_offset;

	float v_weight_sum = coltaps.y + coltaps.z;
	float v_middle_offset = coltaps.z * inputPt.y / v_weight_sum;
	float v_middle = uv1.y + v_middle_offset;

	int2 coord_top_left = int2(max(uv0 * inputSize, 0.5));
	int2 coord_bottom_right = int2(min(uv3 * inputSize, inputSize - 0.5));

	float4 top = tex2Dfetch(SamplerUI, coord_top_left) * rowtaps.x;
	top += tex2Dlod(SamplerUI, float4(u_middle, uv0.y, 0, 0)) * u_weight_sum;
	top += tex2Dfetch(SamplerUI, int2(coord_bottom_right.x, coord_top_left.y)) * rowtaps.w;
	float4 total = top * coltaps.x;

	float4 middle = tex2Dlod(SamplerUI, float4(uv0.x, v_middle, 0, 0)) * rowtaps.x;
	middle += tex2Dlod(SamplerUI, float4(u_middle, v_middle, 0, 0)) * u_weight_sum;
	middle += tex2Dlod(SamplerUI, float4(uv3.x, v_middle, 0, 0)) * rowtaps.w;
	total += middle * v_weight_sum;

	float4 bottom = tex2Dfetch(SamplerUI, int2(coord_top_left.x, coord_bottom_right.y)) * rowtaps.x;
	bottom += tex2Dlod(SamplerUI, float4(u_middle, uv3.y, 0, 0)) * u_weight_sum;
	bottom += tex2Dfetch(SamplerUI, coord_bottom_right) * rowtaps.w;
	total += bottom * coltaps.w;

	return total;
}

void PS_UIComposite(in float4 position : SV_Position, in float2 texcoord : TEXCOORD, out float3 color : SV_Target)
{
	float4 uiColor = tex2D(SamplerUI, texcoord);
	if(ERHDR){
		uiColor.rgb = mul(BT709_TO_BT2020, uiColor.rgb);
		uiColor.rgb = pack_hdr(uiColor.rgb);
		uiColor.rgb = gamma(uiColor.rgb, 1.0+ERUIGAMMA);
	}
	float4 hudlessColor = tex2D(ReShade::BackBuffer, texcoord);
	
	color = lerp(hudlessColor, uiColor, (1-uiColor.a)).rgb;
	/*if(ERGAMMA!=0){
		color = gamma(color, 1.0+ERGAMMA);
	}*/
}

technique EldenRingUpscalerUIComposite <
	ui_tooltip = "This shader is used by Elden Ring Upscaler to do UI composite.\n";
>

{
	pass
	{
		VertexShader = PostProcessVS;
		PixelShader = PS_UIComposite;
	}
}
