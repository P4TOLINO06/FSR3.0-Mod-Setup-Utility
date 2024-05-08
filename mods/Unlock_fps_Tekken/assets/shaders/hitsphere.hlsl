
struct VSInput
{
	float4 position : POSITION;
};

struct VSOutput
{
	float4 position : SV_POSITION;
	float4 color : TEXCOORD0;
	float3 localPos : TEXCOORD1;
	float3 worldPos : TEXCOORD2;
	float4 projCoords : TEXCOORD3;
};

cbuffer Camera : register(b0)
{
	float4x4 projViewMatrix;
	float4x4 worldMatrixA;
	float4x4 worldMatrixB;
	float4 color;
	float gridIntensity;
};

VSOutput VSMain(VSInput IN)
{
	VSOutput OUT;
	
	float4 pA = mul(float4(IN.position.xyz, 1), worldMatrixA);
	float4 pB = mul(float4(IN.position.xyz, 1), worldMatrixB);
	float4 p = lerp(pA, pB, IN.position.w);
	
	OUT.position = mul(p, projViewMatrix);
	OUT.projCoords = OUT.position;
	OUT.color = float4(1, 1, 1, 1);
	OUT.localPos = IN.position.xyz;
	OUT.worldPos = p.xyz;
    return OUT;
}

float4 PSMain(VSOutput IN, bool frontFacing : SV_IsFrontFace) : SV_Target0
{
	return float4(color.rgb * 0.2f, color.a);
}







