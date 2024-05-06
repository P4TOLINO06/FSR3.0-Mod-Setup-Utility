// ---- FNV Hash b5c0c6bc1bfac367

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
  float2 v1 : TEXCOORD0,
  float4 v2 : COLOR0,
  out float4 o0 : SV_Position0,
  out float4 pos : POSITION0)
{

  pos.xyzw = float4(v0.xyz, 1);
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v0.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v2.w
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = v2.w * v2.w;
  r0.x = 0.209985256 / r0.x;
  r0.x = 0.36787945 * r0.x;
  r0.yzw = gWorld._m30_m31_m32 + v0.xyz;
  r0.yzw = -gViewInverse._m30_m31_m32 + r0.yzw;
  r1.x = dot(-gViewInverse._m20_m21_m22, r0.yzw);
  r0.x = r0.x / abs(r1.x);
  r0.x = 0.00999999978 + r0.x;
  r0.xyz = r0.yzw * r0.xxx + v0.xyz;
  r0.xyz = float3(-0,-0,-0.200000003) + r0.xyz;
  r1.xyzw = gWorldViewProj._m10_m11_m12_m13 * r0.yyyy;
  r1.xyzw = r0.xxxx * gWorldViewProj._m00_m01_m02_m03 + r1.xyzw;
  r0.xyzw = r0.zzzz * gWorldViewProj._m20_m21_m22_m23 + r1.xyzw;
  o0.xyzw = gWorldViewProj._m30_m31_m32_m33 + r0.xyzw;
  return;
}