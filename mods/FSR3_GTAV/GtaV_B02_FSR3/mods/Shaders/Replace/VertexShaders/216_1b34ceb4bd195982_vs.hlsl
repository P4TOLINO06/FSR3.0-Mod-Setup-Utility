// ---- FNV Hash 1b34ceb4bd195982

// ---- Created with 3Dmigoto v1.3.16 on Mon Nov 13 01:14:14 2023

cbuffer rage_matrices : register(b1)
{
  row_major float4x4 gWorld : packoffset(c0);
  row_major float4x4 gWorldView : packoffset(c4);
  row_major float4x4 gWorldViewProj : packoffset(c8);
  row_major float4x4 gViewInverse : packoffset(c12);
  row_major float4x4 gWorldViewProjUnjittered : packoffset(c16);
  row_major float4x4 gWorldViewProjUnjitteredPrev : packoffset(c20);
}

cbuffer water_locals : register(b11)
{
  float4 OceanLocalParams0 : packoffset(c0);
  float4 FogParams : packoffset(c1);
  float4 QuadAlpha : packoffset(c2);
  float3 CameraPosition : packoffset(c3);
}



// 3Dmigoto declarations
#define cmp -


void main(
  int4 v0 : TEXCOORD0,
  float v1 : TEXCOORD1,
  uint v2 : SV_InstanceID0,
  out float4 o0 : SV_Position0,
  out float4 o1 : TEXCOORD0,
  out float4 o2 : TEXCOORD1,
  out float4 pos : POSITION0)
{

  pos.xyzw = float4(v0.xyz, 1);
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v0.xy
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v1.x
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = (int2)v0.xy;
  r1.xyzw = gWorldViewProj._m10_m11_m12_m13 * r0.yyyy;
  r1.xyzw = r0.xxxx * gWorldViewProj._m00_m01_m02_m03 + r1.xyzw;
  r1.xyzw = v1.xxxx * gWorldViewProj._m20_m21_m22_m23 + r1.xyzw;
  o0.xyzw = gWorldViewProj._m30_m31_m32_m33 + r1.xyzw;
  r1.xy = -FogParams.xy + r0.xy;
  r0.w = FogParams.z * r1.x;
  o1.y = -r1.y * FogParams.w + 1;
  o1.x = r0.w;
  o1.zw = float2(0,0);
  r0.z = v1.x;
  o2.xyz = -gViewInverse._m30_m31_m32 + r0.xyz;
  o2.w = 0;
  return;
}