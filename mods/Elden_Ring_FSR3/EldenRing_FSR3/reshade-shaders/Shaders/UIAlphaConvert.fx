
#include "ReShade.fxh"

texture UITex : ERUI;
sampler SamplerUI { Texture = UITex; AddressU = Clamp; AddressV = Clamp; MipFilter = Linear; MinFilter = Linear; MagFilter = Linear; };

texture ConvertedUIColor < pooled = false; > { Width = BUFFER_WIDTH; Height = BUFFER_HEIGHT; Format = rgba8; };
sampler SamplerConvertedUIColor { Texture = ConvertedUIColor; AddressU = Clamp; AddressV = Clamp; MipFilter = Linear; MinFilter = Linear; MagFilter = Linear; };

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

void PS_UIAlphaConvert(in float4 position : SV_Position, in float2 texcoord : TEXCOORD, out float4 color : SV_Target)
{
	float4 uiColor = tex2D(SamplerUI, texcoord);
	if(ERHDR){
		uiColor.rgb = mul(BT709_TO_BT2020, uiColor.rgb);
		uiColor.rgb = pack_hdr(uiColor.rgb);
		uiColor.rgb = gamma(uiColor.rgb, 1.0+ERUIGAMMA);
	}
	
	color.rgb = uiColor.rgb;
	color.a = 1 - uiColor.a;
}

technique UIAlphaConvert<
	ui_tooltip = "This shader is used by Elden Ring Upscaler to do UI alpha conversion.\n";
>

{
	pass ConvertUIAlpha
	{
		VertexShader = PostProcessVS;
		PixelShader = PS_UIAlphaConvert;
        RenderTarget = ConvertedUIColor;
	}
}
