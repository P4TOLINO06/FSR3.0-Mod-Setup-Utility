// ---- FNV Hash 369a8e591f9fa7b6

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
  float2 v0 : TEXCOORD0,
  uint v1 : SV_InstanceID0,
  out float4 o0 : SV_Position0,
  out float4 o1 : TEXCOORD0,
  out float4 o2 : TEXCOORD1,
  out float4 o3 : TEXCOORD2,
  out float4 o4 : TEXCOORD3,
  out float4 o5 : TEXCOORD5,
  out float4 pos : POSITION0)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v0.xy
// Needs manual fix for instruction:
// unknown dcl_: dcl_input_sgv v1.x, instance_id
  float4 r0,r1,r2,r3,r4,r5;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.w = 1;
  r1.xy = float2(-0.5,-0) + v0.xy;
  r2.xyzw = mad((int4)v1.xxxx, int4(5,5,5,5), int4(1,2,3,4));
  r3.xyz = instanceData[r2.w].yyy * -gViewInverse._m10_m11_m12;
  r1.yzw = r3.xyz * r1.yyy;
  r3.xyz = instanceData[r2.w].xxx * gViewInverse._m00_m01_m02;
  r0.xyz = r1.xxx * r3.xyz + r1.yzw;
  r0.z = instanceData[r2.w].y + r0.z;
  r1.x = (int)v1.x * 5;
  r3.x = instanceData[r1.x].y;
  r3.y = instanceData[r2.x].y;
  r3.z = instanceData[r2.y].y;
  r3.w = instanceData[r2.z].y;
  r3.y = dot(r0.xyzw, r3.xyzw);
  r4.xyzw = gWorldViewProj._m10_m11_m12_m13 * r3.yyyy;
  r5.x = instanceData[r1.x].x;
  r5.y = instanceData[r2.x].x;
  r5.z = instanceData[r2.y].x;
  r5.w = instanceData[r2.z].x;
  r3.x = dot(r0.xyzw, r5.xyzw);
  r4.xyzw = r3.xxxx * gWorldViewProj._m00_m01_m02_m03 + r4.xyzw;
  r5.x = instanceData[r1.x].z;
  r5.y = instanceData[r2.x].z;
  r5.z = instanceData[r2.y].z;
  r5.w = instanceData[r2.z].z;
  r3.z = dot(r0.xyzw, r5.xyzw);
  r0.xyzw = r3.zzzz * gWorldViewProj._m20_m21_m22_m23 + r4.xyzw;
  o3.xyz = r3.xyz;
  pos.xyzw = float4(r3.xyz, 1);
  r1.yz = -vecCameraPos.xy + r3.xy;
  r1.y = dot(r1.yz, r1.yz);
  o0.xyzw = gWorldViewProj._m30_m31_m32_m33 + r0.xyzw;
  r0.x = (uint)instanceData[r1.x].w >> 16;
  r0.y = (uint)instanceData[r1.x].w >> 8;
  r0.xy = (int2)r0.xy & int2(255,255);
  r0.xy = (uint2)r0.xy;
  r1.z = 255 & (int)instanceData[r1.x].w;
  r1.x = (uint)instanceData[r1.x].w >> 24;
  r0.zw = (uint2)r1.zx;
  r0.xyzw = float4(0.00392156886,0.00392156886,0.00392156886,0.00392156886) * r0.xyzw;
  o1.xyz = r0.xyz;
  r0.x = saturate(r1.y * fadeAlphaLOD2DistFar0.y + fadeAlphaLOD2DistFar0.x);
  r0.yz = saturate(r1.yy * fadeAlphaLOD2Dist.yw + fadeAlphaLOD2Dist.xz);
  r1.x = cmp(0 < instanceData[r2.w].z);
  r0.x = r1.x ? r0.x : r0.z;
  r0.y = 1 + -r0.y;
  r0.x = r0.y * r0.x;
  r0.x = r0.w * r0.x;
  o1.w = gAlphaToCoverageScale * r0.x;
  o2.xyz = _fakedGrassNormal.xyz;
  o2.w = v0.x;
  r0.x = v0.y * 0.5 + 0.5;
  o3.w = min(1, r0.x);
  r0.x = (uint)instanceData[r2.x].w >> 16;
  r0.y = (uint)instanceData[r2.x].w >> 8;
  r0.xy = (int2)r0.xy & int2(255,255);
  r0.xy = (uint2)r0.xy;
  r1.x = 255 & (int)instanceData[r2.x].w;
  r1.y = (uint)instanceData[r2.x].w >> 24;
  r0.zw = (uint2)r1.xy;
  r0.xyzw = float4(0.00392156886,0.00392156886,0.00392156886,0.00392156886) * r0.xyzw;
  o4.xyz = r0.xyz;
  o5.x = r0.w;
  o4.w = 0.5 * v0.y;
  o5.yzw = float3(0,0,0);
  return;
}