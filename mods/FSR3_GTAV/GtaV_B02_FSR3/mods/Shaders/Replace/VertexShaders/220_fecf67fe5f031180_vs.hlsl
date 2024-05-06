// ---- FNV Hash fecf67fe5f031180

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

cbuffer waterTex_locals : register(b11)
{
  float4 WaterBumpParams[2] : packoffset(c0);
  float4 gProjParams : packoffset(c2);
  float4 gFogCompositeParams : packoffset(c3);
  float4 gFogCompositeAmbientColor : packoffset(c4);
  float4 gFogCompositeDirectionalColor : packoffset(c5);
  float4 gFogCompositeTexOffset : packoffset(c6);
  float4 UpdateParams0 : packoffset(c7);
  float4 UpdateParams1 : packoffset(c8);
  float4 UpdateParams2 : packoffset(c9);
  float4 UpdateOffset : packoffset(c10);
}



// 3Dmigoto declarations
#define cmp -


void main(
  float3 v0 : POSITION0,
  float2 v1 : TEXCOORD0,
  out float4 o0 : SV_Position0,
  out float4 o1 : TEXCOORD0,
  out float4 o2 : TEXCOORD1,
  out float4 pos : POSITION0)
{

  pos.xyzw = float4(v0.xyz, 1);
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v0.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v1.xy
  float4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = gWorldViewProj._m10_m11_m12_m13 * v0.yyyy;
  r0.xyzw = v0.xxxx * gWorldViewProj._m00_m01_m02_m03 + r0.xyzw;
  r0.xyzw = gWorldViewProj._m30_m31_m32_m33 + r0.xyzw;
  o0.xyzw = r0.xyzw;
  r0.z = dot(v1.xy, v1.xy);
  r0.z = rsqrt(r0.z);
  r1.xy = v1.xy * r0.zz;
  r1.xy = -r1.xy;
  r1.z = 0;
  r1.zw = r1.yz + -r1.zx;
  r0.z = dot(r1.zw, r1.zw);
  r0.z = rsqrt(r0.z);
  r1.zw = r1.zw * r0.zz;
  r0.xyz = float3(0.5,0.5,0.5) * r0.xwy;
  r2.yw = r0.ww * float2(0.5,0.5) + -r0.zz;
  r2.xz = r0.xx + r0.yy;
  r0.xy = UpdateOffset.xy * float2(0.001953125,0.001953125) + r2.zw;
  o2.xyzw = r2.xyzw;
  r2.y = dot(r0.xy, r1.zw);
  r2.x = dot(r0.xy, r1.xy);
  r0.xy = r2.xy + r2.xy;
  o1.xy = UpdateParams0.yy * float2(1.99999995e-05,0) + r0.xy;
  r0.x = UpdateParams1.z * v0.z;
  o1.zw = UpdateParams0.xx * r0.xx;
  return;
}