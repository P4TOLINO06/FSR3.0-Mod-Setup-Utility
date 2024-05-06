// ---- FNV Hash 241d7d4a2f96f995

// ---- Created with 3Dmigoto v1.3.16 on Sat Nov 11 18:22:14 2023

cbuffer rage_matrices : register(b1)
{
  row_major float4x4 gWorld : packoffset(c0);
  row_major float4x4 gWorldView : packoffset(c4);
  row_major float4x4 gWorldViewProj : packoffset(c8);
  row_major float4x4 gViewInverse : packoffset(c12);
  row_major float4x4 gWorldViewProjUnjittered : packoffset(c16);
  row_major float4x4 gWorldViewProjUnjitteredPrev : packoffset(c20);
}

cbuffer rage_clipplanes : register(b0)
{
  float4 ClipPlanes : packoffset(c0);
}



// 3Dmigoto declarations
#define cmp -


void main(
  float3 v0 : POSITION0,
  float4 v1 : COLOR0,
  float2 v2 : TEXCOORD0,
  float3 v3 : NORMAL0,
  float4 v4 : TANGENT0,
  out float4 o0 : TEXCOORD0,
  out float4 o1 : TEXCOORD1,
  out float4 o2 : TEXCOORD2,
  out float4 o3 : TEXCOORD3,
  out float4 o4 : TEXCOORD4,
  out float4 o5 : TEXCOORD5,
  out float3 o6 : TEXCOORD6,
  out float4 o7 : SV_Position0,
  out float4 o8 : SV_ClipDistance0,
  out float4 pos : POSITION0)
{

  pos.xyzw = float4(v0.xyz, 1);
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v0.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v1.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v2.xy
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v3.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v4.xyzw
  float4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  o0.xy = v2.xy;
  r0.xyz = gWorld._m10_m11_m12 * v3.yyy;
  r0.xyz = v3.xxx * gWorld._m00_m01_m02 + r0.xyz;
  r0.xyz = v3.zzz * gWorld._m20_m21_m22 + r0.xyz;
  o1.xyz = r0.xyz;
  r1.xyz = gWorld._m10_m11_m12 * v0.yyy;
  r1.xyz = v0.xxx * gWorld._m00_m01_m02 + r1.xyz;
  r1.xyz = v0.zzz * gWorld._m20_m21_m22 + r1.xyz;
  r1.xyz = gWorld._m30_m31_m32 + r1.xyz;
  o2.xyz = r1.xyz;
  o4.xyz = gViewInverse._m30_m31_m32 + -r1.xyz;
  o2.w = 1;
  o3.xyz = v1.xyz;
  o3.w = 1;
  r1.xyz = gWorld._m10_m11_m12 * v4.yyy;
  r1.xyz = v4.xxx * gWorld._m00_m01_m02 + r1.xyz;
  r1.xyz = v4.zzz * gWorld._m20_m21_m22 + r1.xyz;
  o5.xyz = r1.xyz;
  r2.xyz = r1.zxy * r0.yzx;
  r0.xyz = r1.yzx * r0.zxy + -r2.xyz;
  o6.xyz = v4.www * r0.xyz;
  r0.xyzw = gWorldViewProj._m10_m11_m12_m13 * v0.yyyy;
  r0.xyzw = v0.xxxx * gWorldViewProj._m00_m01_m02_m03 + r0.xyzw;
  r0.xyzw = v0.zzzz * gWorldViewProj._m20_m21_m22_m23 + r0.xyzw;
  r0.xyzw = gWorldViewProj._m30_m31_m32_m33 + r0.xyzw;
  o7.xyzw = r0.xyzw;
  o8.x = dot(r0.xyzw, ClipPlanes.xyzw);
  o8.yzw = float3(0,0,0);
  return;
}