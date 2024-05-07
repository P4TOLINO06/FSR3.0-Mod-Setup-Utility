// ---- FNV Hash a1980d482676bc84

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



// 3Dmigoto declarations
#define cmp -


void main(
  float3 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float4 v3 : TEXCOORD0,
  float4 v4 : TEXCOORD1,
  float3 v5 : TEXCOORD2,
  float4 v6 : COLOR1,
  out float4 o0 : SV_Position0,
  out float4 o1 : COLOR0,
  out float4 o2 : TEXCOORD0,
  out float3 o3 : TEXCOORD1,
  out float4 pos : POSITION0)
{

  pos.xyzw = float4(v0.xyz, 1);
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v0.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v1.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v3.xy
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v4.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v5.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v6.xyzw
  float4 r0,r1,r2,r3;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = float3(0,-1,0) * v5.zxy;
  r0.xyz = v5.yzx * float3(-1,0,0) + -r0.xyz;
  r0.w = dot(r0.xy, r0.xy);
  r0.w = rsqrt(r0.w);
  r0.xyz = r0.xyz * r0.www;
  r1.xyz = -v5.yzx * r0.zxy;
  r1.xyz = r0.yzx * -v5.zxy + -r1.xyz;
  r0.w = dot(r1.xyz, r1.xyz);
  r0.w = rsqrt(r0.w);
  r1.xyz = r1.xyz * r0.www;
  r2.xyz = -v5.xyz * v0.yyy;
  r2.xyz = v0.xxx * r0.xyz + r2.xyz;
  r2.xyz = v0.zzz * r1.xyz + r2.xyz;
  r3.x = 0;
  r3.z = v4.z;
  r2.xyz = r3.xxz + r2.xyz;
  r3.xy = v4.xy;
  r3.z = -1;
  r2.xyz = r3.xyz + r2.xyz;
  r3.xyzw = gWorldViewProj._m10_m11_m12_m13 * r2.yyyy;
  r3.xyzw = r2.xxxx * gWorldViewProj._m00_m01_m02_m03 + r3.xyzw;
  r2.xyzw = r2.zzzz * gWorldViewProj._m20_m21_m22_m23 + r3.xyzw;
  o0.xyzw = gWorldViewProj._m30_m31_m32_m33 + r2.xyzw;
  o1.xyzw = v6.xyzw;
  r2.xyz = -v5.xyz * v1.yyy;
  r0.xyz = v1.xxx * r0.xyz + r2.xyz;
  o2.xyz = v1.zzz * r1.xyz + r0.xyz;
  o3.xy = v3.xy;
  o3.z = v6.w;
  return;
}