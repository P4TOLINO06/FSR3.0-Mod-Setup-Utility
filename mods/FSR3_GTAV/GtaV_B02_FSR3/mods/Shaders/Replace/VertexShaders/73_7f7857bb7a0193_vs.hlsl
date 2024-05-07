// ---- FNV Hash 7f7857bb7a0193

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
  float4 v1 : COLOR0,
  float4 v2 : TEXCOORD0,
  float4 v3 : TEXCOORD1,
  float4 v4 : TEXCOORD2,
  float2 v5 : TEXCOORD3,
  float3 v6 : NORMAL0,
  float4 v7 : TANGENT0,
  uint v8 : SV_InstanceID0,
  out float3 o0 : CTRL_POSITION0,
  out uint4 o1 : CTRL_UV_DOMINANT0,
  out float2 o2 : CTRL_UV_AREA0,
  out uint2 o3 : CTRL_TANGENT0,
  out float4 pos : POSITION0)
{

  pos.xyzw = float4(v0.xyz, 1);
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v0.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v1.xyzw
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v2.xy
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v3.xy
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v4.xy
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v5.xy
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v6.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v7.xyzw
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  o0.xyz = v0.xyz;
  r0.xyzw = saturate(v1.xyzw);
  r0.xyzw = float4(255,255,255,255) * r0.xyzw;
  r0.xyzw = (uint4)r0.xyzw;
  r0.y = (uint)r0.y << 8;
  r0.x = (int)r0.x + (int)r0.y;
  r0.y = (uint)r0.z << 16;
  r0.z = (uint)r0.w << 24;
  r0.x = (int)r0.x + (int)r0.y;
  o1.x = (int)r0.x + (int)r0.z;
  r0.xy = float2(8,8) + v2.xy;
  r0.xy = saturate(float2(0.0625,0.0625) * r0.xy);
  r0.xy = float2(65535,65535) * r0.xy;
  r0.xy = (uint2)r0.xy;
  r0.y = (uint)r0.y << 16;
  o1.y = (int)r0.x + (int)r0.y;
  r0.xy = float2(8,8) + v3.xy;
  r0.xy = saturate(float2(0.0625,0.0625) * r0.xy);
  r0.xy = float2(65535,65535) * r0.xy;
  r0.xy = (uint2)r0.xy;
  r0.y = (uint)r0.y << 16;
  o1.z = (int)r0.x + (int)r0.y;
  r0.xy = float2(8,8) + v4.xy;
  r0.xy = saturate(float2(0.0625,0.0625) * r0.xy);
  r0.xy = float2(65535,65535) * r0.xy;
  r0.xy = (uint2)r0.xy;
  r0.y = (uint)r0.y << 16;
  o1.w = (int)r0.x + (int)r0.y;
  o2.xy = v5.xy;
  r0.xyz = saturate(v7.xyz * float3(0.5,0.5,0.5) + float3(0.5,0.5,0.5));
  r0.xyz = float3(1023,1023,1023) * r0.xyz;
  r0.xyz = (uint3)r0.xyz;
  r0.y = (uint)r0.y << 10;
  r0.x = (int)r0.x + (int)r0.y;
  r0.y = (uint)r0.z << 20;
  r0.x = (int)r0.x + (int)r0.y;
  r0.y = cmp(0 < v7.w);
  r0.y = (uint)r0.y << 30;
  r0.y = (int)r0.y & 0x40000000;
  o3.y = (int)r0.x + (int)r0.y;
  r0.xyz = saturate(v6.xyz * float3(0.5,0.5,0.5) + float3(0.5,0.5,0.5));
  r0.xyz = float3(1023,1023,1023) * r0.xyz;
  r0.xyz = (uint3)r0.xyz;
  r0.y = (uint)r0.y << 10;
  r0.x = (int)r0.x + (int)r0.y;
  r0.y = (uint)r0.z << 20;
  o3.x = (int)r0.x + (int)r0.y;
  return;
}