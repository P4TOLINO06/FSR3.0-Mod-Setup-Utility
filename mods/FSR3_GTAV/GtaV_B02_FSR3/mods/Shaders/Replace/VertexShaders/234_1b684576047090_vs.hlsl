// ---- FNV Hash 1b684576047090

// ---- Created with 3Dmigoto v1.3.16 on Mon Nov 13 01:14:14 2023

cbuffer lighting_locals : register(b12)
{
  float4 deferredLightParams[14] : packoffset(c0);
  float4 deferredLightVolumeParams[2] : packoffset(c14);
  float4 deferredLightScreenSize : packoffset(c16);
  float4 deferredProjectionParams : packoffset(c17);
  float3 deferredPerspectiveShearParams0 : packoffset(c18);
  float3 deferredPerspectiveShearParams1 : packoffset(c19);
  float3 deferredPerspectiveShearParams2 : packoffset(c20);
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



// 3Dmigoto declarations
#define cmp -


void main(
  float3 v0 : POSITION0,
  out float4 o0 : SV_Position0,
  out float4 o1 : TEXCOORD0,
  out float4 o2 : TEXCOORD1,
  out float4 pos : POSITION0)
{

  pos.xyzw = float4(v0.xyz, 1);
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v0.xy
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = float2(-0.5,-0.5) + v0.xy;
  o0.xy = r0.xy + r0.xy;
  o0.zw = float2(0,1);
  o1.xy = v0.xy * float2(1,-1) + float2(0,1);
  o1.zw = float2(0,1);
  o2.w = 1;
  r0.xy = v0.xy * float2(2,2) + float2(-1,-1);
  r0.z = 1;
  o2.x = dot(r0.xyz, deferredPerspectiveShearParams0.xyz);
  o2.y = dot(r0.xyz, deferredPerspectiveShearParams1.xyz);
  o2.z = dot(r0.xyz, deferredPerspectiveShearParams2.xyz);
  return;
}