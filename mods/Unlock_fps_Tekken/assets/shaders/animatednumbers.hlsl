
// Sampler already bound by unreal
SamplerState sSampler : register(s0);

Texture2D tTex : register(t0);

struct VSInput
{
	float2 position : POSITION;
	float2 uv : TEXCOORD;
};

struct VSOutput
{
	float4 position : SV_POSITION;
	float2 uv : TEXCOORD0;
};

cbuffer Camera : register(b0)
{
	float4x4 projViewMatrix;
	float4x4 worldMatrix;
	float4 color;
};

VSOutput VSMain(VSInput IN)
{
	VSOutput OUT;
	OUT.position = mul(mul(float4(0, -IN.position.x, -IN.position.y, 1), worldMatrix), projViewMatrix);
	OUT.uv = IN.uv;
    return OUT;
}

float4 PSMain(VSOutput IN) : SV_Target0
{
	float4 tex = tTex.Sample(sSampler, IN.uv);
	return color * float4(1, 1, 1, tex.r);
}







