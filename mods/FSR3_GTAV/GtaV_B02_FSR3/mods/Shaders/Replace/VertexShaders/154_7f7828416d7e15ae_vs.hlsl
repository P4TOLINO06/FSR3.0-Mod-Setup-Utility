// ---- FNV Hash 7f7828416d7e15ae

// ---- Created with 3Dmigoto v1.3.16 on Sat Nov 11 18:22:14 2023

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

cbuffer rage_clipplanes : register(b0)
{
  float4 ClipPlanes : packoffset(c0);
}



// 3Dmigoto declarations
#define cmp -


void main(
  float3 v0 : POSITION0,
  float4 v1 : BLENDWEIGHT0,
  float4 v2 : BLENDINDICES0,
  float2 v3 : TEXCOORD0,
  float3 v4 : NORMAL0,
  float4 v5 : TANGENT0,
  float4 v6 : COLOR0,
  float4 v7 : COLOR1,
  uint v8 : SV_InstanceID0,
  out float4 o0 : TEXCOORD0,
  out float4 o1 : TEXCOORD1,
  out float4 o2 : TEXCOORD2,
  out float4 o3 : TEXCOORD3,
  out float4 o4 : TEXCOORD4,
  out float4 o5 : TEXCOORD5,
  out float3 o6 : TEXCOORD6,
  out float4 o7 : SV_Position0,
  out float4 o8 : SV_ClipDistance0,
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
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v6.xyz
  float4 r0,r1,r2,r3,r4,r5,r6;
  uint4 bitmask, uiDest;
  float4 fDest;

  o0.xy = v3.xy;
  r0.xyzw = float4(255.001953,255.001953,255.001953,255.001953) * v2.xyzw;
  r0.xyzw = (int4)r0.xyzw;
  r0.xyzw = (int4)r0.xyzw * int4(3,3,3,3);
  r1.xyzw = gBoneMtx[r0.y/3]._m10_m11_m12_m13 * v1.yyyy;
  r1.xyzw = gBoneMtx[r0.x/3]._m10_m11_m12_m13 * v1.xxxx + r1.xyzw;
  r1.xyzw = gBoneMtx[r0.z/3]._m10_m11_m12_m13 * v1.zzzz + r1.xyzw;
  r1.xyzw = gBoneMtx[r0.w/3]._m10_m11_m12_m13 * v1.wwww + r1.xyzw;
  r2.x = dot(r1.xyz, v4.xyz);
  r2.xyz = gWorld._m10_m11_m12 * r2.xxx;
  r3.xyzw = gBoneMtx[r0.y/3]._m00_m01_m02_m03 * v1.yyyy;
  r3.xyzw = gBoneMtx[r0.x/3]._m00_m01_m02_m03 * v1.xxxx + r3.xyzw;
  r3.xyzw = gBoneMtx[r0.z/3]._m00_m01_m02_m03 * v1.zzzz + r3.xyzw;
  r3.xyzw = gBoneMtx[r0.w/3]._m00_m01_m02_m03 * v1.wwww + r3.xyzw;
  r2.w = dot(r3.xyz, v4.xyz);
  r2.xyz = r2.www * gWorld._m00_m01_m02 + r2.xyz;
  r4.xyzw = gBoneMtx[r0.y/3]._m20_m21_m22_m23 * v1.yyyy;
  r4.xyzw = gBoneMtx[r0.x/3]._m20_m21_m22_m23 * v1.xxxx + r4.xyzw;
  r4.xyzw = gBoneMtx[r0.z/3]._m20_m21_m22_m23 * v1.zzzz + r4.xyzw;
  r0.xyzw = gBoneMtx[r0.w/3]._m20_m21_m22_m23 * v1.wwww + r4.xyzw;
  r2.w = dot(r0.xyz, v4.xyz);
  r2.xyz = r2.www * gWorld._m20_m21_m22 + r2.xyz;
  o1.xyz = r2.xyz;
  r4.xyz = v0.xyz;
  r4.w = 1;
  r1.w = dot(r1.xyzw, r4.xyzw);
  r1.x = dot(r1.xyz, v5.xyz);
  r1.xyz = gWorld._m10_m11_m12 * r1.xxx;
  r5.xyz = gWorld._m10_m11_m12 * r1.www;
  r6.xyzw = gWorldViewProj._m10_m11_m12_m13 * r1.wwww;
  r1.w = dot(r3.xyzw, r4.xyzw);
  r2.w = dot(r3.xyz, v5.xyz);
  r1.xyz = r2.www * gWorld._m00_m01_m02 + r1.xyz;
  r0.w = dot(r0.xyzw, r4.xyzw);
  r0.x = dot(r0.xyz, v5.xyz);
  r0.xyz = r0.xxx * gWorld._m20_m21_m22 + r1.xyz;
  r1.xyz = r1.www * gWorld._m00_m01_m02 + r5.xyz;
  r3.xyzw = r1.wwww * gWorldViewProj._m00_m01_m02_m03 + r6.xyzw;
  r3.xyzw = r0.wwww * gWorldViewProj._m20_m21_m22_m23 + r3.xyzw;
  r1.xyz = r0.www * gWorld._m20_m21_m22 + r1.xyz;
  r1.xyz = gWorld._m30_m31_m32 + r1.xyz;
  r3.xyzw = gWorldViewProj._m30_m31_m32_m33 + r3.xyzw;
  o2.xyz = r1.xyz;
  o4.xyz = gViewInverse._m30_m31_m32 + -r1.xyz;
  o2.w = 1;
  o3.xyz = v6.xyz;
  o3.w = 1;
  o5.xyz = r0.xyz;
  r1.xyz = r0.zxy * r2.yzx;
  r0.xyz = r0.yzx * r2.zxy + -r1.xyz;
  o6.xyz = v5.www * r0.xyz;
  o7.xyzw = r3.xyzw;
  o8.x = dot(r3.xyzw, ClipPlanes.xyzw);
  o8.yzw = float3(0,0,0);
  return;
}