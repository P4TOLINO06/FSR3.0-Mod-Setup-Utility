// ---- FNV Hash a0ca63ef90e888d6

// ---- Created with 3Dmigoto v1.3.16 on Sat Nov  4 21:49:46 2023

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

cbuffer vehiclecommonlocals : register(b12)
{
  float3 matDiffuseColor : packoffset(c0);
  float4 matDiffuseColor2 : packoffset(c1);
  float4 TrackAmmoAnimUV : packoffset(c2);
  float4 dirtLevelMod : packoffset(c3);
  float3 dirtColor : packoffset(c4);
  float specularFresnel : packoffset(c4.w);
  float specularFalloffMult : packoffset(c5);
  float specularIntensityMult : packoffset(c5.y);
  float3 specMapIntMask : packoffset(c6);
  float bumpiness : packoffset(c6.w);
  float reflectivePower : packoffset(c7);
  float envEffThickness : packoffset(c7.y);
  float2 envEffScale : packoffset(c7.z);
  float envEffTexTileUV : packoffset(c8);
}



// 3Dmigoto declarations
#define cmp -


void main(
  float3 v0 : POSITION0,
  float4 v1 : BLENDWEIGHT0,
  float4 v2 : BLENDINDICES0,
  float4 v3 : TEXCOORD0,
  float2 v4 : TEXCOORD1,
  float3 v5 : NORMAL0,
  float4 v6 : TANGENT0,
  float4 v7 : COLOR0,
  out float4 o0 : SV_Position0,
  out float4 o1 : TEXCOORD0,
  out float4 o2 : TEXCOORD1,
  out float4 o3 : TEXCOORD2,
  out float4 o4 : TEXCOORD3,
  out float4 o5 : TEXCOORD4,
  out float3 o6 : TEXCOORD5,
  out float4 pos : POSITION0)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v0.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v2.z
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v3.xy
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v4.xy
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v5.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v6.xyzw
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v7.xyzw
  float4 r0,r1,r2,r3;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = v0.xyz;
  r0.w = 1;
  r1.x = 255.001953 * v2.z;
  r1.x = (int)r1.x;
  r1.x = (int)r1.x * 3;
  r1.y = dot(gBoneMtx[r1.x/3]._m10_m11_m12_m13, r0.xyzw);
  float3 temp;
  temp.y = r1.y;
  r2.xyzw = gWorldViewProj._m10_m11_m12_m13 * r1.yyyy;
  r1.yzw = gWorld._m10_m11_m12 * r1.yyy;
  r3.x = dot(gBoneMtx[r1.x/3]._m00_m01_m02_m03, r0.xyzw);
  r0.x = dot(gBoneMtx[r1.x/3]._m20_m21_m22_m23, r0.xyzw);
  temp.x = r3.x;
  r2.xyzw = r3.xxxx * gWorldViewProj._m00_m01_m02_m03 + r2.xyzw;
  r0.yzw = r3.xxx * gWorld._m00_m01_m02 + r1.yzw;
  r0.yzw = r0.xxx * gWorld._m20_m21_m22 + r0.yzw;
  temp.z = r0.x;
  r2.xyzw = r0.xxxx * gWorldViewProj._m20_m21_m22_m23 + r2.xyzw;
  pos.xyzw = float4(temp.xyz, 1);
  o0.xyzw = gWorldViewProj._m30_m31_m32_m33 + r2.xyzw;
  r0.xyz = gWorld._m30_m31_m32 + r0.yzw;
  o4.xyz = gViewInverse._m30_m31_m32 + -r0.xyz;
  r0.x = cmp(0 < v0.x);
  r0.x = r0.x ? 1.000000 : 0;
  r0.yz = TrackAmmoAnimUV.xy + v3.xx;
  r0.y = r0.y + -r0.z;
  o1.x = r0.x * r0.y + r0.z;
  o1.y = v3.y;
  o1.zw = v4.xy;
  r0.x = dot(gBoneMtx[r1.x/3]._m10_m11_m12, v5.xyz);
  r0.xyz = gWorld._m10_m11_m12 * r0.xxx;
  r0.w = dot(gBoneMtx[r1.x/3]._m00_m01_m02, v5.xyz);
  r0.xyz = r0.www * gWorld._m00_m01_m02 + r0.xyz;
  r0.w = dot(gBoneMtx[r1.x/3]._m20_m21_m22, v5.xyz);
  r0.xyz = r0.www * gWorld._m20_m21_m22 + r0.xyz;
  o2.xyz = r0.xyz;
  o3.xyzw = v7.xyzw;
  r0.w = dot(gBoneMtx[r1.x/3]._m10_m11_m12, v6.xyz);
  r1.yzw = gWorld._m10_m11_m12 * r0.www;
  r0.w = dot(gBoneMtx[r1.x/3]._m00_m01_m02, v6.xyz);
  r1.x = dot(gBoneMtx[r1.x/3]._m20_m21_m22, v6.xyz);
  r1.yzw = r0.www * gWorld._m00_m01_m02 + r1.yzw;
  r1.xyz = r1.xxx * gWorld._m20_m21_m22 + r1.yzw;
  o5.xyz = r1.xyz;
  r2.xyz = r1.zxy * r0.yzx;
  r0.xyz = r1.yzx * r0.zxy + -r2.xyz;
  o6.xyz = v6.www * r0.xyz;
  return;
}