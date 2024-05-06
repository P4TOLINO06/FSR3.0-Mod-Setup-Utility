// ---- FNV Hash f48addce86e6816b

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

cbuffer trees_common_locals : register(b12)
{
  float4 umGlobalParams : packoffset(c0);
  float4 treeLod2Params : packoffset(c1);
  float3 treeLod2Normal : packoffset(c2);
  float UseTreeNormals : packoffset(c2.w);
  float SelfShadowing : packoffset(c3);
  float AlphaScale : packoffset(c3.y);
  float AlphaTest : packoffset(c3.z);
  float ShadowFalloff : packoffset(c3.w);
  float AlphaScaleNormal : packoffset(c4);
  float AlphaClampNormal : packoffset(c4.y);
}



// 3Dmigoto declarations
#define cmp -


void main(
  float3 v0 : POSITION0,
  float4 v1 : COLOR0,
  float3 v2 : NORMAL0,
  float4 v3 : TEXCOORD0,
  float4 v4 : TEXCOORD1,
  float4 v5 : TEXCOORD2,
  float2 v6 : TEXCOORD3,
  out float4 o0 : SV_Position0,
  out float4 o1 : TEXCOORD0,
  out float3 o2 : TEXCOORD1,
  out float4 pos : POSITION0)
{

  pos.xyzw = float4(v0.xyz, 1);
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v0.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v1.xy
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v2.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v3.xy
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v4.xy
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v5.xy
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v6.x
  float4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = float3(0,-1,0) * gViewInverse._m22_m20_m21;
  r0.xyz = gViewInverse._m21_m22_m20 * float3(-1,0,0) + -r0.xyz;
  r0.w = dot(r0.xy, r0.xy);
  r0.w = rsqrt(r0.w);
  r0.xyz = r0.xyz * r0.www + -gViewInverse._m00_m01_m02;
  r0.xyz = v6.xxx * r0.xyz + gViewInverse._m00_m01_m02;
  r1.xyz = float3(0,0,-1) + gViewInverse._m10_m11_m12;
  r1.xyz = v6.xxx * r1.xyz + -gViewInverse._m10_m11_m12;
  r2.xy = float2(-0.5,-0.5) + v3.xy;
  r2.zw = treeLod2Params.xy * v5.xy;
  r2.xy = r2.xy * r2.zw;
  r1.xyz = r2.yyy * r1.xyz;
  r0.xyz = r2.xxx * r0.xyz + r1.xyz;
  r0.xyz = v0.xyz + r0.xyz;
  r0.w = dot(r0.xyz, gWorld._m10_m11_m12);
  r1.xyzw = gWorldViewProj._m10_m11_m12_m13 * r0.wwww;
  r0.w = dot(r0.xyz, gWorld._m00_m01_m02);
  r0.x = dot(r0.xyz, gWorld._m20_m21_m22);
  r1.xyzw = r0.wwww * gWorldViewProj._m00_m01_m02_m03 + r1.xyzw;
  r0.xyzw = r0.xxxx * gWorldViewProj._m20_m21_m22_m23 + r1.xyzw;
  o0.xyzw = gWorldViewProj._m30_m31_m32_m33 + r0.xyzw;
  o1.xy = v4.xy;
  o1.zw = v1.xy;
  r0.x = dot(v2.xyz, v2.xyz);
  r0.x = rsqrt(r0.x);
  r0.xyz = v2.xyz * r0.xxx + -treeLod2Normal.xyz;
  o2.xyz = UseTreeNormals * r0.xyz + treeLod2Normal.xyz;
  return;
}