// ---- FNV Hash 3a8fa40ef64ef202

// ---- Created with 3Dmigoto v1.3.16 on Sat Nov  4 12:47:49 2023

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
  float4 v2 : TEXCOORD0,
  float2 v3 : TEXCOORD1,
  float3 v4 : NORMAL0,
  float4 v5 : TANGENT0,
  out float4 o0 : COLOR0,
  out float4 o1 : COLOR1,
  out float4 o2 : TEXCOORD0,
  out float4 o3 : TEXCOORD1,
  out float4 o4 : TEXCOORD2,
  out float4 o5 : TEXCOORD3,
  out float4 o6 : TEXCOORD4,
  out float4 o7 : TEXCOORD5,
  out float2 o8 : TEXCOORD6,
  out float4 o9 : SV_Position0,
  out float4 o10 : SV_ClipDistance0,
  out float4 pos : POSITION0)
{

  pos.xyzw = float4(v0.xyz, 1);
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v0.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v2.xy
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v3.xy
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v4.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v5.xyzw
  float4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  o0.xyzw = float4(0,0,0,0);
  o1.xyzw = float4(0,0,0,0);
  o2.xy = v2.xy;
  o2.zw = v3.xy;
  r0.xyz = gWorld._m10_m11_m12 * v4.yyy;
  r0.xyz = v4.xxx * gWorld._m00_m01_m02 + r0.xyz;
  r0.xyz = v4.zzz * gWorld._m20_m21_m22 + r0.xyz;
  r0.w = dot(r0.xyz, r0.xyz);
  r0.w = rsqrt(r0.w);
  r0.xyz = r0.xyz * r0.www;
  r1.xyz = gWorld._m10_m11_m12 * v0.yyy;
  r1.xyz = v0.xxx * gWorld._m00_m01_m02 + r1.xyz;
  r1.xyz = v0.zzz * gWorld._m20_m21_m22 + r1.xyz;
  r1.xyz = gWorld._m30_m31_m32 + r1.xyz;
  r2.xyz = gViewInverse._m30_m31_m32 + -r1.xyz;
  o7.xyz = r1.xyz;
  r0.w = dot(r0.xyz, r2.xyz);
  o6.xyz = r2.xyz;
  r1.x = cmp(0 < r0.w);
  r0.w = cmp(r0.w < 0);
  r0.w = (int)r0.w + (int)-r1.x;
  r0.w = (int)r0.w;
  r0.xyz = r0.xyz * r0.www;
  o3.xyz = r0.xyz;
  r1.xyz = gWorld._m10_m11_m12 * v5.yyy;
  r1.xyz = v5.xxx * gWorld._m00_m01_m02 + r1.xyz;
  r1.xyz = v5.zzz * gWorld._m20_m21_m22 + r1.xyz;
  r0.w = dot(r1.xyz, r1.xyz);
  r0.w = rsqrt(r0.w);
  r1.xyz = r1.xyz * r0.www;
  o4.xyz = r1.xyz;
  r2.xyz = r1.zxy * r0.yzx;
  r0.xyz = r1.yzx * r0.zxy + -r2.xyz;
  o5.xyz = v5.www * r0.xyz;
  o8.xy = float2(1,0);
  r0.xyzw = gWorldViewProj._m10_m11_m12_m13 * v0.yyyy;
  r0.xyzw = v0.xxxx * gWorldViewProj._m00_m01_m02_m03 + r0.xyzw;
  r0.xyzw = v0.zzzz * gWorldViewProj._m20_m21_m22_m23 + r0.xyzw;
  r0.xyzw = gWorldViewProj._m30_m31_m32_m33 + r0.xyzw;
  o9.xyzw = r0.xyzw;
  o10.x = dot(r0.xyzw, ClipPlanes.xyzw);
  o10.yzw = float3(0,0,0);
  return;
}