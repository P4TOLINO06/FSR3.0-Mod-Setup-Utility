// ---- FNV Hash 15f7926c0be0f876

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

cbuffer grasslocals : register(b10)
{
  float3 vecCameraPos : packoffset(c0);
  float3 vecPlayerPos : packoffset(c1);
  float4 _dimensionLOD2 : packoffset(c2);
  float2 _vecCollParams : packoffset(c3);
  float4 _vecVehColl0B : packoffset(c4);
  float4 _vecVehColl0M : packoffset(c5);
  float4 _vecVehColl0R : packoffset(c6);
  float4 _vecVehColl1B : packoffset(c7);
  float4 _vecVehColl1M : packoffset(c8);
  float4 _vecVehColl1R : packoffset(c9);
  float4 _vecVehColl2B : packoffset(c10);
  float4 _vecVehColl2M : packoffset(c11);
  float4 _vecVehColl2R : packoffset(c12);
  float4 _vecVehColl3B : packoffset(c13);
  float4 _vecVehColl3M : packoffset(c14);
  float4 _vecVehColl3R : packoffset(c15);
  float4 fadeAlphaDistUmTimer : packoffset(c16);
  float4 fadeAlphaLOD1Dist : packoffset(c17);
  float4 fadeAlphaLOD2Dist : packoffset(c18);
  float4 fadeAlphaLOD2DistFar0 : packoffset(c19);
  float4 uMovementParams : packoffset(c20);
  float4 _fakedGrassNormal : packoffset(c21);
  float AlphaScale : packoffset(c22);
  float AlphaTest : packoffset(c22.y);
  float ShadowFalloff : packoffset(c22.z);
  float gAlphaToCoverageScale : packoffset(c22.w);
}

cbuffer grassinstances : register(b5)
{
  float4 instanceData[1280] : packoffset(c0);
}



// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float4 v3 : COLOR1,
  float2 v4 : TEXCOORD0,
  uint v5 : SV_InstanceID0,
  out float4 o0 : SV_Position0,
  out float4 o1 : TEXCOORD0,
  out float4 o2 : TEXCOORD1,
  out float4 o3 : TEXCOORD2,
  out float4 o4 : TEXCOORD3,
  out float4 o5 : TEXCOORD5,
  out float4 pos : POSITION0)
{

  pos.xyzw = float4(v0.xyz, 1);
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v0.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v1.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v3.x
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v4.xy
// Needs manual fix for instruction:
// unknown dcl_: dcl_input_sgv v5.x, instance_id
  float4 r0,r1,r2,r3,r4;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = v0.xyz;
  r0.w = 1;
  r1.x = (int)v5.x * 5;
  r2.x = instanceData[r1.x].y;
  r1.yzw = mad((int3)v5.xxx, int3(5,5,5), int3(1,2,3));
  r2.y = instanceData[r1.y].y;
  r2.z = instanceData[r1.z].y;
  r2.w = instanceData[r1.w].y;
  r2.y = dot(r0.xyzw, r2.xyzw);
  r3.xyzw = gWorldViewProj._m10_m11_m12_m13 * r2.yyyy;
  r4.x = instanceData[r1.x].x;
  r4.y = instanceData[r1.y].x;
  r4.z = instanceData[r1.z].x;
  r4.w = instanceData[r1.w].x;
  r2.x = dot(r0.xyzw, r4.xyzw);
  r3.xyzw = r2.xxxx * gWorldViewProj._m00_m01_m02_m03 + r3.xyzw;
  r4.x = instanceData[r1.x].z;
  r4.y = instanceData[r1.y].z;
  r4.z = instanceData[r1.z].z;
  r4.w = instanceData[r1.w].z;
  r2.z = dot(r0.xyzw, r4.xyzw);
  r0.xyzw = r2.zzzz * gWorldViewProj._m20_m21_m22_m23 + r3.xyzw;
  o3.xyz = r2.xyz;
  r2.xy = -vecCameraPos.xy + r2.xy;
  r1.w = dot(r2.xy, r2.xy);
  r2.xy = saturate(r1.ww * fadeAlphaLOD1Dist.yw + fadeAlphaLOD1Dist.xz);
  o0.xyzw = gWorldViewProj._m30_m31_m32_m33 + r0.xyzw;
  r0.x = (uint)instanceData[r1.x].w >> 16;
  r0.y = (uint)instanceData[r1.x].w >> 8;
  r0.xy = (int2)r0.xy & int2(255,255);
  r0.xy = (uint2)r0.xy;
  r1.w = 255 & (int)instanceData[r1.x].w;
  r0.z = (uint)r1.w;
  r1.w = (uint)instanceData[r1.x].w >> 24;
  r0.w = (uint)r1.w;
  r0.xyzw = float4(0.00392156886,0.00392156886,0.00392156886,0.00392156886) * r0.xyzw;
  o1.xyz = r0.xyz;
  r0.x = 1 + -r2.x;
  r0.x = r0.x * r2.y;
  r0.x = r0.w * r0.x;
  o1.w = gAlphaToCoverageScale * r0.x;
  r0.xyz = instanceData[r1.y].xyz * v1.yyy;
  r0.xyz = v1.xxx * instanceData[r1.x].xyz + r0.xyz;
  r0.xyz = v1.zzz * instanceData[r1.z].xyz + r0.xyz;
  r0.w = dot(r0.xyz, r0.xyz);
  r0.w = rsqrt(r0.w);
  o2.xyz = r0.xyz * r0.www;
  o2.w = v4.x;
  o3.w = v4.y;
  r0.x = (uint)instanceData[r1.y].w >> 16;
  r0.y = (uint)instanceData[r1.y].w >> 8;
  r0.xy = (int2)r0.xy & int2(255,255);
  r0.xy = (uint2)r0.xy;
  r1.x = 255 & (int)instanceData[r1.y].w;
  r1.y = (uint)instanceData[r1.y].w >> 24;
  r0.zw = (uint2)r1.xy;
  r0.xyzw = float4(0.00392156886,0.00392156886,0.00392156886,0.00392156886) * r0.xyzw;
  o4.xyz = r0.xyz;
  o5.x = r0.w;
  o4.w = v3.x;
  o5.yzw = float3(0,0,0);
  return;
}