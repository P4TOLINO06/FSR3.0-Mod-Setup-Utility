// ---- FNV Hash f9071a9694d32165

// ---- Created with 3Dmigoto v1.3.16 on Mon Nov 20 02:47:58 2023
Texture2D<float4> t7 : register(t7);

Texture2D<float4> t2 : register(t2);

SamplerState s7_s : register(s7);

SamplerState s2_s : register(s2);

cbuffer cb2 : register(b2)
{
  float4 cb2[15];
}

cbuffer cb5 : register(b5)
{
  float4 cb5[4];
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
  float4 v0 : TEXCOORD0,
  float3 v1 : TEXCOORD1,
  float4 v2 : SV_Position0,
  float4 v3 : SV_ClipDistance0,
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

  r0.x = cmp(v1.y < v1.x);
  r0.y = 2.86520004 * v1.y;
  r0.y = cmp(v1.x < r0.y);
  r0.x = r0.y ? r0.x : 0;
  r0.y = 2.95910001 * v1.z;
  r0.y = cmp(r0.y < v1.y);
  r0.x = r0.y ? r0.x : 0;
  r0.xyz = r0.xxx ? v1.yyy : v1.xyz;
  r0.w = t2.Sample(s2_s, v0.xy).x;
  r0.w = r0.w * r0.w;
  r0.w = r0.w * r0.w;
  r0.xyz = r0.xyz * r0.www;
  r1.xy = cb5[3].zz + v0.zw;
  r0.w = t7.Sample(s7_s, r1.xy).y;
  r1.xy = float2(1,1) + -cb5[3].yw;
  r0.w = r0.w * r1.x + cb5[3].y;
  r0.xyz = r0.www * r0.xyz;
  r0.w = t7.Sample(s7_s, v0.zw).y;
  r0.w = r0.w * r1.y + cb5[3].w;
  r0.xyz = r0.xyz * r0.www;
  o0.xyz = cb2[14].zzz * r0.xyz;
  o0.w = 1;
  return;
}