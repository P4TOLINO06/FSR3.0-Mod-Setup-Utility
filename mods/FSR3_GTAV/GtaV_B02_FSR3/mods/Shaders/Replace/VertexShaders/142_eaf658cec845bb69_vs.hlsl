// ---- FNV Hash eaf658cec845bb69

// ---- Created with 3Dmigoto v1.3.16 on Thu Nov  9 22:13:12 2023

cbuffer rage_bonemtx : register(b4)
{
  row_major float3x4 gBoneMtx[255] : packoffset(c0);
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
  float4 v1 : BLENDWEIGHT0,
  float4 v2 : BLENDINDICES0,
  float2 v3 : TEXCOORD0,
  float3 v4 : NORMAL0,
  float4 v5 : COLOR0,
  uint v6 : SV_InstanceID0,
  out float4 o0 : SV_Position0,
  out float4 o1 : TEXCOORD0,
  out float4 o2 : TEXCOORD1,
  out float4 o3 : TEXCOORD3,
  out float4 pos : POSITION0)
{

  pos.xyzw = float4(v0.xyz, 1);
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v0.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v1.xyzw
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v2.xyzw
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v3.xy
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v4.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v5.xyzw
  float4 r0,r1,r2,r3,r4;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = float4(255.001953,255.001953,255.001953,255.001953) * v2.xyzw;
  r0.xyzw = (int4)r0.xyzw;
  r0.xyzw = (int4)r0.xyzw * int4(3,3,3,3);
  r1.xyzw = gBoneMtx[r0.y/3]._m10_m11_m12_m13 * v1.yyyy;
  r1.xyzw = gBoneMtx[r0.x/3]._m10_m11_m12_m13 * v1.xxxx + r1.xyzw;
  r1.xyzw = gBoneMtx[r0.z/3]._m10_m11_m12_m13 * v1.zzzz + r1.xyzw;
  r1.xyzw = gBoneMtx[r0.w/3]._m10_m11_m12_m13 * v1.wwww + r1.xyzw;
  r2.xyz = v0.xyz;
  r2.w = 1;
  r1.w = dot(r1.xyzw, r2.xyzw);
  r1.x = dot(r1.xyz, v4.xyz);
  r1.xyz = gWorld._m10_m11_m12 * r1.xxx;
  r3.xyzw = gWorldViewProj._m10_m11_m12_m13 * r1.wwww;
  r4.xyzw = gBoneMtx[r0.y/3]._m00_m01_m02_m03 * v1.yyyy;
  r4.xyzw = gBoneMtx[r0.x/3]._m00_m01_m02_m03 * v1.xxxx + r4.xyzw;
  r4.xyzw = gBoneMtx[r0.z/3]._m00_m01_m02_m03 * v1.zzzz + r4.xyzw;
  r4.xyzw = gBoneMtx[r0.w/3]._m00_m01_m02_m03 * v1.wwww + r4.xyzw;
  r1.w = dot(r4.xyzw, r2.xyzw);
  r4.x = dot(r4.xyz, v4.xyz);
  r1.xyz = r4.xxx * gWorld._m00_m01_m02 + r1.xyz;
  r3.xyzw = r1.wwww * gWorldViewProj._m00_m01_m02_m03 + r3.xyzw;
  r4.xyzw = gBoneMtx[r0.y/3]._m20_m21_m22_m23 * v1.yyyy;
  r4.xyzw = gBoneMtx[r0.x/3]._m20_m21_m22_m23 * v1.xxxx + r4.xyzw;
  r4.xyzw = gBoneMtx[r0.z/3]._m20_m21_m22_m23 * v1.zzzz + r4.xyzw;
  r0.xyzw = gBoneMtx[r0.w/3]._m20_m21_m22_m23 * v1.wwww + r4.xyzw;
  r0.w = dot(r0.xyzw, r2.xyzw);
  r0.x = dot(r0.xyz, v4.xyz);
  o2.xyz = r0.xxx * gWorld._m20_m21_m22 + r1.xyz;
  r0.xyzw = r0.wwww * gWorldViewProj._m20_m21_m22_m23 + r3.xyzw;
  o0.xyzw = gWorldViewProj._m30_m31_m32_m33 + r0.xyzw;
  o1.xy = v3.xy;
  o3.xyzw = v5.xyzw;
  return;
}