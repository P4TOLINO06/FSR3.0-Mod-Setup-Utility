// ---- FNV Hash 98b3c6651efb799e

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

cbuffer vehicle_globals : register(b7)
{
  bool switchOn : packoffset(c0);
  bool tyreDeformSwitchOn : packoffset(c0.y);
}

cbuffer vehicle_tyredeformation : register(b8)
{
  float4 tyreDeformParams : packoffset(c0);
  float4 tyreDeformParams2 : packoffset(c1);
}

cbuffer matWheelBuffer : register(b4)
{
  row_major float4x4 matWheelWorld : packoffset(c0);
  row_major float4x4 matWheelWorldViewProj : packoffset(c4);
  row_major float4x4 matWheelWorldViewProjUnjittered : packoffset(c8);
  row_major float4x4 matWheelWorldViewProjUnjitteredPrev : packoffset(c12);
}



// 3Dmigoto declarations
#define cmp -


void main(
  float3 v0 : POSITION0,
  float4 v1 : COLOR0,
  float4 v2 : TEXCOORD0,
  float2 v3 : TEXCOORD1,
  float3 v4 : NORMAL0,
  float4 v5 : TANGENT0,
  out float4 o0 : SV_Position0,
  out float4 o1 : TEXCOORD0,
  out float4 o2 : TEXCOORD1,
  out float4 o3 : TEXCOORD2,
  out float4 o4 : TEXCOORD3,
  out float4 o5 : TEXCOORD4,
  out float3 o6 : TEXCOORD5,
  out float4 pos : POSITION0,
  out uint IsWheel : POSITION1)
{
  IsWheel = 0;
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v0.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v1.xyzw
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v2.xy
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v3.xy
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v4.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v5.xyzw
  float4 r0,r1,r2,r3;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = tyreDeformParams.x * v0.x;
  r0.yzw = matWheelWorld._m10_m11_m12 * v0.yyy;
  r0.yzw = v0.xxx * matWheelWorld._m00_m01_m02 + r0.yzw;
  r0.yzw = v0.zzz * matWheelWorld._m20_m21_m22 + r0.yzw;
  r0.yzw = matWheelWorld._m30_m31_m32 + r0.yzw;
  r1.x = 0.0299999993 + tyreDeformParams2.y;
  r1.y = r1.x + -r0.w;
  r1.x = cmp(r0.w < r1.x);
  r1.y = tyreDeformParams2.z * r1.y;
  r1.y = min(1, r1.y);
  r2.xyz = tyreDeformParams2.www * v0.xyz;
  r1.z = -tyreDeformParams.w * r1.y + r2.x;
  r3.x = r0.x * r1.y + r1.z;
  r0.x = tyreDeformParams2.y + -r0.w;
  o4.xyz = gViewInverse._m30_m31_m32 + -r0.yzw;
  r0.x = max(0, r0.x);
  r3.yz = tyreDeformParams.yz * r0.xx + r2.yz;
  r0.xyz = r1.xxx ? r3.xyz : r2.xyz;
  r0.w = 1.10000002 * tyreDeformParams2.x;
  r0.w = r0.w * r0.w;
  r1.x = dot(v0.yz, v0.yz);
  r1.y = tyreDeformParams2.w * r1.x;
  r0.w = cmp(r0.w < r1.y);
  r0.xyz = r0.www ? r0.xyz : r2.xyz;
  r0.w = tyreDeformParams2.x * tyreDeformParams2.x;
  r0.w = cmp(r0.w < r1.x);
  r0.xyz = r0.www ? r0.xyz : v0.xyz;
  r0.xyz = tyreDeformSwitchOn ? r0.xyz : v0.xyz;
  pos.xyzw = float4(r0.xyz, 1);
  r1.xyzw = matWheelWorldViewProj._m10_m11_m12_m13 * r0.yyyy;
  r1.xyzw = r0.xxxx * matWheelWorldViewProj._m00_m01_m02_m03 + r1.xyzw;
  r0.xyzw = r0.zzzz * matWheelWorldViewProj._m20_m21_m22_m23 + r1.xyzw;
  o0.xyzw = matWheelWorldViewProj._m30_m31_m32_m33 + r0.xyzw;
  o1.xy = v2.xy;
  o1.zw = v3.xy;
  r0.xyz = matWheelWorld._m10_m11_m12 * v4.yyy;
  r0.xyz = v4.xxx * matWheelWorld._m00_m01_m02 + r0.xyz;
  r0.xyz = v4.zzz * matWheelWorld._m20_m21_m22 + r0.xyz;
  o2.xyz = r0.xyz;
  o3.xyzw = v1.xyzw;
  r1.xyz = matWheelWorld._m10_m11_m12 * v5.yyy;
  r1.xyz = v5.xxx * matWheelWorld._m00_m01_m02 + r1.xyz;
  r1.xyz = v5.zzz * matWheelWorld._m20_m21_m22 + r1.xyz;
  o5.xyz = r1.xyz;
  r2.xyz = r1.zxy * r0.yzx;
  r0.xyz = r1.yzx * r0.zxy + -r2.xyz;
  o6.xyz = v5.www * r0.xyz;
  return;
}