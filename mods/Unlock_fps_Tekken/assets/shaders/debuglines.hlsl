
struct VSInput
{
	float3 position : POSITION;
	float4 color : COLOR;
};

struct VSOutput
{
	float4 position : SV_POSITION;
	float4 color : TEXCOORD0;
};

cbuffer Camera : register(b0)
{
	float4x4 projViewMatrix;
	float alpha;
};

VSOutput VSMain(VSInput IN)
{
	VSOutput OUT;
	OUT.position = mul(float4(IN.position, 1), projViewMatrix);
	OUT.color = IN.color;
    return OUT;
}

float4 PSMain(VSOutput IN) : SV_Target0
{
	return IN.color * float4(1, 1, 1, alpha);
}







