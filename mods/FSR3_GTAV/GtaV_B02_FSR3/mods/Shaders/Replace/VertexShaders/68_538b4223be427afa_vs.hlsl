// ---- FNV Hash 538b4223be427afa

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

cbuffer common_locals : register(b13)
{
  float2 tintPaletteSelector : packoffset(c0);
}

cbuffer trees_common_locals : register(b12)
{
  float4 umGlobalParams : packoffset(c0);
  float UseTreeNormals : packoffset(c1);
  float SelfShadowing : packoffset(c1.y);
  float AlphaScale : packoffset(c1.z);
  float AlphaTest : packoffset(c1.w);
  float ShadowFalloff : packoffset(c2);
  float AlphaScaleNormal : packoffset(c2.y);
  float AlphaClampNormal : packoffset(c2.z);
}

SamplerState TintPaletteSampler_s : register(s2);
Texture2D<float4> TintPaletteSampler : register(t2);


// 3Dmigoto declarations
#define cmp -


void main(
  float3 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float4 v3 : COLOR1,
  float2 v4 : TEXCOORD0,
  out float4 o0 : SV_Position0,
  out float4 o1 : COLOR0,
  out float4 o2 : TEXCOORD0,
  out float4 o3 : TEXCOORD1,
  out float4 pos : POSITION0)
{

  pos.xyzw = float4(v0.xyz, 1);
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v0.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v1.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v2.xy
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v3.z
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v4.xy
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = gWorldViewProj._m10_m11_m12_m13 * v0.yyyy;
  r0.xyzw = v0.xxxx * gWorldViewProj._m00_m01_m02_m03 + r0.xyzw;
  r0.xyzw = v0.zzzz * gWorldViewProj._m20_m21_m22_m23 + r0.xyzw;
  o0.xyzw = gWorldViewProj._m30_m31_m32_m33 + r0.xyzw;
  r0.x = v3.z;
  r0.y = tintPaletteSelector.x;
  o1.xyzw = TintPaletteSampler.SampleLevel(TintPaletteSampler_s, r0.xy, 0).xyzw;
  o2.xy = v4.xy;
  o2.zw = v2.xy;
  r0.xyz = gWorld._m10_m11_m12 * v1.yyy;
  r0.xyz = v1.xxx * gWorld._m00_m01_m02 + r0.xyz;
  r0.xyz = v1.zzz * gWorld._m20_m21_m22 + r0.xyz;
  r0.xyz = float3(-0,-0,-1) + r0.xyz;
  r0.xyz = UseTreeNormals * r0.xyz + float3(0,0,1);
  o3.xyz = r0.xyz * float3(0.5,0.5,0.5) + float3(0.5,0.5,0.5);
  o3.w = SelfShadowing;
  return;
}