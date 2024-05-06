// ---- FNV Hash e389247892acb77d

// ---- Created with 3Dmigoto v1.3.16 on Sat Nov  4 12:47:49 2023

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

cbuffer ped_common_shared_locals : register(b13)
{
  float4 matWetClothesData : packoffset(c0);
  float4 umPedGlobalOverrideParams : packoffset(c1);
  float4 envEffFatSweatScale : packoffset(c2);
  float paletteSelector : packoffset(c3);
  float2 StubbleGrowth : packoffset(c3.y);
  float4 _matMaterialColorScale[2] : packoffset(c4);
  float4 PedDamageColors[3] : packoffset(c6);
  float4 envEffColorModCpvAdd : packoffset(c9);
  float4 wrinkleMaskStrengths0 : packoffset(c10);
  float4 wrinkleMaskStrengths1 : packoffset(c11);
  float4 wrinkleMaskStrengths2 : packoffset(c12);
  float4 wrinkleMaskStrengths3 : packoffset(c13);
  float4 wrinkleMaskStrengths4 : packoffset(c14);
  float4 wrinkleMaskStrengths5 : packoffset(c15);
  float4 PedDamageData : packoffset(c16);
  float4 wetnessAdjust : packoffset(c17);
  float alphaToCoverageScale : packoffset(c18);
}

cbuffer pedmaterial : register(b9)
{
  float2 envEffFatThickness : packoffset(c0);
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
  float4 v6 : COLOR1,
  uint v7 : SV_InstanceID0,
  out float4 o0 : SV_Position0,
  out float4 o1 : TEXCOORD0,
  out float4 o2 : TEXCOORD1,
  out float4 o3 : TEXCOORD3,
  out float4 pos : POSITION0)
{
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
// unknown dcl_: dcl_input v6.w
  float4 r0,r1,r2,r3,r4,r5;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = float4(255.001953,255.001953,255.001953,255.001953) * v2.xyzw;
  r0.xyzw = (int4)r0.xyzw;
  r0.xyzw = (int4)r0.xyzw * int4(3,3,3,3);
  r1.xyzw = gBoneMtx[r0.y/3]._m00_m01_m02_m03 * v1.yyyy;
  r1.xyzw = gBoneMtx[r0.x/3]._m00_m01_m02_m03 * v1.xxxx + r1.xyzw;
  r1.xyzw = gBoneMtx[r0.z/3]._m00_m01_m02_m03 * v1.zzzz + r1.xyzw;
  r1.xyzw = gBoneMtx[r0.w/3]._m00_m01_m02_m03 * v1.wwww + r1.xyzw;
  r2.x = dot(r1.xyz, v4.xyz);
  r3.xyzw = gBoneMtx[r0.y/3]._m10_m11_m12_m13 * v1.yyyy;
  r3.xyzw = gBoneMtx[r0.x/3]._m10_m11_m12_m13 * v1.xxxx + r3.xyzw;
  r3.xyzw = gBoneMtx[r0.z/3]._m10_m11_m12_m13 * v1.zzzz + r3.xyzw;
  r3.xyzw = gBoneMtx[r0.w/3]._m10_m11_m12_m13 * v1.wwww + r3.xyzw;
  r2.y = dot(r3.xyz, v4.xyz);
  r4.xyzw = gBoneMtx[r0.y/3]._m20_m21_m22_m23 * v1.yyyy;
  r4.xyzw = gBoneMtx[r0.x/3]._m20_m21_m22_m23 * v1.xxxx + r4.xyzw;
  r4.xyzw = gBoneMtx[r0.z/3]._m20_m21_m22_m23 * v1.zzzz + r4.xyzw;
  r0.xyzw = gBoneMtx[r0.w/3]._m20_m21_m22_m23 * v1.wwww + r4.xyzw;
  r2.z = dot(r0.xyz, v4.xyz);
  r4.xyz = envEffFatThickness.yyy * r2.xyz;
  r5.xyz = gWorld._m10_m11_m12 * r2.yyy;
  r2.xyw = r2.xxx * gWorld._m00_m01_m02 + r5.xyz;
  o2.xyz = r2.zzz * gWorld._m20_m21_m22 + r2.xyw;
  r2.xyz = v6.www * r4.xyz;
  r4.xyz = v0.xyz;
  r4.w = 1;
  r1.x = dot(r1.xyzw, r4.xyzw);
  r1.y = dot(r3.xyzw, r4.xyzw);
  r1.z = dot(r0.xyzw, r4.xyzw);
  r0.xyz = r2.xyz * envEffFatSweatScale.zzz + r1.xyz;
  pos.xyzw = float4(r0.xyz, 1);
  r1.xyzw = gWorldViewProj._m10_m11_m12_m13 * r0.yyyy;
  r1.xyzw = r0.xxxx * gWorldViewProj._m00_m01_m02_m03 + r1.xyzw;
  r0.xyzw = r0.zzzz * gWorldViewProj._m20_m21_m22_m23 + r1.xyzw;
  o0.xyzw = gWorldViewProj._m30_m31_m32_m33 + r0.xyzw;
  o1.xy = v3.xy;
  o3.xyzw = v5.xyzw;
  return;
}