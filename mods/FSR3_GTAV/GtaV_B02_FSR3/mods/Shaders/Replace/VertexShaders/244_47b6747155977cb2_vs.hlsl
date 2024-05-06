// ---- FNV Hash 47b6747155977cb2

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
  float3 v0 : POSITION0,
  float2 v1 : TEXCOORD0,
  float4 v2 : COLOR0,
  out float4 o0 : SV_Position0,
  out float4 o1 : TEXCOORD0,
  out float4 o2 : TEXCOORD1,
  out float4 o3 : TEXCOORD2,
  out float4 o4 : TEXCOORD3,
  out float4 pos : POSITION0)
{

  pos.xyzw = float4(v0.xyz, 1);
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v0.xyz
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = gWorldViewProj._m10_m11_m12_m13 * v0.yyyy;
  r0.xyzw = v0.xxxx * gWorldViewProj._m00_m01_m02_m03 + r0.xyzw;
  r0.xyzw = v0.zzzz * gWorldViewProj._m20_m21_m22_m23 + r0.xyzw;
  r0.xyzw = gWorldViewProj._m30_m31_m32_m33 + r0.xyzw;
  o0.xyzw = r0.xyzw;
  r0.xyz = float3(0.5,0.5,0.5) * r0.xwy;
  o1.y = r0.w * 0.5 + -r0.z;
  o1.x = r0.x + r0.y;
  o3.w = r0.w;
  r0.xyz = gWorld._m30_m31_m32 + v0.xyz;
  r1.xy = -gWorldBaseVS.xy + r0.xy;
  o1.zw = r1.xy * float2(0.001953125,0.001953125) + float2(0.001953125,0.001953125);
  o2.xyzw = float4(0,0,1,0);
  o3.xyz = r0.xyz;
  r0.zw = -FogParams.xy + r0.xy;
  o4.zw = gWaterAmbientColor.ww * r0.xy;
  r0.xy = FogParams.zw * r0.zw;
  o4.xy = r0.xy * float2(1,-1) + float2(0,1);
  return;
}