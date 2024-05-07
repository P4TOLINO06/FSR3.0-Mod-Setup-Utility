// ---- FNV Hash de2754fff07372e6

// ---- Created with 3Dmigoto v1.3.16 on Mon Nov 13 01:14:14 2023

cbuffer tiled_lighting_locals1 : register(b10)
{
  float4 srcTextureSize : packoffset(c0);
  float4 dstTextureSize : packoffset(c1);
  float tiledPenumbraOffsetValue : packoffset(c2);
  int tileSize : packoffset(c2.y);
  uint4 screenRes : packoffset(c3);
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
  float4 v1 : TEXCOORD0,
  out float4 o0 : SV_Position0,
  out float4 o1 : TEXCOORD0,
  out float4 o2 : TEXCOORD1,
  out float4 o3 : TEXCOORD2,
  out float4 o4 : TEXCOORD3,
  out float4 pos : POSITION0)
{

  pos.xyzw = float4(v0.xyz, 1);
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v0.xy
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v1.xy
  o0.xy = v0.xy;
  o0.zw = float2(0,1);
  o1.xyzw = srcTextureSize.zwzw * float4(-1.5,-0.5,-0.5,-0.5) + v1.xyxy;
  o2.xyzw = srcTextureSize.zwzw * float4(0.5,-0.5,1.5,-0.5) + v1.xyxy;
  o3.xyzw = srcTextureSize.zwzw * float4(-1.5,0.5,-0.5,0.5) + v1.xyxy;
  o4.xyzw = srcTextureSize.zwzw * float4(0.5,0.5,1.5,0.5) + v1.xyxy;
  return;
}