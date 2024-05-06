// ---- FNV Hash ff86967a4cf2c404

// ---- Created with 3Dmigoto v1.3.16 on Fri Mar  8 21:28:29 2024

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
  float4 v1 : COLOR0,
  float4 v2 : TEXCOORD0,
  float2 v3 : TEXCOORD1,
  float3 v4 : NORMAL0,
  float4 v5 : TANGENT0,
  out float4 o0 : SV_Position0,
  out float4 o1 : TEXCOORD0,
  out float4 o2 : TEXCOORD1,
  out float4 o3 : TEXCOORD2,
  out float4 o4 : TEXCOORD3,
  out float3 o5 : TEXCOORD4,
  out float4 pos : POSITION0)
{

  pos.xyzw = float4(v0.xyz, 1);
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v0.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v1.xy
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

  r0.xyzw = gWorldViewProj._m10_m11_m12_m13 * v0.yyyy;
  r0.xyzw = v0.xxxx * gWorldViewProj._m00_m01_m02_m03 + r0.xyzw;
  r0.xyzw = v0.zzzz * gWorldViewProj._m20_m21_m22_m23 + r0.xyzw;
  o0.xyzw = gWorldViewProj._m30_m31_m32_m33 + r0.xyzw;
  o1.xy = v2.xy;
  o1.zw = v3.xy;
  r0.xyz = gWorld._m10_m11_m12 * v4.yyy;
  r0.xyz = v4.xxx * gWorld._m00_m01_m02 + r0.xyz;
  r0.xyz = v4.zzz * gWorld._m20_m21_m22 + r0.xyz;
  o2.xyz = r0.xyz;
  o3.xy = v1.xy;
  r1.xyz = gWorld._m10_m11_m12 * v5.yyy;
  r1.xyz = v5.xxx * gWorld._m00_m01_m02 + r1.xyz;
  r1.xyz = v5.zzz * gWorld._m20_m21_m22 + r1.xyz;
  o4.xyz = r1.xyz;
  r2.xyz = r1.zxy * r0.yzx;
  r0.xyz = r1.yzx * r0.zxy + -r2.xyz;
  o5.xyz = v5.www * r0.xyz;
  return;
}