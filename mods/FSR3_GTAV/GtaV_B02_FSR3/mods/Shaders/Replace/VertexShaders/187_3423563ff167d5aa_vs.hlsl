// ---- FNV Hash 3423563ff167d5aa

// ---- Created with 3Dmigoto v1.3.16 on Sat Nov 11 18:22:15 2023

cbuffer rage_bonemtx : register(b4)
{
  row_major float3x4 gBoneMtx[255] : packoffset(c0);
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

cbuffer rage_clipplanes : register(b0)
{
  float4 ClipPlanes : packoffset(c0);
}



// 3Dmigoto declarations
#define cmp -


void main(
  float3 v0 : POSITION0,
  float4 v1 : BLENDWEIGHT0,
  float4 v2 : BLENDINDICES0,
  float2 v3 : TEXCOORD0,
  float3 v4 : NORMAL0,
  float4 v5 : COLOR0,
  out float4 o0 : TEXCOORD0,
  out float4 o1 : TEXCOORD1,
  out float4 o2 : TEXCOORD2,
  out float4 o3 : TEXCOORD3,
  out float4 o4 : TEXCOORD6,
  out float4 o5 : SV_Position0,
  out float4 o6 : SV_ClipDistance0,
  out float4 pos : POSITION0)
{

  pos.xyzw = float4(v0.xyz, 1);
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v0.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v2.z
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v3.xy
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v4.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v5.xyzw
  float4 r0,r1,r2,r3;
  uint4 bitmask, uiDest;
  float4 fDest;

  o0.xy = v3.xy;
  r0.x = 255.001953 * v2.z;
  r0.x = (int)r0.x;
  r0.x = (int)r0.x * 3;
  r0.y = dot(gBoneMtx[r0.x/3]._m10_m11_m12, v4.xyz);
  r0.yzw = gWorld._m10_m11_m12 * r0.yyy;
  r1.x = dot(gBoneMtx[r0.x/3]._m00_m01_m02, v4.xyz);
  r0.yzw = r1.xxx * gWorld._m00_m01_m02 + r0.yzw;
  r1.x = dot(gBoneMtx[r0.x/3]._m20_m21_m22, v4.xyz);
  o1.xyz = r1.xxx * gWorld._m20_m21_m22 + r0.yzw;
  r1.xyz = v0.xyz;
  r1.w = 1;
  r0.y = dot(gBoneMtx[r0.x/3]._m10_m11_m12_m13, r1.xyzw);
  r2.xyz = gWorld._m10_m11_m12 * r0.yyy;
  r3.xyzw = gWorldViewProj._m10_m11_m12_m13 * r0.yyyy;
  r0.y = dot(gBoneMtx[r0.x/3]._m00_m01_m02_m03, r1.xyzw);
  r0.x = dot(gBoneMtx[r0.x/3]._m20_m21_m22_m23, r1.xyzw);
  r1.xyz = r0.yyy * gWorld._m00_m01_m02 + r2.xyz;
  r2.xyzw = r0.yyyy * gWorldViewProj._m00_m01_m02_m03 + r3.xyzw;
  r2.xyzw = r0.xxxx * gWorldViewProj._m20_m21_m22_m23 + r2.xyzw;
  r0.xyz = r0.xxx * gWorld._m20_m21_m22 + r1.xyz;
  r0.xyz = gWorld._m30_m31_m32 + r0.xyz;
  r1.xyzw = gWorldViewProj._m30_m31_m32_m33 + r2.xyzw;
  o2.xyz = r0.xyz;
  o3.xyz = gViewInverse._m30_m31_m32 + -r0.xyz;
  o2.w = 1;
  o4.xyzw = v5.xyzw;
  o5.xyzw = r1.xyzw;
  o6.x = dot(r1.xyzw, ClipPlanes.xyzw);
  o6.yzw = float3(0,0,0);
  return;
}