// ---- FNV Hash 569fce2f67500f2a

// ---- Created with 3Dmigoto v1.3.16 on Sat Nov  4 21:49:46 2023

cbuffer rage_matrices : register(b1)
{
  row_major float4x4 gWorld : packoffset(c0);
  row_major float4x4 gWorldView : packoffset(c4);
  row_major float4x4 gWorldViewProj : packoffset(c8);
  row_major float4x4 gViewInverse : packoffset(c12);
  row_major float4x4 gWorldViewProjUnjittered : packoffset(c16);
  row_major float4x4 gWorldViewProjUnjitteredPrev : packoffset(c20);
}

cbuffer water_globals : register(b4)
{
  float2 gWorldBaseVS : packoffset(c0);
  float4 gFlowParams : packoffset(c1);
  float4 gFlowParams2 : packoffset(c2);
  float4 gWaterAmbientColor : packoffset(c3);
  float4 gWaterDirectionalColor : packoffset(c4);
  float4 gScaledTime : packoffset(c5);
  float4 gOceanParams0 : packoffset(c6);
  float4 gOceanParams1 : packoffset(c7);
  row_major float4x4 gReflectionWorldViewProj : packoffset(c8);
  float4 gFogLight_Debugging : packoffset(c12);
  row_major float4x4 gRefractionWorldViewProj : packoffset(c13);
  float4 gOceanParams2 : packoffset(c17);
}

cbuffer water_locals : register(b11)
{
  float4 OceanLocalParams0 : packoffset(c0);
  float4 FogParams : packoffset(c1);
  float4 QuadAlpha : packoffset(c2);
  float3 CameraPosition : packoffset(c3);
}

Texture2D<float> HeightTexture : register(t0);


// 3Dmigoto declarations
#define cmp -


void main(
  int2 v0 : TEXCOORD0,
  out float4 o0 : SV_Position0,
  out float4 pos : POSITION0)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v0.xy
  float4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = float2(256,256) + gWorldBaseVS.xy;
  r1.xy = (int2)v0.xy;
  r0.zw = gWorld._m30_m31 + r1.xy;
  r0.xy = r0.xy + -r0.zw;
  r0.zw = -gWorldBaseVS.xy + r0.zw;
  r0.zw = float2(0.5,0.5) * r0.zw;
  r2.xy = (int2)r0.zw;
  r0.xy = float2(256,256) + -abs(r0.xy);
  r0.xy = saturate(float2(0.100000001,0.100000001) * r0.xy);
  r0.x = min(r0.x, r0.y);
  r2.zw = float2(0,0);
  r2.x = HeightTexture.Load(r2.xyz).x;
  r0.x = r2.x * r0.x;
  r0.y = cmp(0 < r0.x);
  r0.z = 0.5 * r0.x;
  r0.x = r0.y ? r0.z : r0.x;
  r1.z = -0.25 + r0.x;
  r0.xyz = gWorld._m30_m31_m32 + r1.xyz;
  r0.xyz = -gViewInverse._m30_m31_m32 + r0.xyz;
  r0.w = dot(-gViewInverse._m20_m21_m22, r0.xyz);
  r2.xy = float2(256,256) + r1.xy;
  r2.xy = float2(0.001953125,0.001953125) * r2.xy;
  r2.zw = QuadAlpha.yw + -QuadAlpha.xz;
  r2.xz = r2.xx * r2.zw + QuadAlpha.xz;
  r1.w = r2.z + -r2.x;
  r1.w = r2.y * r1.w + r2.x;
  r1.w = r1.w * r1.w;
  r1.w = 0.209985256 / r1.w;
  r1.w = 0.36787945 * r1.w;
  r0.w = r1.w / abs(r0.w);
  r0.w = 0.00999999978 + r0.w;
  r0.xyz = r0.xyz * r0.www + r1.xyz;
  r0.xyz = float3(-0,-0,-0.200000003) + r0.xyz;
  pos.xyzw = float4(r0.xyz, 1);
  r1.xyzw = gWorldViewProj._m10_m11_m12_m13 * r0.yyyy;
  r1.xyzw = r0.xxxx * gWorldViewProj._m00_m01_m02_m03 + r1.xyzw;
  r0.xyzw = r0.zzzz * gWorldViewProj._m20_m21_m22_m23 + r1.xyzw;
  o0.xyzw = gWorldViewProj._m30_m31_m32_m33 + r0.xyzw;
  return;
}