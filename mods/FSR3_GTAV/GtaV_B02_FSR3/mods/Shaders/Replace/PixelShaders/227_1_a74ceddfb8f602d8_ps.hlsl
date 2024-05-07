// ---- FNV Hash a74ceddfb8f602d8

// ---- Created with 3Dmigoto v1.3.16 on Mon Nov 13 01:20:59 2023

cbuffer im_cbuffer : register(b5)
{
  float4 TexelSize : packoffset(c0);
  float4 refMipBlurParams : packoffset(c1);
  float4 GeneralParams0 : packoffset(c2);
  float4 GeneralParams1 : packoffset(c3);
  float g_fBilateralCoefficient : packoffset(c4);
  float g_fBilateralEdgeThreshold : packoffset(c4.y);
  float DistantCarAlpha : packoffset(c4.z);
  float4 tonemapColorFilterParams0 : packoffset(c5);
  float4 tonemapColorFilterParams1 : packoffset(c6);
  float4 RenderTexMSAAParam : packoffset(c7);
  float4 RenderPointMapINTParam : packoffset(c8);
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

SamplerState DiffuseSampler_s : register(s2);
SamplerState NoiseSampler_s : register(s7);
Texture2D<float4> DiffuseSampler : register(t2);
Texture2D<float4> NoiseSampler : register(t7);


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
  float4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = DiffuseSampler.Sample(DiffuseSampler_s, v0.xy).xyzw;
  r0.x = r0.x * r0.x;
  r0.x = r0.x * r0.x;
  r0.xyz = v1.xyz * r0.xxx;
  r1.xy = GeneralParams1.zz + v0.zw;
  r1.xyzw = NoiseSampler.Sample(NoiseSampler_s, r1.xy).xyzw;
  r1.xz = float2(1,1) + -GeneralParams1.yw;
  r0.w = r1.y * r1.x + GeneralParams1.y;
  r0.xyz = r0.xyz * r0.www;
  r1.xy = v0.zw * float2(0.001953125,0.001953125) + GeneralParams1.zz;
  r2.xyzw = NoiseSampler.Sample(NoiseSampler_s, r1.xy).xyzw;
  r0.w = r2.y * r1.z + GeneralParams1.w;
  o0.xyz = r0.xyz * r0.www;
  o0.w = 1;
  return;
}