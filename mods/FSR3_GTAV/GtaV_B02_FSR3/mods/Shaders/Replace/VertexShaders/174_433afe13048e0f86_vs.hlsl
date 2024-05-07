// ---- FNV Hash 433afe13048e0f86

// ---- Created with 3Dmigoto v1.3.16 on Sat Nov 11 18:22:15 2023

cbuffer _Globals : register(b0)
{
  float EFalloff : packoffset(c0) = {0};
  int EFalloffType : packoffset(c0.y) = {0};
  float EOctaveWeight1 : packoffset(c0.z) = {0.0270000007};
  float EOctaveWeight2 : packoffset(c0.w) = {0.109999999};
  float EOctaveWeight3 : packoffset(c1) = {0.25};
  float EOctaveWeight4 : packoffset(c1.y) = {0.439999998};
  float EOctaveWeight5 : packoffset(c1.z) = {0.699999988};
  float EOctaveWeight6 : packoffset(c1.w) = {1};
  float4 Timer : packoffset(c2);
  float4 ScreenSize : packoffset(c3);
  float AdaptiveQuality : packoffset(c4);
  float4 Weather : packoffset(c5);
  float4 TimeOfDay1 : packoffset(c6);
  float4 TimeOfDay2 : packoffset(c7);
  float ENightDayFactor : packoffset(c8);
  float EInteriorFactor : packoffset(c8.y);
  float4 tempF1 : packoffset(c9);
  float4 tempF2 : packoffset(c10);
  float4 tempF3 : packoffset(c11);
  float4 tempInfo1 : packoffset(c12);
  float4 tempInfo2 : packoffset(c13);
  float4 BloomSize : packoffset(c14);
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
  float2 v1 : TEXCOORD0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : TEXCOORD0,
  out float4 o2 : TEXCOORD1,
  out float4 o3 : TEXCOORD2,
  out float4 pos : POSITION0)
{

  pos.xyzw = float4(v0.xyz, 1);
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v0.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v1.xy
  float4 r0,r1,r2,r3;
  uint4 bitmask, uiDest;
  float4 fDest;

  o0.xyz = v0.xyz;
  o0.w = 1;
  o1.xy = v1.xy;
  r0.x = 1 + -EFalloff;
  r0.x = r0.x * r0.x;
  r1.xyzw = cmp(EFalloffType == int4(1,2,3,4));
  r2.xy = r1.xx ? float2(0.00100000005,0.109999999) : EOctaveWeight1;
  r2.zw = r1.xx ? float2(0.25,0.439999998) : EOctaveWeight3;
  r2.xyzw = r1.yyyy ? float4(0.00999999978,0.200000003,0.600000024,1) : r2.xyzw;
  r2.xyzw = r1.zzzz ? float4(0,0.00999999978,0.200000003,0.600000024) : r2.xyzw;
  r2.xyzw = r1.wwww ? float4(0.0500000007,0.800000012,0.400000006,0.100000001) : r2.xyzw;
  r0.y = cmp(EFalloffType == 5);
  r2.xyzw = r0.yyyy ? float4(0,0.00999999978,-0.300000012,0.699999988) : r2.xyzw;
  r3.xyzw = float4(1,1,1,1) + -r2.xyzw;
  o2.xyzw = r0.xxxx * r3.xyzw + r2.xyzw;
  r0.zw = r1.xx ? float2(0.699999988,1) : EOctaveWeight5;
  r2.xy = r1.yy ? float2(0.600000024,0.100000001) : r0.zw;
  r2.zw = float2(0,0);
  r2.xyzw = r1.zzzz ? float4(0.200000003,0.00999999978,0,0) : r2.xyzw;
  r1.xyzw = r1.wwww ? float4(0.0500000007,0.00999999978,0,0) : r2.xyzw;
  r1.xyzw = r0.yyyy ? float4(0.200000003,0.100000001,0,0) : r1.xyzw;
  r2.xyzw = float4(1,1,1,1) + -r1.xyww;
  o3.xyzw = r0.xxxx * r2.xyzw + r1.xyzw;
  return;
}