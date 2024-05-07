// ---- FNV Hash 379ca930a3cd16ca

// ---- Created with 3Dmigoto v1.3.16 on Thu Nov  9 22:13:12 2023

cbuffer rage_matrices : register(b1)
{
  row_major float4x4 gWorld : packoffset(c0);
  row_major float4x4 gWorldView : packoffset(c4);
  row_major float4x4 gWorldViewProj : packoffset(c8);
  row_major float4x4 gViewInverse : packoffset(c12);
  row_major float4x4 gWorldViewProjUnjittered : packoffset(c16);
  row_major float4x4 gWorldViewProjUnjitteredPrev : packoffset(c20);
}

cbuffer scaleform_shaders_locals : register(b11)
{
  float4 UIPosMtx[2] : packoffset(c0);
  float4 UITex0Mtx[2] : packoffset(c2);
  float4 UITex1Mtx[2] : packoffset(c4);
  float4 UIColor : packoffset(c6);
  float4 UIColorXformOffset : packoffset(c7);
  float4 UIColorXformScale : packoffset(c8);
  float UIPremultiplyAlpha : packoffset(c9);
}



// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float2 v1 : TEXCOORD0,
  float4 v2 : COLOR0,
  out float4 o0 : SV_Position0,
  out float2 o1 : TEXCOORD0,
  out float4 o2 : COLOR0,
  out float4 pos : POSITION0)
{

  pos.xyzw = float4(v0.xyz, 1);
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v0.xyzw
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v1.xy
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v2.xyzw
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = dot(v0.xyzw, UIPosMtx[1].xyzw);
  r0.xyzw = gWorldViewProj._m10_m11_m12_m13 * r0.xxxx;
  r1.x = dot(v0.xyzw, UIPosMtx[0].xyzw);
  r0.xyzw = r1.xxxx * gWorldViewProj._m00_m01_m02_m03 + r0.xyzw;
  r0.xyzw = v0.zzzz * gWorldViewProj._m20_m21_m22_m23 + r0.xyzw;
  o0.xyzw = v0.wwww * gWorldViewProj._m30_m31_m32_m33 + r0.xyzw;
  o1.xy = v1.xy;
  o2.xyzw = v2.zyxw;
  return;
}