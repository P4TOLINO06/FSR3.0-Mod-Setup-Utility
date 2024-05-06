// ---- FNV Hash a3ff8fc954f56573

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

cbuffer rage_clipplanes : register(b0)
{
  float4 ClipPlanes : packoffset(c0);
}

cbuffer rope : register(b10)
{
  float SegmentSize : packoffset(c0);
  float radius : packoffset(c0.y);
  float3 uvScales : packoffset(c1);
  float4 ropeColor : packoffset(c2);
  float4 curveCoeffs[117] : packoffset(c3);
  float4 approxTangent[40] : packoffset(c120);
}



// 3Dmigoto declarations
#define cmp -


void main(
  float3 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : TEXCOORD0,
  float2 v3 : TEXCOORD1,
  out float4 o0 : COLOR0,
  out float4 o1 : TEXCOORD0,
  out float4 o2 : TEXCOORD1,
  out float4 o3 : TEXCOORD4,
  out float4 o4 : TEXCOORD5,
  out float4 o5 : TEXCOORD6,
  out float4 o6 : SV_Position0,
  out float4 o7 : SV_ClipDistance0,
  out float4 pos : POSITION0)
{

  pos.xyzw = float4(v0.xyz, 1);
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v0.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v1.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v2.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v3.xy
  float4 r0,r1,r2,r3,r4,r5;
  uint4 bitmask, uiDest;
  float4 fDest;

  o0.xyz = ropeColor.xyz;
  o0.w = 1;
  o1.xy = uvScales.xy * v3.xy;
  r0.x = SegmentSize * v0.y;
  r0.y = (int)r0.x;
  r0.x = trunc(r0.x);
  r1.y = v0.y * SegmentSize + -r0.x;
  r0.x = (int)r0.y * 3;
  r0.z = 0.00100000005 + r1.y;
  r2.z = r0.z * r0.z;
  r2.w = r2.z * r0.z;
  r1.x = 1;
  r2.xy = float2(0,0.00100000005) + r1.xy;
  r3.x = dot(curveCoeffs[r0.x].xyzw, r2.xyzw);
  r1.z = r1.y * r1.y;
  r1.w = r1.z * r1.y;
  r4.x = dot(curveCoeffs[r0.x].xyzw, r1.xyzw);
  r0.xz = mad((int2)r0.yy, int2(3,3), int2(1,2));
  r3.y = dot(curveCoeffs[r0.x].xyzw, r2.xyzw);
  r3.z = dot(curveCoeffs[r0.z].xyzw, r2.xyzw);
  r4.y = dot(curveCoeffs[r0.x].xyzw, r1.xyzw);
  r4.z = dot(curveCoeffs[r0.z].xyzw, r1.xyzw);
  r0.xzw = -r4.xyz + r3.xyz;
  r1.x = dot(r0.xzw, r0.xzw);
  r1.x = rsqrt(r1.x);
  r0.xzw = r1.xxx * r0.xzw;
  r1.x = (int)r0.y + 1;
  r1.xzw = approxTangent[r1.x].yzx * r1.yyy;
  r1.y = 1 + -r1.y;
  r1.xyz = approxTangent[r0.y].yzx * r1.yyy + r1.xzw;
  r2.xyz = r1.xyz * r0.wxz;
  r1.xyz = r0.zwx * r1.yzx + -r2.xyz;
  r0.y = dot(r1.xyz, r1.xyz);
  r0.y = rsqrt(r0.y);
  r1.xyz = r1.xyz * r0.yyy;
  r2.xyz = r1.zxy * r0.zwx;
  r2.xyz = r1.yzx * r0.wxz + -r2.xyz;
  r0.y = dot(r2.xyz, r2.xyz);
  r0.y = rsqrt(r0.y);
  r2.xyz = r2.xyz * r0.yyy;
  r3.xyz = v1.zzz * r1.xyz;
  r3.xyz = r2.xyz * v1.xxx + r3.xyz;
  r3.xyz = r0.xzw * v1.yyy + r3.xyz;
  r5.xyz = gWorld._m10_m11_m12 * r3.yyy;
  r3.xyw = r3.xxx * gWorld._m00_m01_m02 + r5.xyz;
  r3.xyz = r3.zzz * gWorld._m20_m21_m22 + r3.xyw;
  r0.y = dot(r3.xyz, r3.xyz);
  r0.y = rsqrt(r0.y);
  r3.xyz = r3.xyz * r0.yyy;
  o2.xyz = r3.xyz;
  r5.xyz = v2.zzz * r1.xyz;
  r1.xyz = v0.zzz * r1.xyz;
  r1.xyz = radius * r1.xyz;
  r5.xyz = r2.xyz * v2.xxx + r5.xyz;
  r2.xyz = v0.xxx * r2.xyz;
  r1.xyz = r2.xyz * radius + r1.xyz;
  r1.xyz = r1.xyz + r4.xyz;
  r0.xyz = r0.xzw * v2.yyy + r5.xyz;
  r2.xyz = gWorld._m10_m11_m12 * r0.yyy;
  r0.xyw = r0.xxx * gWorld._m00_m01_m02 + r2.xyz;
  r0.xyz = r0.zzz * gWorld._m20_m21_m22 + r0.xyw;
  r0.w = dot(r0.xyz, r0.xyz);
  r0.w = rsqrt(r0.w);
  r0.xyz = r0.xyz * r0.www;
  o3.xyz = r0.xyz;
  r2.xyz = r3.zxy * r0.yzx;
  r0.xyz = r3.yzx * r0.zxy + -r2.xyz;
  r0.w = dot(r0.xyz, r0.xyz);
  r0.w = rsqrt(r0.w);
  o4.xyz = r0.xyz * r0.www;
  r0.xyz = gWorld._m10_m11_m12 * r1.yyy;
  r0.xyz = r1.xxx * gWorld._m00_m01_m02 + r0.xyz;
  r0.xyz = r1.zzz * gWorld._m20_m21_m22 + r0.xyz;
  o5.xyz = gWorld._m30_m31_m32 + r0.xyz;
  o5.w = 1;
  r0.xyzw = gWorldViewProj._m10_m11_m12_m13 * r1.yyyy;
  r0.xyzw = r1.xxxx * gWorldViewProj._m00_m01_m02_m03 + r0.xyzw;
  r0.xyzw = r1.zzzz * gWorldViewProj._m20_m21_m22_m23 + r0.xyzw;
  r0.xyzw = gWorldViewProj._m30_m31_m32_m33 + r0.xyzw;
  o6.xyzw = r0.xyzw;
  o7.x = dot(r0.xyzw, ClipPlanes.xyzw);
  o7.yzw = float3(0,0,0);
  return;
}