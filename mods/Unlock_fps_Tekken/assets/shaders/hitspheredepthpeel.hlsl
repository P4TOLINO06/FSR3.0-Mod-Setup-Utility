
// Depth values in front, used for depth peeling
Texture2D tDepth0 : register(t10);

// The games depth buffer
Texture2D tDepth1 : register(t11);

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
	float peelDepth = tDepth0.Load(int3((int2)IN.position.xy, 0)).r;
	float gameDepth = tDepth1.Load(int3((int2)IN.position.xy, 0)).r;
	
	float currentDepth = (IN.projCoords.z / IN.projCoords.w);
	
	float bias = 1.0f / (float)0xFFFFFF;
	
	// Pixel is behind game object (the character)
	if (currentDepth < gameDepth)
		discard;
	
	// Peeling next layer of transparency
	if (currentDepth + bias >= peelDepth)
		discard;
	
	float thickness = 0.02f;
	float3 f = frac(IN.localPos * 4 * (1 - thickness));
	float3 b = max(f < thickness, f > 1 - thickness);
	float mesh = max(max(b.r, b.g), b.b) * gridIntensity;
	
	if (frontFacing)
		return float4(color.rgb * (1 - mesh), color.a);
	else
		return float4(color.rgb * (1 + mesh), color.a);
}







