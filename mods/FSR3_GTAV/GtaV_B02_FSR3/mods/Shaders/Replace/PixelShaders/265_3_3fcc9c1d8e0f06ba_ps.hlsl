// ---- FNV Hash 3fcc9c1d8e0f06ba

// ---- Created with 3Dmigoto v1.3.16 on Mon Nov 20 02:47:58 2023
Texture2D<float4> t5 : register(t5);

Texture2D<float4> t3 : register(t3);

SamplerState s5_s : register(s5);

SamplerState s3_s : register(s3);

cbuffer cb5 : register(b5)
{
  float4 cb5[37];
}


cbuffer rage_matrices : register(b1)
{
  row_major float4x4 gWorld : packoffset(c0);
  row_major float4x4 gWorldView : packoffset(c4);
  row_major float4x4 gWorldViewProj : packoffset(c8);
  row_major float4x4 gViewInverse : packoffset(c12);
  row_major float4x4 gWorldViewProjUnjittered : packoffset(c16);
  row_major float4x4 gWorldViewProjUnjitteredPrev : packoffset(c20);
}



// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float2 v1 : TEXCOORD0,
  float4 pos : POSITION0,
  out float4 o0 : SV_Target0,
  out float2 motionVectors : SV_Target4)
{

  float4 posCurr = mul(pos.xyzw, gWorldViewProjUnjittered);
  float4 posPrev = mul(pos.xyzw, gWorldViewProjUnjitteredPrev);
  posCurr.xy = posCurr.xy/posCurr.ww;
  posPrev.xy = posPrev.xy/posPrev.ww;
  motionVectors.xy = (posPrev.xy-posCurr.xy) * float2(0.5, -0.5);
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = float2(-0.5,-0.5) + v1.yx;
  r0.z = cmp(0 < cb5[35].y);
  r0.x = r0.z ? abs(r0.x) : abs(r0.y);
  r0.x = r0.x + r0.x;
  r0.y = cb5[35].w + -cb5[35].z;
  r0.x = r0.y * r0.x + cb5[35].z;
  r0.x = r0.x * r0.x;
  r0.x = min(1, r0.x);
  r0.x = cb5[35].x * r0.x;
  r0.y = t3.SampleLevel(s3_s, v1.xy, 0).x;
  r0.y = saturate(r0.y);
  r1.xyz = t5.Sample(s5_s, v1.xy).xyz;
  r0.yzw = r1.xyz * r0.yyy;
  r0.yzw = min(float3(65504,65504,65504), r0.yzw);
  o0.xyz = r0.yzw * r0.xxx;
  o0.w = 0;
  return;
}