// ---- FNV Hash 45050d5b8903ba01

// ---- Created with 3Dmigoto v1.3.16 on Mon Nov 13 01:14:14 2023

cbuffer csmshader : register(b6)
{
  float4 gCSMShaderVars_shared[12] : packoffset(c0);
  float4 gCSMDepthBias : packoffset(c12);
  float4 gCSMDepthSlopeBias : packoffset(c13);
  float4 gCSMResolution : packoffset(c14);
  float4 gCSMShadowParams : packoffset(c15);
  row_major float4x4 gLocalLightShadowData[8] : packoffset(c16);
  float4 gShadowTexParam : packoffset(c48);
}

cbuffer cascadeshadows_rendering_locals : register(b11)
{
  row_major float4x4 viewToWorldProjectionParam : packoffset(c0);
  float4 perspectiveShearParam : packoffset(c4);
  float4 shadowParams2 : packoffset(c5);
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
  float4 v0 : POSITION0,
  float2 v1 : TEXCOORD0,
  out float4 o0 : SV_Position0,
  out float4 o1 : TEXCOORD0,
  out float4 o2 : TEXCOORD1,
  out float3 o3 : TEXCOORD2,
  out float4 pos : POSITION0)
{

  pos.xyzw = float4(v0.xyz, 1);
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v0.xyzw
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v1.xy
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  o0.xyzw = v0.xyzw;
  o1.xy = v1.xy;
  r0.xy = v1.xy * float2(2,2) + float2(-1,-1);
  r0.xy = r0.xy * float2(1,-1) + perspectiveShearParam.xy;
  r0.y = viewToWorldProjectionParam._m13 * r0.y;
  r0.x = viewToWorldProjectionParam._m03 * r0.x;
  r0.yzw = viewToWorldProjectionParam._m10_m11_m12 * r0.yyy;
  r0.xyz = r0.xxx * viewToWorldProjectionParam._m00_m01_m02 + r0.yzw;
  r0.xyz = -viewToWorldProjectionParam._m20_m21_m22 + r0.xyz;
  o2.xyz = r0.xyz;
  r1.xyz = gCSMShaderVars_shared[1].xyz * r0.yyy;
  r0.xyw = r0.xxx * gCSMShaderVars_shared[0].xyz + r1.xyz;
  o3.xyz = r0.zzz * gCSMShaderVars_shared[2].xyz + r0.xyw;
  return;
}