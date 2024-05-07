
Texture2D tLayer0 : register(t0);
Texture2D tLayer1 : register(t1);
Texture2D tLayer2 : register(t2);
Texture2D tLayer3 : register(t3);
Texture2D tLayer4 : register(t4);
Texture2D tLayer5 : register(t5);

struct VSInput
{
	float4 position : POSITION;
};

struct VSOutput
{
	float4 position : SV_POSITION;
};

VSOutput VSMain(VSInput IN)
{
	VSOutput OUT;
	OUT.position = IN.position;
    return OUT;
}

float4 PSMain(VSOutput IN) : SV_Target0
{
	int3 px = int3((int2)IN.position.xy, 0);
	
	float4 color[6];
	color[0] = tLayer0.Load(px);
	color[1] = tLayer1.Load(px);
	color[2] = tLayer2.Load(px);
	color[3] = tLayer3.Load(px);
	color[4] = tLayer4.Load(px);
	color[5] = tLayer5.Load(px);
	
	float4 final = float4(0, 0, 0, 0);
	final = lerp(final, color[5], color[5].w);
	final = lerp(final, color[4], color[4].w);
	final = lerp(final, color[3], color[3].w);
	final = lerp(final, color[2], color[2].w);
	final = lerp(final, color[1], color[1].w);
	final = lerp(final, color[0], color[0].w);
	
	return final;
}







