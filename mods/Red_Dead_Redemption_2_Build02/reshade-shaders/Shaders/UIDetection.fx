
#include "ReShade.fxh"

texture TexColor : COLOR;
sampler SamplerTexColor {Texture = TexColor; SRGBTexture = false; };

texture HudColor : HUDCOLOR;
sampler SamplerHudColor {Texture = HudColor; SRGBTexture = false; };

texture HudlessTex : HUDLESS;
sampler SamplerHudless { Texture = HudlessTex; SRGBTexture = false; };

texture DetectedUIColor < pooled = false; > { Width = BUFFER_WIDTH; Height = BUFFER_HEIGHT; Format = rgba8; };
sampler SamplerDetectedUIColor { Texture = DetectedUIColor; AddressU = Clamp; AddressV = Clamp; MipFilter = Linear; MinFilter = Linear; MagFilter = Linear; };

uniform bool UIDETECT_DEBUG <
    ui_category = "UI Detection Settings";
    ui_label = "Debug Show Only UI";
    ui_tooltip = "Show Only UI.";
> = false;

uniform bool SHOW_HUDLESS <
    ui_category = "UI Detection Settings";
    ui_label = "Debug Show Hudless";
    ui_tooltip = "Show Only Hudless.";
> = false;

uniform bool SHOW_HUD <
    ui_category = "UI Detection Settings";
    ui_label = "Debug Show Hud";
    ui_tooltip = "Show color with Hud.";
> = false;

uniform float SKIP_BORDER_TOP_LEFT_X <
    ui_category = "UI Detection Settings";
    ui_label = "Skip Border Top Left X";
    ui_max = 1.0;
    ui_min = 0;
    ui_step = 0.001;
    ui_tooltip = "Skip Border Top Left X Coordinate";
    ui_type = "slider";
> = 0.0;

uniform float SKIP_BORDER_TOP_LEFT_Y <
    ui_category = "UI Detection Settings";
    ui_label = "Skip Border Top Left Y";
    ui_max = 1.0;
    ui_min = 0;
    ui_step = 0.001;
    ui_tooltip = "Skip Border Top Left Y Coordinate";
    ui_type = "slider";
> = 0.0;

void PS_UIDetection(in float4 position : SV_Position, in float2 texcoord : TEXCOORD, out float4 color : SV_Target)
{
	float4 hudColor = tex2D(SamplerHudColor, texcoord);
	float4 hudlessColor = tex2D(SamplerHudless, texcoord);
	
	if( (texcoord.x <= SKIP_BORDER_TOP_LEFT_X && texcoord.y <= SKIP_BORDER_TOP_LEFT_Y)
	|| (abs(hudColor.r-hudlessColor.r) < 0.01 && abs(hudColor.g-hudlessColor.g) < 0.01 && abs(hudColor.b-hudlessColor.b) < 0.01))
	{
		color.rgb = 0;
		color.a = 0;
	} else {
		color.rgb = hudColor.rgb;
		color.a = 1;
	}
}


void PS_DebugShowUI(in float4 position : SV_Position, in float2 texcoord : TEXCOORD, out float4 color : SV_Target)
{

	if(UIDETECT_DEBUG){
		if(SHOW_HUDLESS)
			color = tex2D(SamplerHudless, texcoord);
		else if(SHOW_HUD)
			color = tex2D(SamplerHudColor, texcoord);
		else
			color = tex2D(SamplerDetectedUIColor, texcoord);
	} else{
		if(texcoord.x <= SKIP_BORDER_TOP_LEFT_X && texcoord.y <= SKIP_BORDER_TOP_LEFT_Y)
			color = tex2D(SamplerHudColor, texcoord);
		else
			color = tex2D(SamplerTexColor, texcoord);
	}
	
}


technique UIDetection<
	ui_tooltip = "This shader is used by Elden Ring Upscaler to do UI alpha conversion.\n";
>

{
	pass DetectUI
	{
		VertexShader = PostProcessVS;
		PixelShader = PS_UIDetection;
        RenderTarget = DetectedUIColor;
	}
	pass DebugShowResult
	{
		VertexShader = PostProcessVS;
		PixelShader = PS_DebugShowUI;
	}
}
