// ---- FNV Hash 9bb7f73b3adb0220

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

cbuffer water_globals : register(b4)
{
  float2 gWorldBaseVS : packoffset(c0);
  float4 gFlowParams : packoffset(c1);
  float4 gFlowParams2 : packoffset(c2);
  float4 gWaterAmbientColor : packoffset(c3);
  float4 gWaterDirectionalColor : packoffset(c4);
  float4 gScaledTime : packoffset(c5);
  float4 gOceanParams0 : packoffset(c6);
  float4 gOceanParams1 : packoffset(c7);
  row_major float4x4 gReflectionWorldViewProj : packoffset(c8);
  float4 gFogLight_Debugging : packoffset(c12);
  row_major float4x4 gRefractionWorldViewProj : packoffset(c13);
  float4 gOceanParams2 : packoffset(c17);
}



// 3Dmigoto declarations
#define cmp -


void main(
  float3 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float3 v2 : TANGENT0,
  float2 v3 : TEXCOORD0,
  float4 v4 : COLOR0,
  out float4 o0 : SV_Position0,
  out float4 o1 : TEXCOORD0,
  out float4 o2 : TEXCOORD1,
  out float4 o3 : TEXCOORD2,
  out float4 o4 : TEXCOORD3,
  out float4 o5 : TEXCOORD4,
  out float4 pos : POSITION0)
{

  pos.xyzw = float4(v0.xyz, 1);
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v0.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v1.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v2.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v3.xy
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v4.w
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = gWorldViewProj._m10_m11_m12_m13 * v0.yyyy;
  r0.xyzw = v0.xxxx * gWorldViewProj._m00_m01_m02_m03 + r0.xyzw;
  r0.xyzw = v0.zzzz * gWorldViewProj._m20_m21_m22_m23 + r0.xyzw;
  o0.xyzw = gWorldViewProj._m30_m31_m32_m33 + r0.xyzw;
  r0.xyz = gWorld._m10_m11_m12 * v0.yyy;
  r0.xyz = v0.xxx * gWorld._m00_m01_m02 + r0.xyz;
  r0.xyz = v0.zzz * gWorld._m20_m21_m22 + r0.xyz;
  r0.xyz = gWorld._m30_m31_m32 + r0.xyz;
  o1.xyz = r0.xyz;
  r0.xy = -gWorldBaseVS.xy + r0.xy;
  o5.zw = float2(0.001953125,0.001953125) * r0.xy;
  o1.w = v4.w;
  o2.xyz = v1.xyz;
  o3.xyz = v2.xyz;
  r0.xyz = v2.yzx * v1.zxy;
  r0.xyz = v1.yzx * v2.zxy + -r0.xyz;
  r0.w = dot(r0.xyz, r0.xyz);
  r0.w = rsqrt(r0.w);
  o4.xyz = r0.xyz * r0.www;
  o5.xy = v3.xy;
  return;
}