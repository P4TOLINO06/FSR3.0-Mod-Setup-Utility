// ---- FNV Hash 1ee54dfb9eab9105

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

SamplerState PointSampler1_s : register(s3);
Texture2D<float4> PointTexture1 : register(t3);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float4 v1 : TEXCOORD0,
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

  r0.xyzw = PointTexture1.Gather(PointSampler1_s, v1.xy, int2(-1, -1)).xyzw;
  r0.xy = r0.xy * r0.zw;
  r0.x = r0.x * r0.y;
  r0.x = cmp(r0.x != 0.000000);
  r1.xyzw = PointTexture1.Gather(PointSampler1_s, v1.xy, int2(-1, 1)).xyzw;
  r1.xy = r1.xy * r1.zw;
  r1.x = r1.x * r1.y;
  r0.y = cmp(r1.x != 0.000000);
  r1.xyzw = PointTexture1.Gather(PointSampler1_s, v1.xy, int2(1, 1)).xyzw;
  r1.xy = r1.xy * r1.zw;
  r1.x = r1.x * r1.y;
  r0.z = cmp(r1.x != 0.000000);
  r1.xyzw = PointTexture1.Gather(PointSampler1_s, v1.xy, int2(1, -1)).xyzw;
  r1.xy = r1.xy * r1.zw;
  r1.x = r1.x * r1.y;
  r0.w = cmp(r1.x != 0.000000);
  r0.xyzw = r0.xyzw ? float4(1,1,1,1) : 0;
  r0.xy = r0.xy * r0.zw;
  r0.x = r0.x * r0.y;
  r0.x = cmp(r0.x != 0.000000);
  o0.xyzw = r0.xxxx ? float4(1,1,1,1) : 0;
  return;
}