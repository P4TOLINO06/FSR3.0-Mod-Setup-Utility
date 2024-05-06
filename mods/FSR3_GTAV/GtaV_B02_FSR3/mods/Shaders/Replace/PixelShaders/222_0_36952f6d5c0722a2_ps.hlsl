// ---- FNV Hash 36952f6d5c0722a2

// ---- Created with 3Dmigoto v1.3.16 on Mon Nov 13 01:20:59 2023

cbuffer rage_matrices : register(b1)
{
  row_major float4x4 gWorld : packoffset(c0);
  row_major float4x4 gWorldView : packoffset(c4);
  row_major float4x4 gWorldViewProj : packoffset(c8);
  row_major float4x4 gViewInverse : packoffset(c12);
  row_major float4x4 gWorldViewProjUnjittered : packoffset(c16);
  row_major float4x4 gWorldViewProjUnjitteredPrev : packoffset(c20);
}

SamplerState TiledLightingSampler_s : register(s6);
Texture2D<float4> TiledLightingSampler : register(t6);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float4 v1 : TEXCOORD0,
  float4 v2 : TEXCOORD1,
  float4 v3 : TEXCOORD2,
  float4 v4 : TEXCOORD3,
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

  r0.xyzw = TiledLightingSampler.Sample(TiledLightingSampler_s, v1.xy).xyzw;
  r1.xyzw = TiledLightingSampler.Sample(TiledLightingSampler_s, v1.zw).xyzw;
  r0.y = r1.x;
  r1.xyzw = TiledLightingSampler.Sample(TiledLightingSampler_s, v2.xy).xyzw;
  r0.z = r1.x;
  r1.xyzw = TiledLightingSampler.Sample(TiledLightingSampler_s, v2.zw).xyzw;
  r0.w = r1.x;
  r1.xyzw = TiledLightingSampler.Sample(TiledLightingSampler_s, v3.xy).xyzw;
  r2.xyzw = TiledLightingSampler.Sample(TiledLightingSampler_s, v3.zw).xyzw;
  r1.y = r2.x;
  r2.xyzw = TiledLightingSampler.Sample(TiledLightingSampler_s, v4.xy).xyzw;
  r1.z = r2.x;
  r2.xyzw = TiledLightingSampler.Sample(TiledLightingSampler_s, v4.zw).xyzw;
  r1.w = r2.x;
  r0.xyzw = min(r1.xyzw, r0.xyzw);
  r0.z = min(r0.z, r0.w);
  r0.y = min(r0.y, r0.z);
  o0.xyzw = min(r0.xxxx, r0.yyyy);
  return;
}